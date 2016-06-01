//
//  WLStatus.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/22.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatus.h"
#import "WLUser.h"
#import "MJExtension.h"
#import "WLPhoto.h"
#import "NSDate+MJ.h"

@implementation WLStatus

-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[WLPhoto class]};
}


-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
             WLLog(@"%@",[fmt stringFromDate:createDate]);
        return [fmt stringFromDate:createDate];
   
    }
    
}

-(void)setSource:(NSString *)source
{
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location-range.location;
    
    NSString *subsource = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自%@",subsource];
}

+(instancetype)statusWithDict:(NSDictionary *)dict
{
    WLStatus *status = [[self alloc]init];
    
    status.text = dict[@"text"];
    
    status.user = [WLUser userWithDict:dict[@"user"]];
    
    NSDictionary *retweetedDict = dict[@"retweeted_status"];
    
    if (retweetedDict) {
        status.retweeted_status = [WLStatus statusWithDict:retweetedDict];
    }
    
    return status;
}

@end
