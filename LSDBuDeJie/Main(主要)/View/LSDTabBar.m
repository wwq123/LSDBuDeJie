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
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (index == 2) {
                index += 1;
            }
            tabBarButton.frame = CGRectMake(index*width, 0, width, height);
            index += 1;
        }
    }
    self.plusBtn.center = CGPointMake(self.lsd_width/2.f, self.lsd_height/2.f);
}
@end
