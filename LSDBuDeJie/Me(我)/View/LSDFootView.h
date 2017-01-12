//
//  LSDFootView.h
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  LSDModuleItem;
@class LSDFootView;

@protocol LSDFootViewDelegate <NSObject>
@optional
- (void)footView:(LSDFootView *)footView didSelectedItem:(LSDModuleItem *)item;
@end

typedef void(^didSelectedItem)(LSDModuleItem *item);
@interface LSDFootView : UIView
@property (nonatomic, strong) didSelectedItem didSelectedItem;
@property (nonatomic, weak) id<LSDFootViewDelegate> delegate;

- (instancetype)initWithModules:(NSArray *)modules;
@end
