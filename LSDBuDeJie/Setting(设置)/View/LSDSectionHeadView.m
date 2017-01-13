//
//  LSDSectionHeadView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/12.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSectionHeadView.h"

@interface LSDSectionHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
@implementation LSDSectionHeadView
+ (instancetype)headViewWithTableView:(UITableView *)tableView{
    static NSString *const identifier = @"head";
    LSDSectionHeadView *headView = (LSDSectionHeadView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headView == nil) {
        headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    return headView;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}
@end
