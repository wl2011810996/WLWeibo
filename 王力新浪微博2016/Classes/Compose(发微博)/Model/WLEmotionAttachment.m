//
//  WLEmotionAttachment.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/4/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotionAttachment.h"
#import "WLEmotion.h"

@implementation WLEmotionAttachment

-(void)setEmotion:(WLEmotion *)emotion
{
    _emotion = emotion;
    self.image = [UIImage imageWithName:[NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png]];
}

@end
