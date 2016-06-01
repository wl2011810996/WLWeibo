//
//  WLLoadMoreFooter.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/24.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLLoadMoreFooter.h"

@interface WLLoadMoreFooter()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation WLLoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"WLLoadMoreFooter" owner:nil options:nil]lastObject];
}


- (void)startRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉可以加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}



@end
