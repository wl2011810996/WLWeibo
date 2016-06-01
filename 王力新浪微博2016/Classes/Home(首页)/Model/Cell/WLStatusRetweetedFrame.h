//
//  WLStatusRetweetedFrame.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLStatus;

@interface WLStatusRetweetedFrame : NSObject
/** 昵称 */
@property(nonatomic,assign)CGRect nameFrame;

/** 正文 */
@property(nonatomic,assign)CGRect textFrame;

/** 自己的frame */
@property(nonatomic,assign)CGRect frame;

/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;

/** 转发微博的数据 */
@property(nonatomic,strong)WLStatus *retweetedStatus;

@end
