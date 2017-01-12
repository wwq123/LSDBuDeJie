//
//  LSDFootView.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/11.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDFootView.h"
#import "LSDCollectionCell.h"

#define LSDCollectionCell_WH (Screen_width - (LSD_collcetionViewCols -1)*LSD_collectionCellMargin)/LSD_collcetionViewCols
static NSString *const LSDcollectionCellIdentifier = @"LSDcollectionCellIdentifier";
@interface LSDFootView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *modules;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end
@implementation LSDFootView

- (instancetype)initWithModules:(NSArray *)modules{
    if (self == [super init]) {
        self.backgroundColor = LSDColor(220, 220, 221);
        [self addSubview:self.collectionView];
        self.modules = modules;
    }
    return self;
}

- (void)setModules:(NSArray *)modules{
    _modules = modules;
    [self refreshFrameWithModulesCount:modules.count];
    [self.collectionView reloadData];
}

- (void)refreshFrameWithModulesCount:(NSInteger)count{
    NSInteger num = count/4;
    if (count%4>0) {
        num = num +1;
    }
    self.frame = CGRectMake(0, 0, Screen_width, num*LSDCollectionCell_WH);
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modules.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LSDCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LSDcollectionCellIdentifier forIndexPath:indexPath];
    LSDModuleItem *item = self.modules[indexPath.item];
    cell.moduleItem = item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LSDModuleItem *item = self.modules[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(footView:didSelectedItem:)]) {
        [self.delegate footView:self didSelectedItem:item];
    }
    
    if (self.didSelectedItem) {
        self.didSelectedItem(item);
    }
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = LSDColor(220, 220, 221);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LSDCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:LSDcollectionCellIdentifier];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = LSD_collectionCellMargin;
        _flowLayout.minimumInteritemSpacing = LSD_collectionCellMargin;
        _flowLayout.itemSize = CGSizeMake(LSDCollectionCell_WH, LSDCollectionCell_WH);
    }
    return _flowLayout;
}

@end
