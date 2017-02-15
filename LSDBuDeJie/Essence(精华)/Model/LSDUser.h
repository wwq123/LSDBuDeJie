//
//  LSDUser.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/20.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDUser : NSObject
/**评论用户空间链接*/
@property (nonatomic, strong) NSString *personal_page;
/**用户头像*/
@property (nonatomic, strong) NSString *profile_image;
/**用户名*/
@property (nonatomic, strong) NSString *username;
@end
