//
//  LSDFriendTrendVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDFriendTrendVC.h"

@interface LSDFriendTrendVC ()

@end

@implementation LSDFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //设置导航条
    [self setupNavBar];
}

- (void)setupNavBar{
    self.navigationItem.title = @"我的关注";
    UIBarButtonItem *leftBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(recomment)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
#pragma mark - 推荐按钮点击方法
- (void)recomment{
    
}
@end
