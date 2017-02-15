//
//  LSDAllColumnItem.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/18.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDAllColumnItem.h"
#import "LSDCommentItem.h"
#import "LSDUser.h"

#define cellWidth (Screen_width-LSD_ColumnUnifyMargin *2)
@implementation LSDAllColumnItem
+(NSDictionary*)mj_objectClassInArray{
    
    return @{
             @"top_cmt":[LSDCommentItem class]
             };
}

- (CGFloat)cellHeight{
    if (_cellHeight !=0) {
        return _cellHeight;
    }
    //cell顶部TopView高度
    _cellHeight += LSD_ColumnCellTopViewHeight;
    
    //计算内容text高度并加上textLab和顶部bottomView的间距
    CGSize textSize = CGSizeMake(cellWidth, MAXFLOAT);
    if (self.text) {
        CGSize realSize = [self.text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil].size;
        _cellHeight += (realSize.height + LSD_ColumnUnifyMargin);
    }
   
    //中间内容的Frame(视频,声音,图片)
    if (self.type !=LSDColumnTypeJokes) {
        CGFloat middleH = 1.0*cellWidth*self.height/self.width;
        if (middleH >=Screen_height) {//如果图片高度大于屏幕高度，就属于超长图
            middleH = 200.f;
            self.isBigPicture = YES;
        }
        self.middleViewFrame = CGRectMake(LSD_ColumnUnifyMargin, _cellHeight, cellWidth, middleH);
        _cellHeight += (middleH + LSD_ColumnUnifyMargin);
    }
    
    self.bottomViewFrame = CGRectMake(0, _cellHeight, Screen_width, LSD_ColumnCellBottomViewHeight);
    
    //计算cell底部BottomView高度
    _cellHeight += LSD_ColumnCellBottomViewHeight;
    
    //计算评论的高度
    if (self.top_cmt.count >0) {
        CGFloat commentViewHeight = 0;
        for (NSDictionary *dic in self.comInfos) {
            commentViewHeight += [dic[@"height"] floatValue];
        }
        commentViewHeight += (self.comInfos.count + 1)*5;
        self.commentViewFrame = CGRectMake(LSD_ColumnUnifyMargin,_cellHeight, cellWidth,commentViewHeight);
        
        _cellHeight += commentViewHeight;
        _cellHeight += LSD_ColumnUnifyMargin;
    }
    


    return _cellHeight;
}

- (NSMutableArray *)comInfos{
    if (_comInfos == nil) {
        _comInfos = [NSMutableArray array];
        if (self.top_cmt.count >0) {
            if (self.top_cmt.count >3) {//如果评论数大于3条，取前3条
                for (int i=0; i<3; i++) {
                    LSDCommentItem *commentItem = self.top_cmt[i];
                    NSString *com = [self commentWithUserName:commentItem.user.username content:commentItem.content];
                    CGSize comSize = CGSizeMake(cellWidth, MAXFLOAT);
                    CGSize realSize = [com boundingRectWithSize:comSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil].size;
                    NSDictionary *dic = @{@"info":com,@"height":@(realSize.height),@"link":commentItem.user.personal_page};
                    [self.comInfos addObject:dic];
                }
            }else{//只有一条
                for (int i=0; i<self.top_cmt.count; i++) {
                    LSDCommentItem *commentItem = self.top_cmt[i];
                    NSString *com = [self commentWithUserName:commentItem.user.username content:commentItem.content];
                    CGSize comSize = CGSizeMake(cellWidth, MAXFLOAT);
                    CGSize realSize = [com boundingRectWithSize:comSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:nil].size;
                    NSDictionary *dic = @{@"info":com,@"height":@(realSize.height),@"link":commentItem.user.personal_page};
                    [self.comInfos addObject:dic];
                }
            }
        }
    }
    return _comInfos;
}

/**
 评论

 @param userName 评论用户的名字
 @param content  评论内容

 @return 评论
 */
- (NSString *)commentWithUserName:(NSString *)userName content:(NSString *)content{
    NSString *comment = [NSString stringWithFormat:@"%@: %@",userName,content];
    return comment;
}
@end
