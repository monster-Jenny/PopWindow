//
//  DemoCollectionViewController.m
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/8.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import "DemoCollectionViewController.h"
#import "EHStatusBarLevelWindowManager.h"
#import "DemoCollectionViewCell.h"

#define NUMOFDOTS 7 //定义pageControl点的数量

@interface DemoCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DismissWindowDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger group;

@end

@implementation DemoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initView];
}

- (void)initView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(335, 400);
    layout.minimumInteritemSpacing = 100;
    layout.minimumLineSpacing = 40;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[DemoCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 40, 40)];
//    btn.backgroundColor = [UIColor yellowColor];
//    btn.layer.cornerRadius = 20;
//    btn.layer.masksToBounds = YES;
//    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 550, 100, 40)];
    if (self.dataArray.count >= NUMOFDOTS ) {
        self.pageControl.numberOfPages = NUMOFDOTS;
    }
    else
    {
        self.pageControl.numberOfPages = self.dataArray.count;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
}

- (void)initData
{
    self.dataArray = [[NSMutableArray alloc] initWithArray:@[@"http://www.baidu.com",@"http://www.hao123.com",@"http://m.sohu.com/?_trans_=000019_hao123_dh",@"http:www.tmall.com"]];
    for (int i = 0; i < 5; i ++) {
        [self.dataArray addObjectsFromArray:@[@"http://www.baidu.com",@"http://www.hao123.com",@"http://m.sohu.com/?_trans_=000019_hao123_dh",@"http:www.tmall.com"]];
    }
    self.group = self.dataArray.count / NUMOFDOTS ;
}

#pragma mark - DismissDelegate
- (void)dismiss
{
    [self.collectionView removeFromSuperview];
    [[EHStatusBarLevelWindowManager manager] dismissWindow];
}

#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell cellLoadWebViewWithUrl:self.dataArray[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(100, 20, 167, 20);
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.collectionView == scrollView) {
        NSInteger index = scrollView.contentOffset.x/self.view.frame.size.width;
        
        if (index / NUMOFDOTS == self.group) {
            self.pageControl.numberOfPages = self.dataArray.count - NUMOFDOTS * self.group;
        }
        else
        {
            self.pageControl.numberOfPages = NUMOFDOTS;
        }
        self.pageControl.currentPage = index%NUMOFDOTS;
    }
}

- (void)dealloc
{
    self.collectionView = nil;
    self.pageControl = nil;
    self.dataArray = nil;
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
