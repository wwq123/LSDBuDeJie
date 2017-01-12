//
//  UIStoryboard+VC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "UIStoryboard+VC.h"

@implementation UIStoryboard (VC)
+ (UIViewController *)controllerWithStoryBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController *vc;
    if (identifier) {
        vc = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    }else{
        vc = [[UIViewController alloc] init];
    }
    return vc;
}
@end
