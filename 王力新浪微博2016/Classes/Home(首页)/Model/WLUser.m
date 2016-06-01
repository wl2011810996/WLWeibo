//
//  WLUser.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/22.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLUser.h"

@implementation WLUser

+(instancetype)userWithDict:(NSDictionary *)dict
{
    WLUser *user = [[self alloc]init];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

-(BOOL)isVip
{
    return self.mbtype>2;
}

@end
