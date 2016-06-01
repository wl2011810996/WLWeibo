//
//  WLStatusFrame.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusFrame.h"
#import "WLStatus.h"
#import "WLStatusDetailFrame.h"

@implementation WLStatusFrame

-(void)setStatus:(WLStatus *)status
{
    _status = status;
    [self setupDetailFrame];
    
    [self setupToolbarFrame];
    
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

-(void)setupDetailFrame
{
    WLStatusDetailFrame *detailFrame = [[WLStatusDetailFrame alloc]init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
}

-(void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = WLScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
