//
//  LSDColumnCell.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/19.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDColumnCell.h"
#import "LSDAllColumnItem.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+Extension.h"
#import <TTTAttributedLabel.h>
#import "LSDCommentItem.h"
#import "LSDUser.h"
#import "LSDBottomView.h"
#import "LSDColumnSoundView.h"
#import "LSDColumnVideoView.h"
#import "LSDColumnPictureView.h"

@interface LSDColumnCell () <TTTAttributedLabelDelegate>
/**头像*/
@property (nonatomic, weak) IBOutlet UIImageView *headImgV;
/**名字*/
@property (nonatomic, weak) IBOutlet UILabel *nameLab;
/**发布时间*/
@property (nonatomic, weak) IBOutlet UILabel *passtimeLab;
/**更多按钮*/
@property (nonatomic, weak) IBOutlet UIButton *moreBtn;
/**内容*/
@property (nonatomic, weak) IBOutlet UILabel *textLab;
/**按钮的容器view*/
@property (nonatomic, weak)  LSDBottomView *bottomView;
/**顶部包容view*/
@property (nonatomic, weak) IBOutlet UIView *topView;
/**评论View*/
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) LSDColumnSoundView *soundView;
@property (nonatomic, strong) LSDColumnVideoView *videoView;
@property (nonatomic, strong) LSDColumnPictureView *pictureView;
@end
@implementation LSDColumnCell

+ (instancetype)columnCellWithTableView:(UITableView *)tableView{
    return [[LSDColumnCell alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *const columnCellIdentifier = @"LSDColumnCell";
    self = [tableView dequeueReusableCellWithIdentifier:columnCellIdentifier];
    if (self == nil) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSDColumnCell class]) owner:nil options:nil].firstObject;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];

    }
    return self;
}

- (void)setupUI{
    //添加中间内容View
    LSDColumnVideoView *videoView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSDColumnVideoView class]) owner:nil options:nil].firstObject;
    [self.contentView addSubview:videoView];
    self.videoView = videoView;
    
    LSDColumnSoundView *soundView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSDColumnSoundView class]) owner:nil options:nil].firstObject;
    [self.contentView addSubview:soundView];
    self.soundView = soundView;
    
    LSDColumnPictureView *pictureView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSDColumnPictureView class]) owner:nil options:nil].firstObject;
    [self.contentView addSubview:pictureView];
    self.pictureView = pictureView;

    //底部bottomView
    LSDBottomView *bottomView = [[LSDBottomView alloc] init];
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    //添加评论View
    UIView *commentView = [[UIView alloc] init];
    commentView.backgroundColor = LSDBackgroundColor;
    [self.contentView addSubview:commentView];
    self.commentView = commentView;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat radius = (LSD_ColumnCellTopViewHeight - LSD_ColumnUnifyMargin*2)/2.f;
    [self.headImgV circle_ImageViewWithRadius:radius];
    
    if (self.columnItem.type == LSDColumnTypeVideo) {
        self.videoView.frame = self.columnItem.middleViewFrame;
    }else if (self.columnItem.type == LSDColumnTypeSound){
        self.soundView.frame = self.columnItem.middleViewFrame;
    }else if (self.columnItem.type == LSDColumnTypePicture){
        self.pictureView.frame = self.columnItem.middleViewFrame;
    }
    
    //设置bottomView的frame
    self.bottomView.frame = self.columnItem.bottomViewFrame;

       //设置评论view的frame
    self.commentView.frame = self.columnItem.commentViewFrame;
}

//间距
//- (void)setFrame:(CGRect)frame{
//    frame.size.height -= LSD_ColumnUnifyMargin;
//    frame.origin.x += LSD_ColumnUnifyMargin;
//    frame.size.width -= LSD_ColumnUnifyMargin *2;
//    [super setFrame:frame];
//}


- (void)setColumnItem:(LSDAllColumnItem *)columnItem{
    _columnItem = columnItem;
    //设置顶部控件数据
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:columnItem.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLab.text = columnItem.name;
    self.passtimeLab.text = columnItem.passtime;
    self.textLab.text = columnItem.text;
    
    if (columnItem.type == LSDColumnTypeVideo) {
        self.videoView.columnItem = columnItem;
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.soundView.hidden = YES;
    }else if (columnItem.type == LSDColumnTypeSound){
        self.soundView.columnItem = columnItem;
        self.soundView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (columnItem.type == LSDColumnTypePicture){
        self.pictureView.columnItem = columnItem;
        self.pictureView.hidden = NO;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    }else{
        self.pictureView.hidden = YES;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    }
        
    //设置底部View按钮数据
    self.bottomView.columnItem = columnItem;
    
    //设置评论
    [self.commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (columnItem.top_cmt.count >0) {
        self.commentView.hidden = NO;
        LSDLog(@"comInfoCount = %ld",columnItem.comInfos.count);
        for (NSDictionary *dic in columnItem.comInfos) {
            TTTAttributedLabel *comLab = [self labelWithComment:dic[@"info"] link:dic[@"link"]];
            comLab.frame = CGRectMake(0, 5, Screen_width - LSD_ColumnUnifyMargin*2, [dic[@"height"] floatValue] +5);
            comLab.delegate = self;
            [self.commentView addSubview:comLab];
        }
    }else{
        self.commentView.hidden = YES;
    }
}

#pragma mark - 评论Label
- (TTTAttributedLabel *)labelWithComment:(NSString *)comment link:(NSString *)link{
    NSString *userName;
    NSString *com;
    NSRange  range;
    if ([comment rangeOfString:@":"].location !=NSNotFound) {
        range = [comment rangeOfString:@":"];
        userName = [comment substringToIndex:range.location];
        com = [comment substringFromIndex:range.location +1];
    }
    TTTAttributedLabel *lab = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    lab.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    lab.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:comment
                                                                                  attributes:@{(id)kCTForegroundColorAttributeName : (id)[UIColor blackColor].CGColor,
                                                                                               NSFontAttributeName : [UIFont systemFontOfSize:15.f],                                                                                               }];
    [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[UIColor blueColor].CGColor range:NSMakeRange(0, range.location +1)];
    lab.text = attString;
    lab.numberOfLines = 0;
    lab.font = [UIFont systemFontOfSize:15.f];
    lab.textAlignment = NSTextAlignmentLeft;
    [lab addLinkToURL:[NSURL URLWithString:link] withRange:NSMakeRange(0, range.location +1)];
    
    return lab;
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
       if ([self.delegate respondsToSelector:@selector(columnCell:commentLink:)]) {
        [self.delegate columnCell:self commentLink:url];
    }
}

@end
