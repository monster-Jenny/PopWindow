//
//  ChildViewController.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KWIDTH [[UIScreen mainScreen] bounds].size.width
#define KHEIGHT [[UIScreen mainScreen] bounds].size.height

@protocol ChildVCDismissDelegate <NSObject>

- (void)ChildVCDismiss;

@end

@interface ChildViewController : UIViewController

@property (nonatomic, assign) id<ChildVCDismissDelegate>dismissVCDelegate;

- (instancetype)initWithURLString:(NSString *)url withIndex:(NSInteger)index;

//- (instancetype)initWithIndex:(NSInteger)index;

@end
