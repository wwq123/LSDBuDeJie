//
//  LSDColumnCell.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/19.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LSDAllColumnItem;
@class LSDColumnCell;

@protocol LSDColumnCellDelegate <NSObject>
@optional

/**
 点击评论用户名的链接代理

 @param columnCell  self
 @param commentLink 点击评论用户名的链接
 */
- (void)columnCell:(LSDColumnCell *)columnCell commentLink:(NSURL *)commentLink;
@end
@interface LSDColumnCell : UITableViewCell
@property (nonatomic, strong) LSDAllColumnItem *columnItem;
@property (nonatomic, weak) id<LSDColumnCellDelegate> delegate;

- (instancetype)initWithTableView:(UITableView *)tableView;
+ (instancetype)columnCellWithTableView:(UITableView *)tableView;
@end
