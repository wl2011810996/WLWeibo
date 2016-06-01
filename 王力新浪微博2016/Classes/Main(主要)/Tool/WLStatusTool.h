//
//  WLStatusTool.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLHomeStatusesParam.h"
#import "WLHomeStatusesResult.h"
#import "WLSendStatusParam.h"
#import "WLSendStatusResult.h"
#import "WLCommentsParam.h"
#import "WLCommentsResult.h"
#import "WLRepostsParam.h"
#import "WLRepostsResult.h"
#import "WLBaseTool.h"

@interface WLStatusTool : WLBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)homeStatusesWith:(WLHomeStatusesParam *)param success:(void(^)(WLHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure ;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+(void)sendStatusesWith:(WLSendStatusParam *)param success:(void(^)(WLSendStatusResult *result))success failure:(void (^)(NSError *error))failure ;

/**
 *  加载评论数据
 */

+(void)commentsWithParam:(WLCommentsParam *)param success:(void(^)(WLCommentsResult *result))success failure:(void (^)(NSError *error))failure ;

/**
 *  加载转发数据
 */

+(void)repostsWithParam:(WLRepostsParam *)param success:(void(^)(WLRepostsResult *result))success failure:(void (^)(NSError *error))failure ;

@end
