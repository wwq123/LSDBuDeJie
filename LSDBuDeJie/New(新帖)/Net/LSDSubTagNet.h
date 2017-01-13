//
//  LSDSubTagNet.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDBaseNetTool.h"

@interface LSDSubTagNet : NSObject
- (void)subTagRequestWithSuccessBlock:(void(^)(NSMutableArray *subTags))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock;
@end
