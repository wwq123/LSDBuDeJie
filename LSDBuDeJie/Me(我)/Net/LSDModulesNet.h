//
//  LSDModulesNet.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDModulesNet : NSObject
- (void)modulesRequestWithSuccessBlock:(void(^)(NSMutableArray *allModules))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock;
@end
