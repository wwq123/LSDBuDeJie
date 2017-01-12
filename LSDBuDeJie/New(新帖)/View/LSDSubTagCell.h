//
//  LSDSubTagCell.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSDSubTagItem;

@interface LSDSubTagCell : UITableViewCell
@property (nonatomic, strong) LSDSubTagItem *subTagItem;
+ (instancetype)subCellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;
@end
