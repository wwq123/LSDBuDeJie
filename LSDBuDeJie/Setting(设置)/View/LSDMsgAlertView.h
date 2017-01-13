//
//  LSDMsgAlertView.h
//  LSDMsgAlertView
//
//  Created by SelenaWong on 16/12/30.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDMsgAlertView : UIView
+ (instancetype)shareAlertView;
+ (void)showAlertViewWithMsg:(NSString *)msg duration:(CGFloat)duration;
- (void)showMsg:(NSString *)msg duration:(CGFloat)duration;
@end
