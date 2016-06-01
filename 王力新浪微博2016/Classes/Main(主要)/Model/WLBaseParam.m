//
//  WLBaseParam.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBaseParam.h"
#import "WLAccount.h"
#import "WLAccountTool.h"

@implementation WLBaseParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.access_token = [WLAccountTool account].access_token;
    }
    return self;
}

+(instancetype)param
{
   return [[self alloc]init];
}

@end
