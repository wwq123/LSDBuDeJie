//
//  LSDSettingVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSettingVC.h"
#import "LSDSectionHeadView.h"
#import "LSDMsgAlertView.h"
#import "LSDFileTool.h"

static NSString *const LSDSettingCellIdentifier = @"LSDSettingCellIdentifier";
@interface LSDSettingVC ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) UISegmentedControl *segment;
@end

@implementation LSDSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = LSDBackgroundColor;
    self.tableView.backgroundColor = LSDBackgroundColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LSDSettingCellIdentifier];
    NSNumber *segmentSelect = [LSDUserDefaults objectForKey:LSDSettingSegmentSelectIndex];
    if (segmentSelect) {
        self.segment.selectedSegmentIndex = [segmentSelect integerValue];
    }else{
        self.segment.selectedSegmentIndex = 1;
    }
}

- (void)segMentClick:(UISegmentedControl *)segment{
    NSInteger selectIndex = segment.selectedSegmentIndex;
    LSDLog(@"%ld",(long)selectIndex);
    [LSDUserDefaults setObject:@(selectIndex) forKey:LSDSettingSegmentSelectIndex];
    [LSDUserDefaults synchronize];
}

#pragma mark - 私有方法
- (void)alertMessage:(NSString *)message{
    [LSDMsgAlertView showAlertViewWithMsg:message duration:1.f];
}
#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LSDSettingCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.accessoryView = self.segment;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    [cell.textLabel setFont:[UIFont systemFontOfSize:13.f]];
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//清除缓存操作
            [LSDFileTool clearCache:[LSDFileTool getCachePath] complete:^{
                self.titles[indexPath.section][indexPath.row] = @"清除缓存";
                [self alertMessage:@"清除缓存成功"];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LSDSectionHeadView *headView = [LSDSectionHeadView headViewWithTableView:tableView];
    if (section == 0) {
        headView.title = @"功能设置";
    }else{
        headView.title = @"其他";
    }
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

#pragma mark - 懒加载
- (NSMutableArray *)titles{
    if (_titles == nil) {
        NSArray *arr = @[@"字体大小"];
        _titles = [NSMutableArray arrayWithObject:arr];
        [LSDFileTool cacheSizeWithDirectoryPath:[LSDFileTool getCachePath] complete:^(NSString *size) {
            NSString *cache;
            if (![size isEqualToString:@"0B"]) {
                cache = [NSString stringWithFormat:@"清除缓存(已使用%@)",size];
            }else{
                cache = [NSString stringWithFormat:@"清除缓存"];
            }
            NSString *version = [NSString stringWithFormat:@"当前版本: %@",LSDCurrentVersion];
            NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:cache,@"推荐给朋友",@"帮助",version,@"关于我们",@"隐私政策",@"打分支持不得姐!", nil];
            [_titles addObject:arr1];
            [self.tableView reloadData];
        }];
    }
    return _titles;
}

- (UISegmentedControl *)segment{
    if (_segment == nil) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"小",@"中",@"大"]];
        [_segment addTarget:self action:@selector(segMentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}
@end
