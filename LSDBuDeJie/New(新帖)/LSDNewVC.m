//
//  LSDNewVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDNewVC.h"

@interface LSDNewVC ()

@end

@implementation LSDNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航条
    [self setupNavBar];
}

- (void)setupNavBar{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    UIBarButtonItem *leftBarItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagSub)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
#pragma mark - 按钮点击方法
- (void)tagSub{
    
}

@end
