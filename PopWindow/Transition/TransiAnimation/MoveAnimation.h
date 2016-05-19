//
//  MoveAnimation.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MoveAnimationDirections) {
    MoveLefts = 0,
    MoveRights
};

@interface MoveAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)moveWithAnimationDirection:(MoveAnimationDirections)direction;

- (instancetype)initWithAnimationDirection:(MoveAnimationDirections)direction;

@end
