//
//  WLCommentsResult.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLCommentsResult.h"
#import "MJExtension.h"
#import "WLComment.h"

@implementation WLCommentsResult

-(NSDictionary *)objectClassInArray
{
    return @{@"comments":[WLComment class]};
}



@end
