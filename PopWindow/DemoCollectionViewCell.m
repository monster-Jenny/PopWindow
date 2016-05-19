//
//  DemoCollectionViewCell.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/9.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "DemoCollectionViewCell.h"
#import <IMYWebView.h>

@interface DemoCollectionViewCell ()<IMYWebViewDelegate>
@property (strong, nonatomic) IMYWebView *webView;
@end

@implementation DemoCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCellView];
    }
    return self;
}

- (void)prepareForReuse
{
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
    [self initWebView];
    UIButton *btn = [self.contentView viewWithTag:10000];
    [self.contentView bringSubviewToFront:btn];
}

- (void)initCellView
{
    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
    self.contentView.layer.cornerRadius = 16;
//    self.contentView.layer.masksToBounds = YES;
    [self initWebView];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(-10, -10, 40, 40)];
    btn.backgroundColor = [UIColor yellowColor];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    btn.tag = 10000;
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}

- (void)initWebView
{
    self.webView = [[IMYWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) usingUIWebView:NO];
    self.webView.layer.cornerRadius = 16;
    self.webView.layer.masksToBounds = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    [self.contentView addSubview: self.webView];
}

- (void)cellLoadWebViewWithUrl:(NSString *)urlStr
{
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                            timeoutInterval:5.0];
    [self.webView loadRequest:urlRequest];
}


#pragma mark - WebViewDelegate

- (void)webView:(IMYWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"加载失败");
}

- (void)webViewDidFinishLoad:(IMYWebView *)webView
{
//    NSLog(@"加载完成");
}

- (void)webViewDidStartLoad:(IMYWebView *)webView
{
//    NSLog(@"开始加载");
}

- (BOOL)webView:(IMYWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)dismiss
{
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismiss)]) {
        [self.delegate dismiss];
    }
}

- (void)dealloc
{
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    self.delegate = nil;
}

@end
