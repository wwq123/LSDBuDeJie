//
//  LSDRefreshHeadView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/17.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

//刷新状态枚举
typedef NS_ENUM(NSInteger,LSDHeadViewRefreshState){
    LSDHeadViewNormalRefreshState =0, //普通状态
    LSDHeadViewWillRefreshState   =1, //即将刷新
    LSDHeadViewRefreshingState    =2, //正在刷新
};

@interface LSDRefreshHeadView : UIView
@property (nonatomic, assign) LSDHeadViewRefreshState refreshState;
/**记录当前是否正在下拉刷新*/
@property (nonatomic, assign,getter=isHeadViewRefreshing) BOOL headViewRefreshing;
@end
