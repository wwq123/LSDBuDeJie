//
//  LSDColumnVideoView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/2/5.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDColumnVideoView.h"
#import "LSDAllColumnItem.h"
#import "UIImageView+Extension.h"

@interface LSDColumnVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageV;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLab;
@end

@implementation LSDColumnVideoView
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
    self.videoTimeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",columnItem.videotime/60,columnItem.videotime%60];
}
@end
