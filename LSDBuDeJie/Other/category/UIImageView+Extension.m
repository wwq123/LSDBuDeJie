//
//  UIImageView+Extension.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/19.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <AFNetworking.h>
#import <SDImageCache.h>

@implementation UIImageView (Extension)
- (void)circle_ImageViewWithRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)downloadImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbImageUrl:(NSString *)thumbImageUrl placeholderImage:(NSString *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock{
    //设置图片
    UIImage *placeholder = [UIImage imageNamed:placeholderImage];
    //先去缓存中找是否有原图
    UIImage *originalImage =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:OriginalImageUrl];
    if (originalImage) {//缓存中没原图
        [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrl] placeholderImage:placeholder completed:completedBlock];
    }else{//就去下载
        if ([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi) {//如果是wifi环境，下载原图
            [self sd_setImageWithURL:[NSURL URLWithString:OriginalImageUrl] placeholderImage:placeholder completed:completedBlock];
        }else if ([AFNetworkReachabilityManager sharedManager].isReachableViaWWAN){//手机网络，下载缩略图
            [self sd_setImageWithURL:[NSURL URLWithString:thumbImageUrl] placeholderImage:placeholder completed:completedBlock];
        }else{//没网,先去缓存中找是否有缩略图,有就显示，没有就显示占位图片
            UIImage *thumbImage =  [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbImageUrl];
            if (thumbImage) {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbImageUrl] placeholderImage:placeholder completed:completedBlock];
            }else{
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
            }
        }
    }
}
@end
