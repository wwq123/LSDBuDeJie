//
//  LSDCollectionCell.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDCollectionCell.h"
#import "LSDButton.h"
#import "LSDModuleItem.h"
#import <UIImageView+WebCache.h>

@interface LSDCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation LSDCollectionCell
- (void)setModuleItem:(LSDModuleItem *)moduleItem{
    _moduleItem = moduleItem;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:moduleItem.icon]];
    [self.nameLab setText:moduleItem.name];
}
@end
