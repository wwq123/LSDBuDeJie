//
//  LSDLoginVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDLoginVC.h"
#import "LSDFastLoginView.h"
#import "LSDLoginRegistView.h"
#import "LSDButton.h"

@interface LSDLoginVC () <LSDFastLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginCloseBtn;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstraint;

@end

@implementation LSDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews{
    
    LSDLoginRegistView *loginView = [LSDLoginRegistView loginView];
    [self.centerView addSubview:loginView];
    
    LSDLoginRegistView *registView = [LSDLoginRegistView registView];
    [self.centerView addSubview:registView];
    
    LSDFastLoginView *fastLoginView = [LSDFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

- (void)viewDidLayoutSubviews{
    LSDLoginRegistView *loginView = self.centerView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.centerView.lsd_width*0.5, self.centerView.lsd_height);
    
    LSDLoginRegistView *registView = self.centerView.subviews[1];
    registView.frame = CGRectMake(self.centerView.lsd_width*0.5, 0, self.centerView.lsd_width*0.5, self.centerView.lsd_height);
    
    LSDFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.delegate = self;
    fastLoginView.frame = self.bottomView.bounds;
}
#pragma mark - 关闭按钮点击方法
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 注册按钮点击方法
- (IBAction)registBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.leadConstraint.constant == 0) {
        self.leadConstraint.constant = - self.centerView.lsd_width *0.5;
    }else{
        self.leadConstraint.constant = 0;
    }
    [UIView animateWithDuration:0.2f animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 改变状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 重写touchBegin方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - LSDFastLoginViewDelegate
- (void)fastLoginView:(LSDFastLoginView *)fastLoginView didSelectWhichLoginWay:(LSDButton *)loginWay{
    LSDButton *btn = loginWay;
    LSDLog(@"%@",btn.currentTitle);
}
@end
