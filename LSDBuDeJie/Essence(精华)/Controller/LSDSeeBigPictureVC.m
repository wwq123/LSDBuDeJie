//
//  LSDSeeBigPictureVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/2/10.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDSeeBigPictureVC.h"
#import "LSDAllColumnItem.h"
#import "UIImageView+Extension.h"
#import "LSDMsgAlertView.h"
#import "LSDAssetTool.h"
#import <SVProgressHUD.h>

@interface LSDSeeBigPictureVC () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat zoomScale;
@end

@implementation LSDSeeBigPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.scrollView atIndex:0];
    [self.scrollView addSubview:self.imageView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    if (frameToCenter.size.width < boundsSize.width) { // 长图才会出现这种情况
        frameToCenter.origin.x = floor((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floor((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    // Center
    if (!CGRectEqualToRect(self.imageView.frame, frameToCenter)){
        self.imageView.frame = frameToCenter;
    }
}

- (void)setColumnItem:(LSDAllColumnItem *)columnItem{
    _columnItem = columnItem;
    [self.imageView downloadImageWithOriginalImageUrl:columnItem.image1 thumbImageUrl:columnItem.image0 placeholderImage:@"post_placeholderImage" completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            self.downLoadBtn.userInteractionEnabled = NO;
        }
    }];
    CGFloat width = Screen_width;
    CGFloat height = columnItem.height *width/columnItem.width;
    self.imageView.lsd_x = 0;
    self.imageView.lsd_width = width;
    self.imageView.lsd_height = height;
    if (height >Screen_height) {
        self.imageView.lsd_y = 0;
        self.scrollView.scrollEnabled = YES;
    }else{
        self.imageView.lsd_centerY = self.view.frame.size.height/2.f;
        self.scrollView.scrollEnabled = NO;
    }
    
    self.scrollView.maximumZoomScale = MAX(Screen_height/self.imageView.lsd_height,1.3);
    self.scrollView.minimumZoomScale = 1.0;
    self.zoomScale = 1.0;
    self.scrollView.contentSize = CGSizeMake(self.imageView.lsd_width, MAX(self.imageView.lsd_height, Screen_height));
}

#pragma mark - 按钮点击
- (IBAction)backBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//保存图片
- (IBAction)downLoadBtnClick:(UIButton *)sender {
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    //检查访问权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusRestricted) {
                [SVProgressHUD showErrorWithStatus:@"因系统原因,无法访问相册权限"];
            }else if (status == PHAuthorizationStatusAuthorized){//用户已授权访问相册
                [self saveImageIntoAblum];
            }else if (status == PHAuthorizationStatusDenied && oldStatus != PHAuthorizationStatusNotDetermined){//用户拒绝打开相册权限
                [SVProgressHUD showErrorWithStatus:@"请前往设置-隐私-图片重新打开相册访问权限开关"];
            }
        });
    }];
}

- (void)saveImageIntoAblum{
    //c函数保存图片到相机胶卷
    //        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //1.利用苹果自带的Photos框架保存图片到相机胶卷并获取刚刚保存的图片
    PHFetchResult<PHAsset *> *createAsset = [LSDAssetTool getPictureFromCamerRoll:self.imageView.image];
    if (createAsset == nil) {
        [LSDMsgAlertView showAlertViewWithMsg:@"图片保存失败" duration:1.5f];
        return;
    }
    
    //2.创建自定义相册
    NSString *title = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    [LSDAssetTool createAssetCollectionWithTitle:title complete:^(PHAssetCollection *collection, NSString *error) {
        if (error) {
            [LSDMsgAlertView showAlertViewWithMsg:@"相册创建失败" duration:1.5f];
            return;
        }
        //3.把图片保存到自定义相册中
        NSError *errors = nil;
        __block PHAssetCollectionChangeRequest *request = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        } error:&errors];
        if (errors) {
            LSDLog(@"request : %@",errors.localizedDescription);
            return;
        }
        
        NSError *addError = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [request insertAssets:createAsset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        } error:&addError];
        if (!addError) {
            [LSDMsgAlertView showAlertViewWithMsg:@"图片保存成功" duration:1.5f];
        }
    }];
}
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        LSDLog(@"saveError : %@",error.description);
//    }else{
//        [LSDMsgAlertView showAlertViewWithMsg:@"保存成功" duration:2.f];
//    }
//}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self.scrollView setNeedsLayout];
    [self.scrollView layoutIfNeeded];
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    self.scrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    self.scrollView.userInteractionEnabled = YES;
}

#pragma mark - UIGestureRecognizerDelegate
- (void)doubleTapEvent:(UITapGestureRecognizer *)doubleTap{
    self.scrollView.userInteractionEnabled = NO;
    CGPoint point = [doubleTap locationInView:doubleTap.view];
    CGFloat touchX = point.x;
    CGFloat touchY = point.y;
    touchX *= 1/self.zoomScale;
    touchY *= 1/self.zoomScale;
    touchX += self.scrollView.contentOffset.x;
    touchY += self.scrollView.contentOffset.y;
    [self handleDoubleTap:CGPointMake(touchX, touchY)];
}

- (void)handleDoubleTap:(CGPoint)point
{
    self.scrollView.userInteractionEnabled = NO;
    CGRect zoomRect = [self zoomRectForScale:[self willBecomeZoomScale] withCenter:point];
    [self.scrollView zoomToRect:zoomRect animated:YES];
    NSLog(@"self.scrollView.frame==%@,contentSize==%@,contentOffset==%@",NSStringFromCGRect(self.scrollView.frame),NSStringFromCGSize(self.scrollView.contentSize),NSStringFromCGPoint(self.scrollView.contentOffset));

}

- (CGFloat)willBecomeZoomScale
{
    if (self.zoomScale > self.scrollView.minimumZoomScale) {
        self.zoomScale = self.scrollView.minimumZoomScale;
        return self.scrollView.minimumZoomScale;
    } else {
        self.zoomScale = self.scrollView.maximumZoomScale;
        return self.scrollView.maximumZoomScale;
    }
}


- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center
{
    CGFloat height = self.scrollView.frame.size.height / scale;
    CGFloat width  = self.scrollView.frame.size.width  / scale;
    CGFloat x = center.x - width * 0.5;
    CGFloat y = center.y - height * 0.5;
    return CGRectMake(x, y, width, height);
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick:)];
        singleTap.numberOfTouchesRequired = 1;
        singleTap.numberOfTapsRequired = 1;
        
         UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapEvent:)];
        doubleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [_scrollView addGestureRecognizer:singleTap];
        [_scrollView addGestureRecognizer:doubleTap];
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
