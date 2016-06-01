//
//  WLStatusDetailFrame.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLStatus,WLStatusOriginalFrame,WLStatusRetweetedFrame;

@interface WLStatusDetailFrame : NSObject
@property(nonatomic,strong)WLStatusRetweetedFrame *retweetedFrame;
@property(nonatomic,strong)WLStatusOriginalFrame *originalFrame;

@property(nonatomic,strong)WLStatus *status;
@property(nonatomic,assign)CGRect frame;


@end
