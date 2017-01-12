//
//  LSDLoginRegistView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDLoginRegistView.h"

@interface LSDLoginRegistView ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LSDLoginRegistView
+ (instancetype)loginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

+ (instancetype)registView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage *image = _loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
