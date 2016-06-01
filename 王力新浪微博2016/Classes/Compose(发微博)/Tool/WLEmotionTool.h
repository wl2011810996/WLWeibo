//
//  WLEmotionTool.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/4/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLEmotion;
@interface WLEmotionTool : NSObject

+(NSArray *)defaultEmotions;

+(NSArray *)emojiEmotions;

+(NSArray *)lxhEmotions;

+(NSArray *)recentEmotions;

+ (void)addRecentEmotion:(WLEmotion *)emotion;



@end
