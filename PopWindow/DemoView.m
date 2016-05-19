//
//  DemoView.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "DemoView.h"
@interface DemoView()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@end
@implementation DemoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 4, self.frame.size.height);
    for (int i = 0; i < 4; i ++) {
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        bgView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
        [self.scrollView addSubview:bgView];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

#pragma mark - delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger num = self.scrollView.contentOffset.x/self.frame.size.width;
    if (self.DragDelegate && [self.DragDelegate respondsToSelector:@selector(returnPageControlNumWithScrollViewContentOffSet:)]) {
        [self.DragDelegate returnPageControlNumWithScrollViewContentOffSet:num];
    }
}

@end
