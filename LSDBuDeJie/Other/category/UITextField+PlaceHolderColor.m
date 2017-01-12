//
//  UITextField+PlaceHolderColor.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "UITextField+PlaceHolderColor.h"
#import <objc/message.h>

@implementation UITextField (PlaceHolderColor)

+ (void)load{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method lsd_setPlaceholder = class_getInstanceMethod(self, @selector(setlsd_placeholder:));
    method_exchangeImplementations(setPlaceholder, lsd_setPlaceholder);
}
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    objc_setAssociatedObject(self, @"placeholderLabel", placeHolderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *label = [self valueForKey:@"placeholderLabel"];
    label.textColor = placeHolderColor;
}

- (UIColor *)placeHolderColor{
    return objc_getAssociatedObject(self, @"placeholderLabel");
}

- (void)setlsd_placeholder:(NSString *)placeholder{
    [self setlsd_placeholder:placeholder];
    self.placeHolderColor = self.placeHolderColor;
}
@end
