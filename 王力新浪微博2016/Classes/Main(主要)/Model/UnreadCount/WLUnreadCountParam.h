//
//  WLUnreadCountParam.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBaseParam.h"

@interface WLUnreadCountParam : WLBaseParam

/** false	int64	需要查询的用户ID。*/
@property(nonatomic,copy)NSString *uid;

@end
