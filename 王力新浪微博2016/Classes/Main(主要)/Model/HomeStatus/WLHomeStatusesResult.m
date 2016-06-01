//
//  WLHomeStatusesResult.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLHomeStatusesResult.h"
#import "MJExtension.h"
#import "WLStatus.h"

@implementation WLHomeStatusesResult

-(NSDictionary *)objectClassInArray
{
    return @{@"statuses":[WLStatus class]};
}

@end
