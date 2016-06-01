//
//  WLAccountTool.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLAccessTokenParam.h"
#import "WLAccount.h"
#import "WLBaseTool.h"

@class WLAccount;
@interface WLAccountTool : WLBaseTool

+(void)save:(WLAccount *)account;

+(WLAccount *)account;

+(void)accessTokenWithParam:(WLAccessTokenParam *)param success:(void(^)(WLAccount *account))success failure:(void(^)(NSError *error))failure;

@end
