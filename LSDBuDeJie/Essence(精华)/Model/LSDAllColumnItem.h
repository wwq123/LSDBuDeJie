//
//  LSDAllColumnItem.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/18.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LSDColumnType){
    LSDColumnTypeAll = 1,       //全部
    LSDColumnTypeVideo = 41,    //视频
    LSDColumnTypeSound = 31,    //音频
    LSDColumnTypePicture = 10,  //图片
    LSDColumnTypeJokes = 29,    //段子
};

@interface LSDAllColumnItem : NSObject
/**用户头像*/
@property (nonatomic, strong) NSString *profile_image;
/**用户名字*/
@property (nonatomic, strong) NSString *name;
/**帖子发布时间*/
@property (nonatomic, strong) NSString *passtime;
/**帖子文字内容*/
@property (nonatomic, strong) NSString *text;
/**缩略图*/
@property (nonatomic, strong) NSString *image0;
/**原图*/
@property (nonatomic, strong) NSString *image1;
/**中等图*/
@property (nonatomic, strong) NSString *image2;
/**标示是否是gif图片*/
@property (nonatomic, strong) NSString *is_gif;
/**标示是否是超长图片*/
@property (nonatomic, assign) BOOL isBigPicture;
/**点赞(顶)数量*/
@property (nonatomic, assign) NSInteger ding;
/**踩数量*/
@property (nonatomic, assign) NSInteger cai;
/**转发数量*/
@property (nonatomic, assign) NSInteger repost;
/**视频播放时间*/
@property (nonatomic, assign) NSInteger videotime;
/**声音播放时间*/
@property (nonatomic, assign) NSInteger voicetime;
/**播放次数*/
@property (nonatomic, assign) NSInteger playcount;
/**图片宽度*/
@property (nonatomic, assign) NSInteger width;
/**图片高度*/
@property (nonatomic, assign) NSInteger height;
/**评论数量*/
@property (nonatomic, assign) NSInteger comment;
/**帖子类型*/
@property (nonatomic, assign) NSInteger type;
/**评论数组*/
@property (nonatomic, strong) NSArray *top_cmt;

/**扩充属性,保存当前cell的高度*/
@property (nonatomic, assign) CGFloat cellHeight;
/**扩充属性,保存当前cell的中间内容的Frame*/
@property (nonatomic, assign) CGRect middleViewFrame;
/**扩充属性,保存当前cell的底部bottomView的Frame*/
@property (nonatomic, assign) CGRect bottomViewFrame;
/**扩充属性,保存当前cell的评论view的Frame*/
@property (nonatomic, assign) CGRect commentViewFrame;
/**扩充属性，保存前三条评论的高度和内容*/
@property (nonatomic, strong) NSMutableArray *comInfos;
@end
