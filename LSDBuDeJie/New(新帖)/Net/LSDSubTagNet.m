//
//  LSDSubTagNet.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSubTagNet.h"
#import <MJExtension/MJExtension.h>
#import "LSDSubTagItem.h"
#import "LSDBaseNetTool.h"

#define SubTagUrl @"http://api.budejie.com/api/api_open.php"

@implementation LSDSubTagNet
- (void)subTagRequestWithSuccessBlock:(void (^)(NSMutableArray *))successBlock failureBlock:(void (^)(NSString *))failureBlock{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"tag_recommend";
    param[@"action"] = @"sub";
    param[@"c"] = @"topic";
    
    LSDBaseNetTool *baseNet = [LSDBaseNetTool shareBaseNet];
    [baseNet requestWithMode:@"get" url:SubTagUrl parameter:param successBlock:^(id responseObject) {
        NSMutableArray *subTags = [LSDSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        if (subTags) {
            successBlock(subTags);
        }
    } failureBlock:^(NSString *errorDes) {
        failureBlock(errorDes);
    }];

}
@end
