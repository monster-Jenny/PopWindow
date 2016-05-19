//
//  ViewController.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "DemoView.h"
#import "EHStatusBarLevelWindowManager.h"
#import "DemoCollectionViewController.h"
#import "FatherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initBtn];
}

- (void)initBtn
{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(popWindow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(popWindow2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)popWindow
{
//    DemoViewController *demo = [[DemoViewController alloc] init];
//    demo.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    [[EHStatusBarLevelWindowManager manager] showWindowWithViewController:demo];
    FatherViewController *fatherVC = [[FatherViewController alloc] init];
    fatherVC.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
//    fatherVC.view.backgroundColor = [UIColor clearColor];
    [[EHStatusBarLevelWindowManager manager] showWindowWithViewController:fatherVC];
}

- (void)popWindow2
{
    DemoCollectionViewController *demo = [[DemoCollectionViewController alloc] init];
    demo.view.backgroundColor = [UIColor clearColor];
    [[EHStatusBarLevelWindowManager manager] showWindowWithViewController:demo];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
