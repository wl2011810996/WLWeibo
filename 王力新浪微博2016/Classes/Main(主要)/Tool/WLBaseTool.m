//
//  WLBaseTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBaseTool.h"
#import "WLHttpTool.h"
#import "MJExtension.h"

@implementation WLBaseTool

+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)classResut success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [WLHttpTool get:url params:params success:^(id response) {
        if (success) {
            id result = [classResut objectWithKeyValues:response];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)classResut success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [WLHttpTool post:url params:params sucess:^(id response) {
        if (success) {
            id result = [classResut objectWithKeyValues:response];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
