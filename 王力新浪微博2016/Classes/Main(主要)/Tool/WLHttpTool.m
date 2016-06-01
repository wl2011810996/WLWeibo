//
//  WLHttpTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/26.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLHttpTool.h"
#import "AFNetworking.h"

@implementation WLHttpTool

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params sucess:(void(^)(id response))success failure:
(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

@end
