//
//  UIImageView+Extension.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/19.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Extension)

/**
 裁剪UIImageView
 @param radius    半径
 */
- (void)circle_ImageViewWithRadius:(CGFloat)radius;

- (void)downloadImageWithOriginalImageUrl:(NSString *)OriginalImageUrl thumbImageUrl:(NSString *)thumbImageUrl placeholderImage:(NSString *)placeholderImage completed:(SDWebImageCompletionBlock)completedBlock;
@end
