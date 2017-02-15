//
//  LSDBottomView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/21.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDBottomView.h"
#import "LSDAllColumnItem.h"
#import <Masonry.h>

@interface LSDBottomView ()
@property (nonatomic, strong) UIButton *dingBtn;
@property (nonatomic, strong) UIButton *caiBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@end

@implementation LSDBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.dingBtn];
    [self addSubview:self.caiBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.commentBtn];
    [self.dingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.width.equalTo(self.shareBtn.width);
    }];
    [self.caiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingBtn.right).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.width.equalTo(self.dingBtn.width);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.caiBtn.right).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.width.equalTo(self.caiBtn.width);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtn.right).offset(0);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.width.equalTo(self.shareBtn.width);
    }];
}

- (void)setColumnItem:(LSDAllColumnItem *)columnItem{
    _columnItem = columnItem;
    
    [self setBtnTitle:self.dingBtn number:columnItem.ding placeholder:@"顶"];
    [self setBtnTitle:self.caiBtn number:columnItem.cai placeholder:@"踩"];
    [self setBtnTitle:self.shareBtn number:columnItem.repost placeholder:@"转发"];
    [self setBtnTitle:self.commentBtn number:columnItem.comment placeholder:@"评论"];
}

- (void)setBtnTitle:(UIButton *)btn number:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >=10000) {
        [btn setTitle:[NSString stringWithFormat:@"%.f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number >0){
        [btn setTitle:[NSString stringWithFormat:@"%ld",number] forState:UIControlStateNormal];
    }else{
        [btn setTitle:placeholder forState:UIControlStateNormal];
    }
}

#pragma mark - 按钮点击
- (void)dingBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)caiBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)shareBtnClick:(UIButton *)sender{
    
}

- (void)commentBtnClick:(UIButton *)sender{
    
}

#pragma mark - 懒加载
- (UIButton *)dingBtn{
    if (_dingBtn == nil) {
        _dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dingBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
        [_dingBtn setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:UIControlStateSelected];
        [_dingBtn setTitleColor:LSDColor(190, 196, 210) forState:UIControlStateNormal];
        [_dingBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_dingBtn addTarget:self action:@selector(dingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dingBtn;
}

- (UIButton *)caiBtn{
    if (_caiBtn == nil) {
        _caiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_caiBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
        [_caiBtn setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:UIControlStateSelected];
        [_caiBtn setTitleColor:LSDColor(190, 196, 210) forState:UIControlStateNormal];
        [_caiBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_caiBtn addTarget:self action:@selector(caiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _caiBtn;
}

- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"mainCellShareClick"] forState:UIControlStateSelected];
        [_shareBtn setTitleColor:LSDColor(190, 196, 210) forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"mainCellCommentClick"] forState:UIControlStateSelected];
        [_commentBtn setTitleColor:LSDColor(190, 196, 210) forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
@end
