//
//  FatherViewController.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/11.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "FatherViewController.h"
#import "ChildViewController.h"
#import "EHStatusBarLevelWindowManager.h"


@interface FatherViewController ()<ChildVCDismissDelegate>

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray * childControllerArray;

@property (strong, nonatomic) UIViewController * currentVC;

@property (strong, nonatomic) UIPageControl * pageControl;

@property (assign, nonatomic) NSInteger groupNum;



@end

@implementation FatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数据源
    [self initData];
    
    //初始化界面
    [self initChildViewController];
    
    [self initPageControl];
    
    [self initSwipGesture];
}

- (void)initData
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:@[@"http://www.baidu.com",@"http://www.hao123.com",@"http://m.sohu.com/?_trans_=000019_hao123_dh",@"http:www.tmall.com"]];
    for (int i = 0; i < 1; i ++) {
        [self.dataArray addObjectsFromArray:@[@"http://www.baidu.com",@"http://www.hao123.com",@"http://m.sohu.com/?_trans_=000019_hao123_dh",@"http:www.tmall.com"]];
    }
    self.childControllerArray = [[NSMutableArray alloc] init];
    self.groupNum = 1;
}

#pragma mark - 初始化界面
- (void)initChildViewController
{
    for (int i = 0; i < self.dataArray.count; i ++) {
        ChildViewController * childVC = [[ChildViewController alloc] initWithURLString:self.dataArray[i] withIndex:i];
        [self.childControllerArray addObject:childVC];
        childVC.dismissVCDelegate = self;
        childVC.view.backgroundColor = [UIColor clearColor];
        [childVC.view setFrame:self.view.frame];
        if (i == 0) {
            self.currentVC = childVC;
            [self addChildViewController:childVC];
            [self.view addSubview:childVC.view];
        }
    }
}

- (void)initPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(KWIDTH/2-50, KHEIGHT - 65, 100, 40)];
    if (self.dataArray.count <= 10) {
        self.pageControl.numberOfPages = self.dataArray.count;
    }
    else
    {
        self.pageControl.numberOfPages = 10;
    }
    self.pageControl.currentPage = 0;
    [self.pageControl updateCurrentPageDisplay];
    self.pageControl.userInteractionEnabled = YES;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
//    [self.pageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pageControl];
}

- (void)initSwipGesture
{
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipRight:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipRight];
    
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeft:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipLeft];
}

#pragma mark - pageController的点击事件
- (void)pageControlClick:(UIPageControl *)pageControl
{
    __block UIViewController *selectVC = [self.childControllerArray objectAtIndex:pageControl.currentPage + 10 *(self.groupNum - 1)];
    if (self.currentVC == selectVC)
    {
        return;
    }
    else
    {
        NSInteger index = [self.childControllerArray indexOfObject:self.currentVC];
        if (index > pageControl.currentPage + 10 *(self.groupNum - 1)) {
            [self doAnimationWithDirection:MoveRight withIndex:index - 1];
        }
        else
        {
            [self doAnimationWithDirection:MoveLeft withIndex:index + 1];
        }
    }
}

- (void)swipRight:(UISwipeGestureRecognizer *)gesture
{
    NSInteger index = self.pageControl.currentPage;
    self.pageControl.currentPage --;
    if (index == 0) {
        if (self.groupNum != 1) {
            self.pageControl.currentPage = self.pageControl.numberOfPages;
            self.groupNum --;
            [self doAnimationWithDirection:MoveRight withIndex: 9 + 10 * (self.groupNum - 1)];
        }
        return;
    }
    else
    {
        [self doAnimationWithDirection:MoveRight withIndex:self.pageControl.currentPage + 10 * (self.groupNum - 1)];
    }
}

- (void)swipLeft:(UISwipeGestureRecognizer *)gesture
{
    NSInteger index = self.pageControl.currentPage;
    self.pageControl.currentPage ++;
    if (index == self.pageControl.numberOfPages - 1) {
        if ([self.childControllerArray indexOfObject:self.currentVC] != self.dataArray.count - 1) {
            self.pageControl.currentPage = 0;
            self.groupNum ++;
            [self doAnimationWithDirection:MoveLeft withIndex:10 * (self.groupNum - 1)];
        }
        return;
    }
    else
    {
        [self doAnimationWithDirection:MoveLeft withIndex:self.pageControl.currentPage + 10 * (self.groupNum - 1)];
    }
}

- (void)doAnimationWithDirection:(MoveAnimationDirection)direction withIndex:(NSInteger)index
{
    __block UIViewController *selectVC = [self.childControllerArray objectAtIndex:direction == MoveRight ? index  : index ];
    __weak typeof(self)WeakSelf = self;
    [self addChildViewController:selectVC];
    selectVC.view.frame = CGRectMake(direction == MoveRight ? - KWIDTH:KWIDTH, 0, KWIDTH, KHEIGHT);
    [self transitionFromViewController:_currentVC toViewController:selectVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selectVC.view.transform = CGAffineTransformTranslate(selectVC.view.transform,direction == MoveRight ? KWIDTH: - KWIDTH, 0);
        _currentVC.view.transform = CGAffineTransformTranslate(_currentVC.view.transform,direction == MoveRight ? KWIDTH: - KWIDTH, 0);
    } completion:^(BOOL finished) {
        if (finished)
        {
            [selectVC didMoveToParentViewController:WeakSelf];
            [_currentVC willMoveToParentViewController:nil];
            [_currentVC removeFromParentViewController];
            _currentVC = selectVC;
            selectVC = nil;
            [WeakSelf.view bringSubviewToFront:WeakSelf.pageControl];
        }
    }];
}


#pragma mark - ChildVCDismissDelegate
- (void)ChildVCDismiss
{
    [[EHStatusBarLevelWindowManager manager] dismissWindow];
}


- (void)dealloc
{
    self.currentVC = nil;
    self.childControllerArray = nil;
    [self.pageControl removeFromSuperview];
    self.pageControl = nil;
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
