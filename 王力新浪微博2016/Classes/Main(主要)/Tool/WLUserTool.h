//
//  WLUserTool.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBaseTool.h"
#import "WLUserInfoParam.h"
#import "WLUserInfoResult.h"
#import "WLUnreadCountParam.h"
#import "WLUnreadCountResult.h"


@interface WLUserTool : WLBaseTool

+(void)userInfoWithParam:(WLUserInfoParam *)param success:(void(^)(WLUserInfoResult *result))success failure:(void(^)(NSError *error))failure;

+(void)unreadCountWithParam:(WLUnreadCountParam *)param success:(void(^)(WLUnreadCountResult *result))success failure:(void(^)(NSError *error))failure;


@end
