//
//  WLStatusTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusTool.h"
#import "WLHttpTool.h"
#import "MJExtension.h"

@implementation WLStatusTool

+(void)homeStatusesWith:(WLHomeStatusesParam *)param success:(void (^)(WLHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[WLHomeStatusesResult class] success:success failure:failure];
}

+(void)sendStatusesWith:(WLSendStatusParam *)param success:(void (^)(WLSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[WLSendStatusResult class] success:success failure:failure];
}

+(void)repostsWithParam:(WLRepostsParam *)param success:(void (^)(WLRepostsResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/repost_timeline.json" param:param resultClass:[WLRepostsResult class] success:success failure:failure];
}

+(void)commentsWithParam:(WLCommentsParam *)param success:(void (^)(WLCommentsResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/comments/show.json" param:param resultClass:[WLCommentsResult class] success:success failure:failure];
}



@end
