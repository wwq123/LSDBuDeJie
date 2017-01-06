//
//  UIBarButtonItem+Item.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/6.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/**
@param normalImage 正常状态下的图片
 @param highImage   高亮状态下的图片
 @param target      监听对象
 @param action      绑定的方法

 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
/**
 @param normalImage 正常状态下的图片
 @param selImage    点击状态下的图片
 @param target      监听对象
 @param action      绑定的方法
 
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithNormalImage:(UIImage *)normalImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
/**
 @param normalImage 正常状态下的图片
 @param highImage   高亮状态下的图片
 @param target      监听对象
 @param action      绑定的方法
 
 @return 返回按钮
 */
+ (UIBarButtonItem *)backItemWithNormalImage:(UIImage *)normalImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
