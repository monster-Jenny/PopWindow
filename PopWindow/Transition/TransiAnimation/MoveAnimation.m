//
//  MoveAnimation.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "MoveAnimation.h"

@interface MoveAnimation ()

@property (nonatomic, assign) MoveAnimationDirections moveDirection;

@end

@implementation MoveAnimation

+ (instancetype)moveWithAnimationDirection:(MoveAnimationDirections)direction
{
    return [[self alloc] initWithAnimationDirection:direction];
}

- (instancetype)initWithAnimationDirection:(MoveAnimationDirections)direction
{
    self = [super init];
    if (self) {
        self.moveDirection = direction;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (self.moveDirection) {
        case MoveLefts:
            [self moveLeftAnimateTransition:transitionContext];
            break;
        case MoveRights:
            [self moveRightAnimateTransition:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)moveLeftAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(containerView.frame.size.width, 0, containerView.frame.size.width, containerView.frame.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(-containerView.frame.size.width, 0);
        tempView.transform = CGAffineTransformMakeTranslation(-containerView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            //失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            //然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
}

- (void)moveRightAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *tempView = [transitionContext containerView].subviews[0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            //失败了接标记失败
            [transitionContext completeTransition:NO];
            tempView.alpha = 0;
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}

@end
