//
//  LSDAllColumnVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/13.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDAllColumnVC.h"
#import "LSDRefreshFootView.h"
#import "LSDRefreshHeadView.h"
#import "LSDAllColumnNet.h"
#import "LSDAllColumnItem.h"
#import "LSDColumnCell.h"
#import "LSDUser.h"
#import "LSDCommentItem.h"
#import "LSDCommentUserVC.h"
#import "UIStoryboard+VC.h"
#import <SDWebImageManager.h>

@interface LSDAllColumnVC () <LSDColumnCellDelegate>
@property (nonatomic, strong) NSMutableArray *allColumns;
@property (nonatomic, strong) LSDRefreshFootView *footView;
@property (nonatomic, strong) LSDRefreshHeadView *headView;
@property (nonatomic, strong) NSString *maxtime;
@end

@implementation LSDAllColumnVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView
    [self setupTableView];
    //设置自定义刷新控件
    [self setupRefreshUI];
    //设置开始就重新刷新数据
    [self headViewBeginRefresh];
    //监听通知
    [self setNotification];
}

- (void)setupTableView{
    self.tableView.backgroundColor = LSDBackgroundColor;
    //cell穿透整个屏幕效果:1.设置frame为全屏。2.设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(LSD_ContentSet_Top, 0, LSD_ContentSet_bottom, 0);
    //设置滚动条上下边距
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(LSD_ContentSet_Top, 0, LSD_ContentSet_bottom, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //自动计算高度
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 200.f;
}

- (void)setNotification{
    [LSDNotificationCenter addObserver:self selector:@selector(allColumn_repetClickTabBarItemAction:) name:LSDRepetClickTabBarItemNotification object:nil];
    [LSDNotificationCenter addObserver:self selector:@selector(allColumn_repetClickTitleViewBtnAction:) name:LSDRepetClickTitleViewBtnNotification object:nil];
}

- (void)setupRefreshUI{
    //自定义下拉刷新控件
    LSDRefreshHeadView *headView = [[LSDRefreshHeadView alloc] initWithFrame:CGRectMake(0, -LSD_titleViewH, Screen_width, LSD_titleViewH)];
    headView.refreshState = LSDHeadViewNormalRefreshState;
    [self.tableView addSubview:headView];
    self.headView = headView;
    //自定义上拉加载更多控件
    LSDRefreshFootView *footView = [[LSDRefreshFootView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, LSD_titleViewH)];
    footView.refreshState = LSDFootViewNormalOrFinshRefreshState;
    self.tableView.tableFooterView = footView;
    self.footView = footView;
}

#pragma mark - 数据处理
- (void)loadNewData{
    LSDAllColumnNet *allColumnNet = [[LSDAllColumnNet alloc] init];
    [allColumnNet allColumnRequestWithMaxtime:nil successBlock:^(NSMutableArray *allColumns) {
        self.allColumns = allColumns;
        self.maxtime = [allColumnNet getMaxtime];
        [self.tableView reloadData];
        [self headViewEndRefresh];
    } failureBlock:^(NSString *errMessage) {
        [self headViewEndRefresh];
    }];
}

- (void)loadMoreData{
    LSDAllColumnNet *allColumnNet = [[LSDAllColumnNet alloc] init];
    [allColumnNet allColumnRequestWithMaxtime:self.maxtime successBlock:^(NSMutableArray *allColumns) {
        self.maxtime = [allColumnNet getMaxtime];
        [self.allColumns addObjectsFromArray:allColumns];
        [self.tableView reloadData];
        [self footViewEndRefresh];
        
    } failureBlock:^(NSString *errMessage) {
         [self footViewEndRefresh];
    }];
}
#pragma mark - 监听通知
//监听TabBarItem重复点击
- (void)allColumn_repetClickTabBarItemAction:(NSNotification *)noti{
    if (self.view.window == nil) {//当前窗口显示的不是自己所在的模块
        return;
    }
    if (self.tableView.scrollsToTop == NO) {//当前显示的不是自己的View
        return;
    }
    [self headViewBeginRefresh];
}
//监听对应的TitleViewBtn重复点击
- (void)allColumn_repetClickTitleViewBtnAction:(NSNotification *)noti{
    [self allColumn_repetClickTabBarItemAction:noti];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.allColumns.count == 0) {
        self.footView.hidden = YES;
    }else{
        self.footView.hidden = NO;
    }
    return self.allColumns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSDAllColumnItem *columnItem = self.allColumns[indexPath.row];
    
    if (columnItem.top_cmt.count >0) {
        LSDCommentItem *comment = columnItem.top_cmt[0];
        LSDLog(@"%ld--%@--%ld-%@",indexPath.row,comment.user.username,columnItem.top_cmt.count,NSStringFromCGRect(columnItem.commentViewFrame));
    }
    LSDColumnCell *cell = [LSDColumnCell columnCellWithTableView:tableView];
    cell.columnItem = columnItem;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSDAllColumnItem *columnItem = self.allColumns[indexPath.row];
//    LSDLog(@"%ld---%f",indexPath.row,columnItem.cellHeight);
    return columnItem.cellHeight;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self dealHeadView];
    [self dealFootView];
    //在滑动过程中，因为图片太多会导致内存暴涨，所以在滚动过程中清除内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat head_offsetY = -(scrollView.contentInset.top + self.headView.lsd_height);
    if (scrollView.contentOffset.y <=head_offsetY) {//下拉刷新
        [self headViewBeginRefresh];
    }
}

