//
//  WLEmotionTextView.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/4/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLTextView.h"

@class WLEmotion;
@interface WLEmotionTextView : WLTextView

- (void)appendEmotion:(WLEmotion*)emotion;

- (NSString *)realText;

@end
