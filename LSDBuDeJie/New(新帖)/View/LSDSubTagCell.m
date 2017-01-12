//
//  LSDSubTagCell.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/9.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSubTagCell.h"
#import "LSDSubTagItem.h"
#import <UIImageView+WebCache.h>

@interface LSDSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation LSDSubTagCell

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *const subTagCellIdentifier = @"LSDSubTagCell";
    self = [tableView dequeueReusableCellWithIdentifier:subTagCellIdentifier];
    if (self == nil) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LSDSubTagCell class]) owner:nil options:nil].firstObject;
    }
    return self;
}

+ (instancetype)subCellWithTableView:(UITableView *)tableView{
    return [[self alloc] initWithTableView:tableView];
}

- (IBAction)subBtnClick:(UIButton *)sender {
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.headImageV.layer.cornerRadius = (self.lsd_height - 10*2)/2.f;
    self.headImageV.layer.masksToBounds = YES;
}

- (void)setSubTagItem:(LSDSubTagItem *)subTagItem{
    _subTagItem = subTagItem;
    
    self.nameLab.text = subTagItem.theme_name;
    
    //处理订阅数字
    NSString *numString = [NSString stringWithFormat:@"%@人订阅",subTagItem.sub_number];
    NSInteger num = subTagItem.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num/10000.0;
        numString = [NSString stringWithFormat:@"%.f万人订阅",numF];
        numString = [numString stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.numberLab.text = numString;
    
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
