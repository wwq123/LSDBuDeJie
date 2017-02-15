//
//  LSDTabBar.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDTabBar.h"

@interface LSDTabBar ()
@property (nonatomic, strong) UIButton *plusBtn;
/**记录上一次点击的tabBarItem*/
@property (nonatomic, strong) UIControl *lastClickTabBarBtn;
@end
@implementation LSDTabBar

- (UIButton *)plusBtn{
    if (_plusBtn == nil) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_plusBtn sizeToFit];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.items.count;
    CGFloat width = self.lsd_width/(count +1);
    CGFloat height = self.lsd_height;
    CGFloat index = 0;
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (index == 0 && self.lastClickTabBarBtn == nil) {
                self.lastClickTabBarBtn = tabBarButton;
            }
            if (index == 2) {
                index += 1;
            }
            tabBarButton.frame = CGRectMake(index*width, 0, width, height);
            index += 1;
//            LSDLog(@"tabBarButton : %@",[tabBarButton superclass]);
            [tabBarButton addTarget:self action:@selector(tabBarBtnRepetClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusBtn.center = CGPointMake(self.lsd_width/2.f, self.lsd_height/2.f);
}

//监听重复点击TabBarItem
- (void)tabBarBtnRepetClick:(UIControl *)tabBarBtn{
    if (tabBarBtn == self.lastClickTabBarBtn) {//当前点击的TabBarItem和上次点击的TabBarItem一样(重复点击)
        [LSDNotificationCenter postNotificationName:LSDRepetClickTabBarItemNotification object:nil userInfo:nil];
    }
    self.lastClickTabBarBtn = tabBarBtn;
}
@end
