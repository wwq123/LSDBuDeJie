//
//  LSDModulesNet.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDModulesNet.h"
#import "LSDBaseNetTool.h"
#import <MJExtension/MJExtension.h>
#import "LSDModuleItem.h"


@implementation LSDModulesNet
- (void)modulesRequestWithSuccessBlock:(void(^)(NSMutableArray *allModules))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"square";
    param[@"c"] = @"topic";
    
    LSDBaseNetTool *baseNet = [LSDBaseNetTool shareBaseNet];
    [baseNet requestWithMode:@"get" url:LSDBaseRequestUrl parameter:param successBlock:^(id responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        if (dictArr) {
            NSMutableArray *allModules = [LSDModuleItem mj_objectArrayWithKeyValuesArray:dictArr];
            if (allModules) {
                successBlock(allModules);
            }
        }
    } failureBlock:^(NSString *errorDes) {
        failureBlock(errorDes);
    }];

}
@end
