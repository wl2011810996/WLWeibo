//
//  WLAccountTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/21.
//  Copyright © 2016年 王力. All rights reserved.
//


#define WLAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "WLAccountTool.h"
#import "WLAccount.h"

@implementation WLAccountTool

+(void)save:(WLAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:WLAccountFilePath];
}

+(WLAccount *)account
{
    WLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:WLAccountFilePath];
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_time]!=NSOrderedAscending) {
        account = nil;
    }
    return account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */

+(void)accessTokenWithParam:(WLAccessTokenParam *)param success:(void(^)(WLAccount *account))success failure:(void(^)(NSError *error))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[WLAccount class] success:success failure:failure];
}

@end
