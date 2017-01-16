//
//  LSDEssenceVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDEssenceVC.h"
#import "LSDTitleView.h"
#import "LSDAllColumnVC.h"
#import "LSDVideoVC.h"
#import "LSDSoundVC.h"
#import "LSDPictureVC.h"
#import "LSDJokesVC.h"

#define ContentScrollView_Y (64 + LSD_titleViewH)
@interface LSDEssenceVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) LSDTitleView *titleView;
/**标题数组*/
@property (nonatomic, strong) NSArray *titles;
/**内容控制器scrollView*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**保存子控制器数组*/
@property (nonatomic, strong) NSMutableArray <UIViewController *>*childVCs;
@property (nonatomic, assign) NSInteger currentPageIndex;
@end

@implementation LSDEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航条
    [self setupNavBar];
    //设置顶部标题栏
    [self setupTopTitleView];
    //添加内容视图
    [self.view addSubview:self.contentScrollView];
    //设置子控制器
    [self setupChildVC];
    //设置初始第一个子控制器的View
    [self addChildViewWithIndex:0];
}

- (void)setupNavBar{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    UIBarButtonItem *leftBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIBarButtonItem *rightBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)setupTopTitleView{
    LSDTitleView *titleView = [LSDTitleView titleViewWithframe:CGRectMake(0, 64, Screen_width, LSD_titleViewH) titles:self.titles];
    titleView.didSelectBlock = ^(UIButton *selectTitleBtn){
        //添加对应的子控制器的View
        [self addChildViewWithIndex:selectTitleBtn.tag];
    };
    [self.view addSubview:titleView];
    self.titleView = titleView;
}

- (void)setupChildVC{
    [self addChildVC:[[LSDAllColumnVC alloc] init]];
    [self addChildVC:[[LSDVideoVC alloc] init]];
    [self addChildVC:[[LSDSoundVC alloc] init]];
    [self addChildVC:[[LSDPictureVC alloc] init]];
    [self addChildVC:[[LSDJokesVC alloc] init]];
    [self.contentScrollView setContentSize:CGSizeMake(self.childVCs.count *Screen_width, 0)];
}

- (void)addChildViewWithIndex:(NSInteger)index{
    NSInteger count = self.childVCs.count;
    CGFloat viewX = Screen_width*index;
    if (index<count) {
        UIViewController *vc = self.childVCs[index];
        if (vc.view.superview) {//如果对应的子控件的View添加过了，就不需要再次添加了
            [self.contentScrollView setContentOffset:CGPointMake(viewX, 0)];
            return;
        }
        vc.view.frame = CGRectMake(viewX, 0, Screen_width, Screen_height - ContentScrollView_Y);
        [self.contentScrollView addSubview:vc.view];
        [self.contentScrollView setContentOffset:CGPointMake(viewX, 0)];
    }
}

- (void)addChildVC:(UIViewController *)childVC{
    [self addChildViewController:childVC];
    [self.childVCs addObject:childVC];
}

#pragma mark - 游戏按钮点击方法
- (void)game{
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x/Screen_width + 0.5;
    if (index == self.currentPageIndex) {
        return;
    }
    [self addChildViewWithIndex:index];
    [self.titleView changeTitleBtnStateWithIndex:index];
    self.currentPageIndex = index;
}
#pragma mark - 懒加载
- (NSArray *)titles{
    if (_titles == nil) {
        _titles = @[@"全部",@"视频视频",@"声音音",@"图片",@"段子"];
    }
    return _titles;
}

- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ContentScrollView_Y, Screen_width, Screen_height - ContentScrollView_Y)];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}

- (NSMutableArray <UIViewController *>*)childVCs{
    if (_childVCs == nil) {
        _childVCs = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _childVCs;
}
@end
