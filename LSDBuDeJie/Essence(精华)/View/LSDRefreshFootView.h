//
//  LSDRefreshFootView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/17.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

//刷新状态枚举
typedef NS_ENUM(NSInteger,LSDFootViewRefreshState){
    LSDFootViewNormalOrFinshRefreshState =0, //普通或刷新完成状态
    LSDFootViewRefreshingState           =1, //正在刷新
};
@interface LSDRefreshFootView : UIView
@property (nonatomic, assign) LSDFootViewRefreshState refreshState;
/**记录当前是否正在上拉加载更多*/
@property (nonatomic, assign,getter=isFootViewRefreshing) BOOL footViewRefreshing;
@end
