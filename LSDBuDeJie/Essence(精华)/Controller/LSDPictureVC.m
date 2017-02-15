//
//  LSDPictureVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/13.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDPictureVC.h"

@interface LSDPictureVC ()

@end

@implementation LSDPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.contentInset = UIEdgeInsetsMake(LSD_ContentSet_Top, 0, LSD_ContentSet_bottom, 0);
    [LSDNotificationCenter addObserver:self selector:@selector(picture_repetClickTabBarItemAction:) name:LSDRepetClickTabBarItemNotification object:nil];
    [LSDNotificationCenter addObserver:self selector:@selector(picture_repetClickTitleViewBtnAction:) name:LSDRepetClickTitleViewBtnNotification object:nil];
}

#pragma mark - 监听通知
//监听TabBarItem重复点击
- (void)picture_repetClickTabBarItemAction:(NSNotification *)noti{
    if (self.view.window == nil) {//当前窗口显示的不是自己所在的模块
        return;
    }
    if (self.tableView.scrollsToTop == NO) {//当前显示的不是自己的View
        return;
    }
    LSDFunc;
}
//监听对应的TitleViewBtn重复点击
- (void)picture_repetClickTitleViewBtnAction:(NSNotification *)noti{
    [self picture_repetClickTabBarItemAction:noti];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LSDPictureVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",NSStringFromClass([self class]),indexPath.row];
    return cell;
}

#pragma mark - dealloc方法
- (void)dealloc{
    //移除通知
    [LSDNotificationCenter removeObserver:self name:LSDRepetClickTabBarItemNotification object:nil];
    [LSDNotificationCenter removeObserver:self name:LSDRepetClickTitleViewBtnNotification object:nil];
}
@end
