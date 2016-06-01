//
//  WLUserInfoParam.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUserInfoParam : NSObject

/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property(nonatomic,copy)NSString *access_token;

/** false	int64	需要查询的用户ID。*/
@property(nonatomic,copy)NSString *uid;

@end
