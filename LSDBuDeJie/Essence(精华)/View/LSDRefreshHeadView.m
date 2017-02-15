//
//  LSDRefreshHeadView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/17.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDRefreshHeadView.h"

#define  IndicatorLeftMargin 5
#define  IndicatorTopMargin 1
#define  TextLabFont [UIFont systemFontOfSize:17.f]
@interface LSDRefreshHeadView ()
/**内容lab*/
@property (nonatomic, strong) UILabel *textLab;
/**指示器*/
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *containView;
@end

@implementation LSDRefreshHeadView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self.containView addSubview:self.indicatorView];
    [self.containView addSubview:self.textLab];
    [self addSubview:self.containView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat textLab_Width = [self.textLab.text sizeWithAttributes:@{NSFontAttributeName:TextLabFont}].width;
    CGFloat indicatorView_Width = self.lsd_height - IndicatorTopMargin*2;
    CGFloat containView_Width = textLab_Width+indicatorView_Width+IndicatorLeftMargin*2;
    
    self.containView.bounds = CGRectMake(0, 0, containView_Width, self.lsd_height);
    self.containView.center = CGPointMake(self.lsd_width*0.5, self.lsd_height*0.5);
    
    
    self.indicatorView.bounds = CGRectMake(0, 0, indicatorView_Width, indicatorView_Width);
    self.indicatorView.lsd_centerX = IndicatorLeftMargin + indicatorView_Width/2;
    self.indicatorView.lsd_centerY = self.containView.lsd_height/2;
    
    CGFloat textLab_X = IndicatorLeftMargin + CGRectGetMaxX(self.indicatorView.frame);
    self.textLab.frame = CGRectMake(textLab_X, 0,textLab_Width, self.containView.lsd_height);
}

- (void)setRefreshState:(LSDHeadViewRefreshState)refreshState{
    _refreshState = refreshState;
    switch (refreshState) {
        case LSDHeadViewNormalRefreshState:
            [self normalState];
            break;
            
        case LSDHeadViewWillRefreshState:
            [self willRefreshState];
            break;
            
        case LSDHeadViewRefreshingState:
            [self refreshingState];
            break;
            
        default:
            break;
    }
}

- (BOOL)isHeadViewRefreshing{
    return _headViewRefreshing;
}

#pragma mark - 私有方法(刷新状态)
//普通状态
- (void)normalState{
    self.headViewRefreshing = NO;
    self.textLab.text = @"下拉可以刷新";
    if (self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
    }
}
//即将刷新
- (void)willRefreshState{
    self.headViewRefreshing = NO;
    self.textLab.text = @"松开刷新数据";
    if (self.indicatorView.isAnimating) {
        [self.indicatorView stopAnimating];
    }
}
//正在刷新
- (void)refreshingState{
    self.headViewRefreshing = YES;
    self.textLab.text = @"正在刷新数据";
    if (!self.indicatorView.isAnimating) {
        [self.indicatorView startAnimating];
    }
}

#pragma mark - 懒加载
- (UILabel *)textLab{
    if (_textLab == nil) {
        _textLab = [[UILabel alloc] init];
        _textLab.font = TextLabFont;
        _textLab.textAlignment = NSTextAlignmentLeft;
        _textLab.textColor = [UIColor blackColor];
        _textLab.text = @"下拉可以刷新";
        [_textLab sizeToFit];
    }
    return _textLab;
}

- (UIActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _indicatorView.hidesWhenStopped = NO;
    }
    return _indicatorView;
}

- (UIView *)containView{
    if (_containView == nil) {
        _containView = [[UIView alloc] init];
    }
    return _containView;
}

@end
