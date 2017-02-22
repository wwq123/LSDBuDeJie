//
//  LSDAllColumnNet.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/18.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDAllColumnNet.h"
#import "LSDBaseNetTool.h"
#import <MJExtension/MJExtension.h>
#import "LSDAllColumnItem.h"
#import "LSDCommentItem.h"
@interface LSDAllColumnNet ()
@property (nonatomic, strong) NSString *maxtime;
@end
@implementation LSDAllColumnNet
- (void)allColumnRequestWithMaxtime:(NSString *)maxtime type:(NSInteger)type successBlock:(void(^)(NSMutableArray *allColumns))successBlock failureBlock:(void(^)(NSString *errMessage))failureBlock{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    if (type) {
        param[@"type"] = @(type);
    }
    if (maxtime) {
        param[@"maxtime"] = maxtime;
    }
    
    LSDBaseNetTool *baseNet = [LSDBaseNetTool shareBaseNet];
    [baseNet requestWithMode:@"get" url:LSDBaseRequestUrl parameter:param successBlock:^(NSDictionary *responseObject) {
//        LSDLog(@"res == %@",responseObject);
        if (responseObject) {
            NSString *time = responseObject[@"info"][@"maxtime"];
            if (time) {
                self.maxtime = time;
            }
            NSDictionary *listDic = responseObject[@"list"];
            if (listDic) {
                NSMutableArray *items = [LSDAllColumnItem mj_objectArrayWithKeyValuesArray:listDic];
                if (items) {
                    successBlock(items);
                }
            }
            
        }
        LSDWritePlistFileWithFileName(@"allColumn")
        
    } failureBlock:^(NSString *errorDes) {
        failureBlock(errorDes);
    }];
}

- (NSString *)getMaxtime{
    return self.maxtime;
}

@end
