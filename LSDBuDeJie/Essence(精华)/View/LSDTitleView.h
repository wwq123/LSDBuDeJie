//
//  LSDTitleView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/13.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectBlock)(UIButton *selectBtn);
@interface LSDTitleView : UIView
@property (nonatomic, strong) didSelectBlock didSelectBlock;

/**
 标题栏LSDTitleView

 @param frame  frame
 @param titles 标题数组

 @return 标题栏LSDTitleView
 */
+ (instancetype)titleViewWithframe:(CGRect)frame titles:(NSArray <NSString *>*)titles;

/**
 标题栏LSDTitleView

 @param frame  frame
 @param titles 标题数组

 @return 标题栏LSDTitleView
 */
- (instancetype)initWithframe:(CGRect)frame titles:(NSArray <NSString *>*)titles;

/**
 根据外界传入的索引改变对应的标题按钮

 @param index 外界传入的index
 */
- (void)changeTitleBtnStateWithIndex:(NSInteger)index;
@end
