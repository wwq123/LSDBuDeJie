//
//  LSDColumnSoundView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/21.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDColumnSoundView.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "LSDAllColumnItem.h"
#import "UIImageView+Extension.h"

@interface LSDColumnSoundView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *soundTimeLab;
@end

@implementation LSDColumnSoundView
- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    [super awakeFromNib];
}

- (void)setColumnItem:(LSDAllColumnItem *)columnItem{
    _columnItem = columnItem;
    
    //设置图片
    [self.contentImageV downloadImageWithOriginalImageUrl:columnItem.image1 thumbImageUrl:columnItem.image0 placeholderImage:nil completed:nil];
    
    //设置播放次数
    if (columnItem.playcount >=10000) {
        self.playCountLab.text = [NSString stringWithFormat:@"%.1f万播放",columnItem.playcount/10000.0];
    }else{
        self.playCountLab.text = [NSString stringWithFormat:@"%zd播放",columnItem.playcount];
    }
    
    //设置播放时间
    self.soundTimeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",columnItem.voicetime/60,columnItem.voicetime%60];
}

@end
