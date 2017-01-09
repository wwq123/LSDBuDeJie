//
//  LSDAdItem.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDAdItem : NSObject
/**广告图片地址*/
@property (nonatomic, strong) NSString *w_picurl;
/**链接地址*/
@property (nonatomic, strong) NSString *ori_curl;
/**广告图片宽度*/
@property (nonatomic, assign) CGFloat w;
/**广告图片高度*/
@property (nonatomic, assign) CGFloat h;
@end
