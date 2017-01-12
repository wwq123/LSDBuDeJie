//
//  LSDTextField.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDTextField.h"
#import "UITextField+PlaceHolderColor.h"

@implementation LSDTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(editBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editEnd) forControlEvents:UIControlEventEditingDidEnd];
    self.placeHolderColor = [UIColor lightGrayColor];
}

- (void)editBegin{
    self.placeHolderColor = [UIColor whiteColor];
}

- (void)editEnd{
    self.placeHolderColor = [UIColor lightGrayColor];
}

@end
