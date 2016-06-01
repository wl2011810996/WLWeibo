//
//  WLCommonItem.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLCommonItem.h"

@implementation WLCommonItem

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    WLCommonItem *item = [[WLCommonItem alloc]init];
    item.title = title;
    item.icon = icon;
    return item;
}

@end
