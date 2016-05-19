//
//  EHStatusBarLevelWindowManager.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "EHStatusBarLevelWindowManager.h"

@interface EHStatusBarLevelWindowManager ()
@property (nonatomic, strong) UIWindow *notificationWindow;
@end


@implementation EHStatusBarLevelWindowManager
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        
    }
    return self;
}

#pragma mark - 单例
+ (instancetype) manager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 私有方法
- (void)initWindow:(UIWindow *)notificationWindow
{
    notificationWindow.backgroundColor = [UIColor clearColor];
    notificationWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    notificationWindow.windowLevel = UIWindowLevelStatusBar;
    notificationWindow.rootViewController = [UIViewController new];
    notificationWindow.rootViewController.view.clipsToBounds = YES;
    notificationWindow.rootViewController.view.frame = [[UIScreen mainScreen] bounds];
    notificationWindow.hidden = NO;
}

#pragma mark -接口方法，弹窗或者移除
- (void)showWindowWithView:(UIView *)view
{
    UIWindow *notificationWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initWindow:notificationWindow];
    
    [notificationWindow.rootViewController.view addSubview:view];
    _notificationWindow = notificationWindow;
    
}

- (void)showWindowWithViewController:(UIViewController *)viewController
{
    UIWindow *notificationWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initWindow:notificationWindow];
    notificationWindow.rootViewController = viewController;
    _notificationWindow = notificationWindow;
}

- (void)dismissWindow
{
    _notificationWindow.rootViewController = nil;
    _notificationWindow = nil;
}

@end
