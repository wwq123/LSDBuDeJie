//
//  LSDMeVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDMeVC.h"
#import "LSDSettingVC.h"

@interface LSDMeVC ()

@end

@implementation LSDMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //设置导航条
    [self setupNavBar];
}

- (void)setupNavBar{
    self.navigationItem.title = @"我的";

    //设置夜间和设置按钮
    UIBarButtonItem *settingBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"]  target:self action:@selector(settingClick)];
    UIBarButtonItem *nightBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightClick:)];
    self.navigationItem.rightBarButtonItems = @[settingBarItem,nightBarItem];
}
#pragma mark - 设置按钮点击方法
- (void)settingClick{
    LSDSettingVC *settingVC = [[LSDSettingVC alloc] init];
    [settingVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark - 夜间模式按钮点击方法
- (void)nightClick:(UIButton *)sender{
    sender.selected = ! sender.selected;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
