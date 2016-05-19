//
//  DemoCollectionViewCell.h
//  PopWindow
//
//  Created by 王蓉蓉 on 16/3/9.
//  Copyright © 2016年 王蓉蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DismissWindowDelegate <NSObject>

- (void)dismiss;

@end

@interface DemoCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) id<DismissWindowDelegate>delegate;


- (void)cellLoadWebViewWithUrl:(NSString *)urlStr;

@end
