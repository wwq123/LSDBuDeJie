//
//  LSDFileTool.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/12.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDFileTool.h"

@implementation LSDFileTool
+ (NSString *)getCachePath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (void)cacheSizeWithDirectoryPath:(NSString *)directoryPath complete:(void(^)(NSString *size))complete{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    //容错处理
    BOOL isFile;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isFile];
    if (!isExist || !isFile) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"需要传文件夹路径,且路径需要存在" userInfo:nil];
        [exception raise];
    }
    //获取给定路径下的所有子文件路径
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *subPaths = [manager subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        for (NSString *path in subPaths) {
            //拼接完整的路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
            //判断是否是隐藏文件
            if ([filePath containsString:@".DS"]) {
                continue;
            }
            //判断文件是否存在,并且判断是否是文件夹
            BOOL isFile;
            BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isFile];
            if (!isExist || isFile) {
                continue;
            }
            
            NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
            NSInteger size = [attrs fileSize];
            totalSize = totalSize + size;
        }
        NSString *totalSizeStr;
        if (totalSize >=1000*1000) {
            CGFloat num = totalSize/1000.0/1000.0;
            totalSizeStr = [NSString stringWithFormat:@"%0.fMB",num];
        }else if (totalSize >=1000){
            CGFloat num = totalSize/1000.0;
            totalSizeStr = [NSString stringWithFormat:@"%0.fKB",num];
        }else{
            totalSizeStr = [NSString stringWithFormat:@"%ldB",totalSize];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(totalSizeStr);
            }
        });

    });
}

+ (void)clearCache:(NSString *)directoryPath complete:(void(^)())complete{
    NSFileManager *manager = [NSFileManager defaultManager];
    //容错处理
    BOOL isFile;
    BOOL isExist = [manager fileExistsAtPath:directoryPath isDirectory:&isFile];
    if (!isExist || !isFile) {
        NSException *exception = [NSException exceptionWithName:@"pathError" reason:@"需要传文件夹路径,且路径需要存在" userInfo:nil];
        [exception raise];
    }
    // 获取directoryPath文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *path in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
        // 删除路径
        [manager removeItemAtPath:filePath error:nil];
    }
    
    if (complete) {
        complete();
    }
}

@end
