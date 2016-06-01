//
//  WLSendStatusParam.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSendStatusParam : NSObject
/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property(nonatomic,copy)NSString *access_token;

/**	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property(nonatomic,copy)NSString *starus;

@end
