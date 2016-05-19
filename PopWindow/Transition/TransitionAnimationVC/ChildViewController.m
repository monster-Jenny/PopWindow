//
//  ChildViewController.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "ChildViewController.h"
#import <IMYWebView.h>

@interface ChildViewController ()<IMYWebViewDelegate>

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) IMYWebView *webView;

@end

@implementation ChildViewController

- (instancetype)initWithURLString:(NSString *)url withIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.urlString = url;
        self.index = index;
    }
    return self;
}

//- (instancetype)initWithIndex:(NSInteger)index
//{
//    self = [super init];
//    if (self) {
//        self.index = index;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化页面
    [self initPopWebView];
    
    [self initDismissButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initDismissButton
{
    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 70, 30, 30)];
    dismissBtn.backgroundColor = [UIColor yellowColor];
    dismissBtn.layer.cornerRadius = 15;
    dismissBtn.layer.masksToBounds = YES;
    [dismissBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

- (void)initPopWebView
{
    self.webView = [[IMYWebView alloc] initWithFrame:CGRectMake(30, 81, KWIDTH - 60, KHEIGHT - 162) usingUIWebView:NO];
    self.webView.layer.cornerRadius = 4;
    self.webView.layer.masksToBounds = YES;
    self.webView.backgroundColor = [UIColor colorWithRed:(self.index * 60)/255.0f green:(self.index * 60)/255.0f blue:(self.index * 60)/255.0f alpha:1];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    [self.view addSubview: self.webView];
    NSURL *url = [[NSURL alloc] initWithString:self.urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                            timeoutInterval:5.0];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - btn的点击事件
- (void)dismissBtnClick:(UIButton *)sender
{
    [self.webView stopLoading];
    if (self.dismissVCDelegate && [self.dismissVCDelegate respondsToSelector:@selector(ChildVCDismiss)]) {
        [self.dismissVCDelegate ChildVCDismiss];
    }
}

#pragma mark - delegate
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


- (void)dealloc
{
    [self.webView removeFromSuperview];
    self.webView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
