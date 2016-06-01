//
//  WLHttpTool.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/26.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLHttpTool : NSObject



+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

+(void)post:(NSString *)url params:(NSDictionary *)parames sucess:(void(^)(id response))success failure:
(void (^)(NSError *error))failure;


@end