- (void)dealHeadView{
    if (self.footView.isFootViewRefreshing) {//下拉刷新和上拉加载更多只能共存一个
        return;
    }
    if (self.headView.isHeadViewRefreshing) {
        return;
    }
    CGFloat head_offsetY = -(self.tableView.contentInset.top + self.headView.lsd_height);
    if (self.tableView.contentOffset.y <= head_offsetY) {
        self.headView.refreshState = LSDHeadViewWillRefreshState;
    }else{
        self.headView.refreshState = LSDHeadViewNormalRefreshState;
    }
}

- (void)dealFootView{
    if (self.tableView.contentSize.height == 0) {//刚开始tableView还没有数据的时候
        return;
    }
    
    if (self.headView.isHeadViewRefreshing) {//下拉刷新和上拉加载更多只能共存一个
        return;
    }
    if (self.footView.isFootViewRefreshing) {//正在刷新
        return;
    }
    
    //上拉加载更多
    CGFloat foot_offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.view.lsd_height-self.footView.lsd_height;
    if (self.tableView.contentOffset.y >= foot_offsetY && self.tableView.contentOffset.y > -(self.tableView.contentInset.top)) {//footView即将出现并且是上拉
        [self footViewBeginRefresh];
    }

}

#pragma mark - LSDColumnCellDelegate
- (void)columnCell:(LSDColumnCell *)columnCell commentLink:(NSURL *)commentLink{
    LSDCommentUserVC *commentUserVC = (LSDCommentUserVC *)[UIStoryboard controllerWithStoryBoardName:LSDMian identifier:NSStringFromClass([LSDCommentUserVC class])];
    commentUserVC.url = commentLink;
    [self.navigationController pushViewController:commentUserVC animated:YES];
}
#pragma mark - headViewRefresh
//开始下拉刷新
- (void)headViewBeginRefresh{
    if (self.headView.isHeadViewRefreshing) {//正在刷新
        return;
    }
    self.headView.refreshState = LSDHeadViewRefreshingState;
    [UIView animateWithDuration:0.25f animations:^{//设置内边距
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top +=self.headView.lsd_height;
        self.tableView.contentInset = inset;
        
        //偏移量
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -inset.top);
    }];
    
    //发送请求，加载数据
    [self loadNewData];

}
//结束下拉刷新
- (void)headViewEndRefresh{
    self.headView.refreshState = LSDHeadViewNormalRefreshState;
    [UIView animateWithDuration:1.f animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -=self.headView.lsd_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - footViewRefresh
- (void)footViewBeginRefresh{
    LSDLog(@"上拉加载更多");
    self.footView.refreshState = LSDFootViewRefreshingState;
    //发送请求，加载数据
    [self loadMoreData];
}

- (void)footViewEndRefresh{
    self.footView.refreshState = LSDFootViewNormalOrFinshRefreshState;
}

#pragma mark - 懒加载
- (NSMutableArray *)allColumns{
    if (_allColumns == nil) {
        _allColumns = [NSMutableArray array];
    }
    return _allColumns;
}
#pragma mark - dealloc方法
- (void)dealloc{
    //移除通知
    [LSDNotificationCenter removeObserver:self name:LSDRepetClickTabBarItemNotification object:nil];
    [LSDNotificationCenter removeObserver:self name:LSDRepetClickTitleViewBtnNotification object:nil];
}
@end
