//
//  DemoViewController.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"
#import "EHStatusBarLevelWindowManager.h"

@interface DemoViewController ()<DragScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView
{
    DemoView *demo = [[DemoView alloc] initWithFrame:CGRectMake(20, 100, 335, 400)];
    demo.backgroundColor = [UIColor blueColor];
    demo.layer.cornerRadius = 16;
    demo.layer.masksToBounds = YES;
    demo.DragDelegate = self;
    [self.view addSubview:demo];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 40, 40)];
    btn.backgroundColor = [UIColor yellowColor];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 550, 100, 40)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
}



- (void)dismiss
{
    [[EHStatusBarLevelWindowManager manager] dismissWindow];
}


- (void)returnPageControlNumWithScrollViewContentOffSet:(NSInteger)num
{
    self.pageControl.currentPage = num;
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
