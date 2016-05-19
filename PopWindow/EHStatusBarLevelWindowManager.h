//
//  EHStatusBarLevelWindowManager.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EHStatusBarLevelWindowManager : NSObject
+ (instancetype) manager;
- (void)showWindowWithView:(UIView *)view;
- (void)showWindowWithViewController:(UIViewController *)viewController;
- (void)dismissWindow;
@end
