//
//  LSDFastLoginView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDFastLoginView.h"
#import "LSDButton.h"
@implementation LSDFastLoginView

+ (instancetype)fastLoginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (IBAction)loginWayBtnClick:(LSDButton *)sender {
    if ([self.delegate respondsToSelector:@selector(fastLoginView:didSelectWhichLoginWay:)]) {
        [self.delegate fastLoginView:self didSelectWhichLoginWay:sender];
    }
}


@end
