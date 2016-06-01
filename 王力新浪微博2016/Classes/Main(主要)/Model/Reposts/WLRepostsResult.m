//
//  WLRepostsResult.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLRepostsResult.h"
#import "MJExtension.h"
#import "WLStatus.h"

@implementation WLRepostsResult

-(NSDictionary *)objectClassInArray
{
    return @{@"reposts":[WLStatus class]};
}

@end
