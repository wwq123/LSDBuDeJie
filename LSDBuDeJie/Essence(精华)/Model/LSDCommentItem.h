//
//  LSDCommentItem.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/20.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSDUser;
@interface LSDCommentItem : NSObject
/**评论内容*/
@property (nonatomic, strong) NSString *content;
/**评论用户信息*/
@property (nonatomic, strong) LSDUser *user;
@end
