//
//  LSDAdVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDAdVC.h"
#import "LSDAdNet.h"
#import "LSDAdItem.h"
#import <UIImageView+WebCache.h>
#import "LSDTabBarVC.h"

@interface LSDAdVC ()
/**启动图片*/
@property (weak, nonatomic) IBOutlet UIImageView *lanuchImageView;
/**广告的占位视图*/
@property (weak, nonatomic) IBOutlet UIView *adHoldView;
/**跳过按钮*/
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;
@property (nonatomic, strong) LSDAdItem *adItem;
@property (nonatomic, strong) UIImageView *adImageV;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation LSDAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置启动图片
    [self setupLanuchImage];
    //获取广告数据
    [self loadADData];
    //倒计时定时器
    [self setupTimer];
}

- (void)setupLanuchImage{
    NSString *imageName;
    if (Iphone6PAbove) {
        imageName = @"LaunchImage-800-Portrait-736h@3x";
    }else if (Iphone6){
        imageName = @"LaunchImage-800-667h@2x";
    }else if (Iphone5){
        imageName = @"LaunchImage-700-568h@2x";
    }else{
        imageName = @"LaunchImage-700@2x";
    }
    self.lanuchImageView.image = [UIImage imageNamed:imageName];
}

- (void)loadADData{
    LSDAdNet *adNet = [[LSDAdNet alloc] init];
    [adNet adRequestWithSuccessBlock:^(LSDAdItem *adItem) {
        LSDLog(@"item : %@",adItem);
        if (adItem) {
            self.adItem = adItem;
            CGFloat adH = adItem.w *Screen_height/Screen_width;
            self.adImageV.frame = CGRectMake(0, 0, Screen_width, adH);
            [self.adImageV sd_setImageWithURL:[NSURL URLWithString:adItem.w_picurl]];
        }
    } failureBlock:^(NSString *errMessage) {
        LSDLog(@"err : %@",errMessage);
    }];
}

- (void)setupTimer{
   self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange{
    static int t = 3;
    if (t == 0) {
        [self jump:nil];
    }
    t --;
    [self.jumpBtn setTitle:[NSString stringWithFormat:@"跳过 (%d)",t] forState:UIControlStateNormal];
}

#pragma mark - jump按钮点击方法
- (IBAction)jump:(UIButton *)sender {
    LSDApplication.keyWindow.rootViewController = [[LSDTabBarVC alloc] init];
    [self.timer invalidate];
}

//点击广告图片跳转
- (void)tapClickAD{
    NSURL *url = [NSURL URLWithString:self.adItem.ori_curl];
    if ([LSDApplication canOpenURL:url]) {
        [LSDApplication openURL:url];
    }
}
#pragma mark - 懒加载
- (UIImageView *)adImageV{
    if (_adImageV == nil) {
        _adImageV = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAD)];
        [_adImageV addGestureRecognizer:tap];
        [self.adHoldView addSubview:_adImageV];
    }
    return _adImageV;
}
@end
