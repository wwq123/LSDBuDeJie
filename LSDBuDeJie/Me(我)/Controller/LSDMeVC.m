//
//  LSDMeVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDMeVC.h"
#import "LSDSettingVC.h"
#import "LSDModuleItem.h"
#import "LSDLoginVC.h"
#import "UIStoryboard+VC.h"
#import "LSDModulesNet.h"
#import "LSDFootView.h"
#import "LSDWebViewVC.h"

#define LSDCollectionCell_WH (Screen_width - (LSD_collcetionViewCols -1)*LSD_collectionCellMargin)/LSD_collcetionViewCols

static NSString *const LSDMeNormalCellIdentifier = @"LSDMeNormalCellIdentifier";

@interface LSDMeVC () <LSDFootViewDelegate>
@property (nonatomic, strong) NSMutableArray *allModules;
@end

@implementation LSDMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LSDBackgroundColor;
    //设置导航条
    [self setupNavBar];
    //设置TableView
    [self setupTableView];
    //加载数据
    [self loadData];
}

- (void)setupNavBar{
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = LSDBackgroundColor;
    //设置夜间和设置按钮
    UIBarButtonItem *settingBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"]  target:self action:@selector(settingClick)];
    UIBarButtonItem *nightBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightClick:)];
    self.navigationItem.rightBarButtonItems = @[settingBarItem,nightBarItem];
}

- (void)setupTableView{
    self.tableView.backgroundColor = LSDBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LSDMeNormalCellIdentifier];
}

- (void)loadData{
    LSDModulesNet *modulesNet = [[LSDModulesNet  alloc] init];
    [modulesNet modulesRequestWithSuccessBlock:^(NSMutableArray *allModules) {
        self.allModules = allModules;
        LSDFootView *footView = [[LSDFootView alloc] initWithModules:self.allModules];
        footView.delegate = self;
        self.tableView.tableFooterView = footView;
    } failureBlock:^(NSString *errMessage) {
        LSDLog(@"%@",errMessage);
    }];
}
#pragma mark - 设置按钮点击方法
- (void)settingClick{
    LSDSettingVC *settingVC = [[LSDSettingVC alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
#pragma mark - 夜间模式按钮点击方法
- (void)nightClick:(UIButton *)sender{
    sender.selected = ! sender.selected;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 10.f;
    }
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LSDMeNormalCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }else{
        cell.imageView.image = nil;
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LSDLoginVC *loginVC = (LSDLoginVC *)[UIStoryboard controllerWithStoryBoardName:LSDMian identifier:NSStringFromClass([LSDLoginVC class])];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 44.f;
}

#pragma mark - LSDMeCellDelegate
- (void)footView:(LSDFootView *)footView didSelectedItem:(LSDModuleItem *)item{
    LSDLog(@"%@",[NSString stringWithFormat:@"点击了%@模块",item.name]);
    if (![item.url containsString:@"http"]) {
        return;
    }
    LSDWebViewVC *webViewVC = (LSDWebViewVC *)[UIStoryboard controllerWithStoryBoardName:LSDMian identifier:NSStringFromClass([LSDWebViewVC class])];
    webViewVC.urlStr = item.url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)allModules{
    if (_allModules == nil) {
        _allModules = [NSMutableArray array];
    }
    return _allModules;
}
@end
