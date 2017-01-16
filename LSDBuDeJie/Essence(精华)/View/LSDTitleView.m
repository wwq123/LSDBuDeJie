//
//  LSDTitleView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/13.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDTitleView.h"

#define TitleBtnW  self.lsd_width/self.titleArr.count
#define TitleFont [UIFont systemFontOfSize:16.f]
#define SelectColor [UIColor redColor]
#define LineH  2.f
@interface LSDTitleView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
/**标题数组*/
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIButton *currentSelectBtn;
/**标题按钮数组*/
@property (nonatomic, strong) NSMutableArray *titleBtns;
@end
@implementation LSDTitleView
- (instancetype)initWithframe:(CGRect)frame titles:(NSArray<NSString *> *)titles{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.frame = frame;
        [self addSubview:self.scrollView];
        self.titleArr = titles;
    }
    return self;
}

+ (instancetype)titleViewWithframe:(CGRect)frame titles:(NSArray<NSString *> *)titles{
    return [[self alloc] initWithframe:frame titles:titles];
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self setSubviewWithTitles:titleArr];
}

- (void)setSubviewWithTitles:(NSArray *)titles{
    NSInteger count = titles.count;
    for (int i=0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(TitleBtnW *i, 0, TitleBtnW, LSD_titleViewH-LineH);
        btn.tag = i;
        [btn.titleLabel setFont:TitleFont];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:btn];
        [self.scrollView addSubview:btn];
        if (i == 0) {
            [self titleBtnClick:btn];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(TitleBtnW *count, 0)];
}

- (void)titleBtnClick:(UIButton *)sender{
    if (sender == self.currentSelectBtn) {
        return;
    }
    [self selectTitleBtn:sender];
    //回调
    if (self.didSelectBlock) {
        self.didSelectBlock(sender);
    }
}

//设置选中标题对应变化
- (void)selectTitleBtn:(UIButton *)sender{
    [sender setTitleColor:SelectColor forState:UIControlStateNormal];
    if (self.currentSelectBtn) {
        [self.currentSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [self moveBottomLineView:sender];
    [self setTitleBtnMediate:sender];
    self.currentSelectBtn = sender;
}

//设置选中标题底部下划线
- (void)moveBottomLineView:(UIButton *)sender{
    CGFloat lineWidth = [sender.currentTitle sizeWithAttributes:@{NSFontAttributeName:TitleFont}].width;
    [UIView animateWithDuration:0.3f animations:^{
        CGPoint center = CGPointMake(sender.lsd_centerX, CGRectGetMaxY(sender.frame)+LineH*0.5);
        self.lineView.bounds = CGRectMake(0, 0, lineWidth, LineH);
        self.lineView.center = center;
    } completion:^(BOOL finished) {
        if (!self.lineView.superview) {
            [self.scrollView addSubview:self.lineView];
        }
    }];
}

//设置标题按钮点击居中
- (void)setTitleBtnMediate:(UIButton *)sender{
    CGFloat offset = sender.lsd_centerX - self.lsd_width*0.5;
    if (offset <0) {
        offset = 0.f;
    }
    CGFloat maxOffset = self.scrollView.contentSize.width - self.lsd_width;
    if (offset >=maxOffset) {
        offset = maxOffset;
    }
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma mark - 外界调用方法
- (void)changeTitleBtnStateWithIndex:(NSInteger)index{
    if (index<self.titleBtns.count) {
        UIButton *sender = self.titleBtns[index];
        [self titleBtnClick:sender];
    }
}
#pragma mark = 懒加载
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = SelectColor;
    }
    return _lineView;
}

- (NSMutableArray *)titleBtns{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}
@end
