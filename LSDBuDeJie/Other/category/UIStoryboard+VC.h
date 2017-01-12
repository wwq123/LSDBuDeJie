//
//  UIStoryboard+VC.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (VC)
+ (UIViewController *)controllerWithStoryBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier;
@end
