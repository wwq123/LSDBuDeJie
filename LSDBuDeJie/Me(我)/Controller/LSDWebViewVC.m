//
//  LSDWebViewVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/12.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDWebViewVC.h"
#import <WebKit/WebKit.h>

@interface LSDWebViewVC () <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goItem;
@end

@implementation LSDWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goItem.enabled = NO;
    self.backItem.enabled = NO;
    [self.view insertSubview:self.webView belowSubview:self.toolBar];
    //加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //加载状态
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setUrlString:self.urlStr];
}

- (void)setUrlString:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - 前进后退
- (IBAction)backItemClick:(UIBarButtonItem *)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (IBAction)goItemClick:(UIBarButtonItem *)sender {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    [self.progressView setProgress:0.f];
    
    //注入js，禁止长按出现粘贴，复制Item
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败 error : %@",error.localizedDescription);
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"loading"]) {
        self.backItem.enabled = self.webView.canGoBack;
        self.goItem.enabled = self.webView.canGoForward;
    }else if ([keyPath isEqualToString:@"estimatedProgress"]){
        if (self.webView.estimatedProgress == 1) {
            self.progressView.hidden = YES;
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            
        }
    }
}

#pragma mark - 懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        CGFloat webY = 64+self.progressView.lsd_height;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, webY, Screen_width,Screen_height - webY-44)];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"loading"];
}

@end
