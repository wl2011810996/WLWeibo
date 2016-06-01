//
//  WLBaseTool.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLBaseTool : NSObject

+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)classResut success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)classResut success:(void(^)(id))success failure:(void(^)(NSError *))failure;

@end
