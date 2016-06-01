//
//  WLEmotionPopView.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/4/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLEmotionView;

@interface WLEmotionPopView : UIView

+(instancetype)popView;

- (void)showFromEmotionView:(WLEmotionView *)fromEmotionView;

- (void)dismiss;

@end
