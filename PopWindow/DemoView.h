//
//  DemoView.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DragScrollViewDelegate <NSObject>

- (void)returnPageControlNumWithScrollViewContentOffSet:(NSInteger)num;

@end

@interface DemoView : UIView

@property (assign, nonatomic) id<DragScrollViewDelegate>DragDelegate;

@end
