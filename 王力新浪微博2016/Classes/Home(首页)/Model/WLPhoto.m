//
//  WLPhoto.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/22.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLPhoto.h"

@implementation WLPhoto

-(void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
