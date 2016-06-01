//
//  WLStatusDetailFrame.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusDetailFrame.h"
#import "WLStatus.h"
#import "WLStatusOriginalFrame.h"
#import "WLStatusRetweetedFrame.h"

@implementation WLStatusDetailFrame

-(void)setStatus:(WLStatus *)status
{
    _status = status;
    
    WLStatusOriginalFrame *originalFrame = [[WLStatusOriginalFrame alloc]init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    CGFloat h=0;
    if (status.retweeted_status) {
        WLStatusRetweetedFrame *retweetedFrame = [[WLStatusRetweetedFrame alloc]init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else
    {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    CGFloat x = 0;
    CGFloat y = WLStatusCellMargin;
    CGFloat w = WLScreenW;
    self.frame = CGRectMake(x, y, w, h);
    
    
}


@end
