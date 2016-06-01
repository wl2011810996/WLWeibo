
//
//  WLUserTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLUserTool.h"
#import "MJExtension.h"
#import "WLHttpTool.h"

@implementation WLUserTool

+(void)userInfoWithParam:(WLUserInfoParam *)param success:(void(^)(WLUserInfoResult *result))success failure:(void(^)(NSError *error))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[WLUserInfoResult class] success:success failure:failure];
}

+(void)unreadCountWithParam:(WLUnreadCountParam *)param success:(void (^)(WLUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[WLUnreadCountResult class] success:success failure:failure];
}

@end
