//
//  WLEmotionToolbar.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/14.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLEmotionToolbar;

typedef enum{
    WLEmotionTypeRecent, // 最近
    WLEmotionTypeDefault, // 默认
    WLEmotionTypeEmoji, // Emoji
    WLEmotionTypeLxh // 浪小花
}WLEmotionType;

@protocol WLEmotionToolbarDelegate  <NSObject>

@optional
- (void)emotionToolbar:(WLEmotionToolbar *)toolbar didSelectedButton:(WLEmotionType)emotionType;

@end


@interface WLEmotionToolbar : UIView

@property (nonatomic, weak) id<WLEmotionToolbarDelegate> delegate;

@end
