//
//  UIView+Frame.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setLsd_width:(CGFloat)lsd_width{
    CGRect rect = self.frame;
    rect.size.width = lsd_width;
    self.frame = rect;
}

- (CGFloat)lsd_width{
    return self.frame.size.width;
}

- (void)setLsd_height:(CGFloat)lsd_height{
    CGRect rect = self.frame;
    rect.size.height = lsd_height;
    self.frame = rect;
}

- (CGFloat)lsd_height{
    return self.frame.size.height;
}

- (void)setLsd_x:(CGFloat)lsd_x{
    CGRect rect = self.frame;
    rect.origin.x = lsd_x;
    self.frame = rect;
}

- (CGFloat)lsd_x{
    return self.frame.origin.x;
}

- (void)setLsd_y:(CGFloat)lsd_y{
    CGRect rect = self.frame;
    rect.origin.y = lsd_y;
    self.frame = rect;
}

- (CGFloat)lsd_y{
    return self.frame.origin.y;
}

- (void)setLsd_centerX:(CGFloat)lsd_centerX{
    CGPoint center = self.center;
    center.x = lsd_centerX;
    self.center = center;
}

- (CGFloat)lsd_centerX{
    return self.center.x;
}

- (void)setLsd_centerY:(CGFloat)lsd_centerY{
    CGPoint center = self.center;
    center.y = lsd_centerY;
    self.center = center;
}

- (CGFloat)lsd_centerY{
    return self.center.y;
}

@end
