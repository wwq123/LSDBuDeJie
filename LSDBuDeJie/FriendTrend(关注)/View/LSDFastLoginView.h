//
//  LSDFastLoginView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSDButton;
@class LSDFastLoginView;

@protocol  LSDFastLoginViewDelegate<NSObject>
@optional
- (void)fastLoginView:(LSDFastLoginView *)fastLoginView didSelectWhichLoginWay:(LSDButton *)loginWay;
@end

@interface LSDFastLoginView : UIView
@property (nonatomic, weak) id<LSDFastLoginViewDelegate> delegate;
+ (instancetype)fastLoginView;
@end
