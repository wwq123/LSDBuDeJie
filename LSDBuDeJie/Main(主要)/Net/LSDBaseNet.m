//
//  LSDBaseNet.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDBaseNet.h"
#import <AFNetworking.h>

static LSDBaseNet *_baseNet = nil;

@interface LSDBaseNet ()
{
    AFHTTPSessionManager *_manager;
}
@end
@implementation LSDBaseNet

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _baseNet = [super allocWithZone:zone];
    });
    return _baseNet;
}

+ (instancetype)shareBaseNet{
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone{
    return _baseNet;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _baseNet;
}

- (instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        [_manager.requestSerializer setTimeoutInterval:LSDTimeOut];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",@"text/xml", nil];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager{
    return _manager;
}

- (void)requestWithMode:(NSString *)mode url:(NSString *)url parameter:(NSMutableDictionary *)parameter successBlock:(SuccessBlock)successBlock failureBlock:(SuccessBlock)failureBlock{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([mode isEqualToString:@"get"]) {
        [_manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"res : %@",responseObject);
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error.localizedFailureReason);
        }];
    }else{
        [_manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failureBlock(error.localizedFailureReason);
        }];
    }
}
@end
