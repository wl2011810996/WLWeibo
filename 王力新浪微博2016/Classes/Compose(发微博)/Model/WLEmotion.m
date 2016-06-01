
//
//  WLEmotion.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/14.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotion.h"
#import "NSString+Emoji.h"

@implementation WLEmotion

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ -%@",self.chs,self.png,self.code];
}

-(void)setCode:(NSString *)code
{
    _code = [code copy];
    
    self.emoji = [NSString emojiWithStringCode:code];
}

@end
