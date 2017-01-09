//
//  LSDBaseNet.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSString *errorDes);
@interface LSDBaseNet : NSObject

/**
 单例

 @return LSDBaseNet
 */
+ (instancetype)shareBaseNet;


/**
 请求

 @param mode         get/post
 @param url          请求地址
 @param parameter    请求参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 */
- (void)requestWithMode:(NSString *)mode
                    url:(NSString *)url
              parameter:(NSMutableDictionary *)parameter
           successBlock:(SuccessBlock)successBlock
           failureBlock:(SuccessBlock)failureBlock;
@end
