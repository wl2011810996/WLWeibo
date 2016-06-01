//
//  WLEmotionView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/14.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotionView.h"
#import "WLEmotion.h"

@implementation WLEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

-(void)setEmotion:(WLEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }else
    {
        NSString *icon = [NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png];
        UIImage *image = [[UIImage imageWithName:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
