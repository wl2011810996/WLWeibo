//
//  WLLoadMoreFooter.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/24.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLLoadMoreFooter : UIView

+(instancetype)footer;

-(void)startRefreshing;

-(void)endRefreshing;

@property(nonatomic,assign,getter=isRefreshing)BOOL refreshing;

@end
