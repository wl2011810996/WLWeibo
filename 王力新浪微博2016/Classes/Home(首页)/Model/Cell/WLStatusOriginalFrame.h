//
//  WLStatusOriginalFrame.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLStatus;

@interface WLStatusOriginalFrame : NSObject

/** 昵称 */
@property(nonatomic,assign)CGRect nameFrame;

/** 正文 */
@property(nonatomic,assign)CGRect textFrame;

/** 来源 */
@property(nonatomic,assign)CGRect sourceFrame;

/** 时间 */
@property(nonatomic,assign)CGRect timeFrame;

/** 头像 */
@property(nonatomic,assign)CGRect iconFrame;

/**   会员图标 **/
@property(nonatomic,assign)CGRect vipFrame;

/** 配图相册  */
@property(nonatomic,assign)CGRect photosFrame;


/** 自己的frame */
@property(nonatomic,assign)CGRect frame;

/** 微博数据 */
@property(nonatomic,strong)WLStatus *status;


@end
