//
//  LSDCommentUserVC.m
//  LSDBuDeJie
//
//  Created by SelenaWong on 17/1/21.
//  Copyright © 2017年 SelenaWong. All rights reserved.
//

#import "LSDCommentUserVC.h"
#import <WebKit/WebKit.h>
@interface LSDCommentUserVC () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation LSDCommentUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self setUrl:self.url];
}

- (void)setUrl:(NSURL *)url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");    
    //注入js，禁止长按出现粘贴，复制Item
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载失败 error : %@",error.localizedDescription);
}

#pragma mark - 懒加载
- (WKWebView *)webView{
    if (_webView == nil) {
        CGFloat webY = LSD_NavH;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, webY, Screen_width,Screen_height - webY)];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

@end
