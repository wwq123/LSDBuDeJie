//
//  LSDSubTagVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSubTagVC.h"
#import "LSDSubTagNet.h"
#import "LSDSubTagCell.h"
#import "LSDSubTagItem.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface LSDSubTagVC ()
@property (nonatomic, strong) NSMutableArray *subTags;
@end

@implementation LSDSubTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    //获取数据
    [self loadData];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    //取消之前请求
    AFHTTPSessionManager *manager = [LSDBaseNet shareBaseNet].sessionManager;
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)setupUI{
    self.navigationItem.title = @"推荐标签";
    self.tableView.backgroundColor = LSDColor(220, 220, 221);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80.f;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载ing..."];
    LSDSubTagNet *subTagNet = [[LSDSubTagNet alloc] init];
    [subTagNet subTagRequestWithSuccessBlock:^(NSMutableArray *subTags) {
        [SVProgressHUD dismiss];
        self.subTags = subTags;
        [self.tableView reloadData];
    } failureBlock:^(NSString *errMessage) {
        [SVProgressHUD dismiss];
        LSDLog(@"%@", errMessage);
    }];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSDSubTagCell *cell = [LSDSubTagCell subCellWithTableView:tableView];
    LSDSubTagItem *item = self.subTags[indexPath.row];
    cell.subTagItem = item;
    return cell;
}

#pragma mark - 懒加载
- (NSMutableArray *)subTags{
    if (_subTags == nil) {
        _subTags = [NSMutableArray array];
    }
    return _subTags;
}
@end
