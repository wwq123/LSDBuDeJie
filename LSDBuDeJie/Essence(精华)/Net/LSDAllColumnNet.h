//
//  LSDAllColumnNet.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/18.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDAllColumnNet : NSObject
- (void)allColumnRequestWithMaxtime:(NSString *)maxtime successBlock:(void(^)(NSMutableArray *allColumns))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock;

/**
 最后一条帖子数据的描述信息，专门用来加载下一页数据

 @return 当前最后一条帖子数据的描述信息，专门用来加载下一页数据
 */
- (NSString *)getMaxtime;
@end
