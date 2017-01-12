//
//  LSDButton.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDButton.h"

@implementation LSDButton
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.lsd_y = 0.f;
    self.imageView.lsd_centerX = self.lsd_width/2.f;
    self.titleLabel.lsd_y = self.lsd_height - self.titleLabel.lsd_height;
    [self.titleLabel sizeToFit];
    self.titleLabel.lsd_centerX = self.lsd_width/2.f;
}
@end
