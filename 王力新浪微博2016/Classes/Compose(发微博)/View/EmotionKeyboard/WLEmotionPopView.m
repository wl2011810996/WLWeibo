//
//  WLEmotionPopView.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/4/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotionPopView.h"
#import "WLEmotionView.h"

@interface WLEmotionPopView()


@property (weak, nonatomic) IBOutlet WLEmotionView *emotionView;

@end

@implementation WLEmotionPopView


+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WLEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(WLEmotionView *)fromEmotionView
{
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage imageWithName:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}

@end
