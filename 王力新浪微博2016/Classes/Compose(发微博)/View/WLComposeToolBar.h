//
//  WLComposeToolBar.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/24.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WLComposeToolbarButtonTypeCamera, // 照相机
    WLComposeToolbarButtonTypePicture, // 相册
    WLComposeToolbarButtonTypeMention, // 提到@
    WLComposeToolbarButtonTypeTrend, // 话题
    WLComposeToolbarButtonTypeEmotion // 表情
} WLComposeToolbarButtonType;

@class WLComposeToolbar;

@protocol WLComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(WLComposeToolbar *)toolbar didClickedButton:(WLComposeToolbarButtonType)buttonType;

@end

@interface WLComposeToolBar : UIView
@property (nonatomic, weak) id<WLComposeToolbarDelegate> delegate;

@property(nonatomic,assign,getter=isEmotionButton)BOOL showEmotionButton;


@end