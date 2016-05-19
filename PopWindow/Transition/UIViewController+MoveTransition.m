//
//  UIViewController+MoveTransition.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "UIViewController+MoveTransition.h"

@implementation UIViewController (MoveTransition)

- (void)transitionMoveFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL))completion
{
//    UIView *tempView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
//    tempView.frame = fromViewController.view.frame;
//    fromViewController.view.hidden = YES;
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:tempView];
//    [containerView addSubview:toVC.view];
    toViewController.view.frame = CGRectMake(fromViewController.view.frame.size.width, 0, fromViewController.view.frame.size.width, fromViewController.view.frame.size.height);
    [UIView animateWithDuration:duration animations:^{
        toViewController.view.transform = CGAffineTransformMakeTranslation(-fromViewController.view.frame.size.width, 0);
        fromViewController.view.transform = CGAffineTransformMakeTranslation(-fromViewController.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        toViewController.view.frame = CGRectMake(0, 0, fromViewController.view.frame.size.width, fromViewController.view.frame.size.height);
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
//        if ([transitionContext transitionWasCancelled]) {
//            //失败后，我们要把vc1显示出来
//            fromVC.view.hidden = NO;
//            //然后移除截图视图，因为下次触发present会重新截图
//            [tempView removeFromSuperview];
//        }

    }];
}
@end
