//
//  LSDAdNet.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDBaseNet.h"
@class LSDAdItem;

@interface LSDAdNet : NSObject
- (void)adRequestWithSuccessBlock:(void(^)(LSDAdItem *adItem))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock;
@end
