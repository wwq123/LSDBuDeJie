//
//  LSDMsgAlertView.m
//  LSDMsgAlertView
//
//  Created by SelenaWong on 16/12/30.
//  Copyright © 2016年 SelenaWong. All rights reserved.
//

#import "LSDMsgAlertView.h"

#define MsgLabTextFont 13.f
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define SelfWidth 100
#define SelfHeight 30
#define kDefaultDuration 1.f
@interface LSDMsgAlertView ()
@property (nonatomic, strong) UILabel *msgLab;
@property (nonatomic, assign) BOOL isHide;
@end

@implementation LSDMsgAlertView

static LSDMsgAlertView * _alert;
- (id)copyWithZone:(NSZone *)zone{
    return _alert;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _alert;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alert = [super allocWithZone:zone];
    });
    return _alert;
}

+ (instancetype)shareAlertView{
    return [[self alloc] init];
}

+ (void)showAlertViewWithMsg:(NSString *)msg duration:(CGFloat)duration{
    [[LSDMsgAlertView shareAlertView] showMsg:msg duration:duration];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSetUI];
    }
    return self;
}

- (void)initSetUI{
    _isHide = YES;
    self.center = CGPointMake(ScreenWidth/2.f, ScreenHeight+ SelfHeight/2.f);
    self.bounds = CGRectMake(0, 0, SelfWidth, SelfHeight);
    self.alpha = 0.f;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.layer.cornerRadius = 6;
    self.msgLab.frame = self.bounds;
    [self addSubview:self.msgLab];
}

- (void)showMsg:(NSString *)msg duration:(CGFloat)duration{
    if (!_isHide) {
        return;
    }
    CGSize realSize = [msg boundingRectWithSize:CGSizeMake(SelfWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MsgLabTextFont]} context:nil].size;
    if (realSize.height >SelfHeight) {
        CGRect bounds = self.bounds;
        bounds.size = realSize;
        self.bounds = bounds;
        self.msgLab.frame = bounds;
    }
    self.msgLab.text = msg;
    [self show:duration];
}

- (void)show:(CGFloat)duration{
    _isHide = NO;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        self.center = CGPointMake(ScreenWidth/2.f, ScreenHeight/2.f);
    } completion:nil];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self performSelector:@selector(hideToash) withObject:nil afterDelay:duration];
    }];
}

- (void)hideToash{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _isHide = YES;
    }];
}
#pragma mark - 懒加载
- (UILabel *)msgLab{
    if (_msgLab == nil) {
        _msgLab = [[UILabel alloc] init];
        _msgLab.textColor = [UIColor whiteColor];
        _msgLab.font = [UIFont systemFontOfSize:MsgLabTextFont];
        _msgLab.textAlignment = NSTextAlignmentCenter;
        _msgLab.numberOfLines = 0;
    }
    return _msgLab;
}
@end
