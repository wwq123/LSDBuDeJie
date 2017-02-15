//
//  LSDVideoVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/13.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDVideoVC.h"

@interface LSDVideoVC ()

@end

@implementation LSDVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.contentInset = UIEdgeInsetsMake(LSD_ContentSet_Top, 0, LSD_ContentSet_bottom, 0);
    [LSDNotificationCenter addObserver:self selector:@selector(video_repetClickTabBarItemAction:) name:LSDRepetClickTabBarItemNotification object:nil];
     [LSDNotificationCenter addObserver:self selector:@selector(video_repetClickTitleViewBtnAction:) name:LSDRepetClickTitleViewBtnNotification object:nil];
}

#pragma mark - 监听通知
//监听TabBarItem重复点击
- (void)video_repetClickTabBarItemAction:(NSNotification *)noti{
    if (self.view.window == nil) {//当前窗口显示的不是自己所在的模块
        return;
    }
    if (self.tableView.scrollsToTop == NO) {//当前显示的不是自己的View
        return;
    }
    LSDFunc;
}
//监听对应的TitleViewBtn重复点击
- (void)video_repetClickTitleViewBtnAction:(NSNotification *)noti{
    [self video_repetClickTabBarItemAction:noti];
}
#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"LSDVideoVCCell";
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
