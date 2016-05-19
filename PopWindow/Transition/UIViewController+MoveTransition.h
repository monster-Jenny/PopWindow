//
//  UIViewController+MoveTransition.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (MoveTransition)

- (void)transitionMoveFromViewController:(nonnull UIViewController *)fromViewController toViewController:(nonnull UIViewController *)toViewController duration:(NSTimeInterval)duration animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end
