//
//  LSDFileTool.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/12.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDFileTool : NSObject
/**
 获取沙盒Cache文件夹路径
 
 @return CachePath
 */
+ (NSString *)getCachePath;


/**
 获取某文件夹路径下的缓存大小
 
 @param directoryPath 文件夹路径
 
 @param complete      回调
 */
+ (void)cacheSizeWithDirectoryPath:(NSString *)directoryPath complete:(void(^)(NSString *size))complete;

/**
 清除某文件夹路径下的缓存
 
 @param directoryPath 文件夹路径
 @param complete      回调
 */
+ (void)clearCache:(NSString *)directoryPath complete:(void(^)())complete;
@end
