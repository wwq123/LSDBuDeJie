//
//  LSDColumnPictureView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/2/5.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDColumnPictureView.h"
#import "LSDAllColumnItem.h"
#import "UIImageView+Extension.h"
#import "LSDSeeBigPictureVC.h"
#import "UIStoryboard+VC.h"

@interface LSDColumnPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifIconView;
@property (weak, nonatomic) IBOutlet UIButton *checkBigPictureBtn;

@end

@implementation LSDColumnPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.contentImageView.userInteractionEnabled = YES;
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBigPictureBtnClick:)]];
}
- (void)setColumnItem:(LSDAllColumnItem *)columnItem{
    _columnItem = columnItem;
    [self.contentImageView downloadImageWithOriginalImageUrl:columnItem.image1 thumbImageUrl:columnItem.image0 placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return;
        }
        if (columnItem.isBigPicture) {//如果图片大小不够填充ImageView。那么就自己绘制填充
            CGFloat imageWidth = columnItem.middleViewFrame.size.width;
            CGFloat imageHieght = imageWidth*columnItem.height/columnItem.width;
//            CGFloat imageHieght = columnItem.middleViewFrame.size.height;
            //开启图片上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHieght));
            [self.contentImageView.image drawInRect:CGRectMake(0, 0, imageWidth, imageHieght)];
            self.contentImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
    }];
    
    if ([columnItem.is_gif boolValue]) {//是否是gif图片
        self.gifIconView.hidden = NO;
    }else{
        self.gifIconView.hidden = YES;
    }
    
    if (columnItem.isBigPicture) {//是否是超长图片
        self.checkBigPictureBtn.hidden = NO;
        self.contentImageView.contentMode = UIViewContentModeTop;
        self.contentImageView.clipsToBounds = YES;
    }else{
        self.checkBigPictureBtn.hidden = YES;
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentImageView.clipsToBounds = NO;
    }
}

- (IBAction)checkBigPictureBtnClick:(UIButton *)sender {
    LSDSeeBigPictureVC *bigPictureVC = (LSDSeeBigPictureVC *)[UIStoryboard controllerWithStoryBoardName:LSDMian identifier:NSStringFromClass([LSDSeeBigPictureVC class])];
    [bigPictureVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    bigPictureVC.columnItem = self.columnItem;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (keyWindow) {
        [keyWindow.rootViewController presentViewController:bigPictureVC animated:YES completion:nil];
    }
}
@end
