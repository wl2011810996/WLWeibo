//
//  WLUnreadCountResult.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUnreadCountResult : NSObject

/**
 *  新微博未读数
 */
@property(nonatomic,assign)int status;

/**
 *  新粉丝数
 */
@property(nonatomic,assign)int follower;

/**
 *  新评论数
 */
@property(nonatomic,assign)int cmt;

/**
 *  新私信数
 */
@property(nonatomic,assign)int dm;

/**
 *  新提及我的微博数
 */
@property(nonatomic,assign)int mention_cmt;

/**
 *  新提及我的评论数
 */
@property(nonatomic,assign)int mention_status;

/**
 *  消息未读数
 */
-(int)messageCount;

/**
 *  所有未读数
 */
-(int)totalCount;





@end
