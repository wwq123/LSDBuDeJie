//
//  LSDSectionHeadView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/12.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDSectionHeadView : UIView
@property (nonatomic, strong) NSString *title;
+ (instancetype)headViewWithTableView:(UITableView *)tableView;
@end
