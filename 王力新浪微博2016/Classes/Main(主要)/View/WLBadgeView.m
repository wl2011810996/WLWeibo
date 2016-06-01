//
//  WLBadgeView.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBadgeView.h"

@implementation WLBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleSize.width<bgW) {
        self.width = bgW;
    }else
    {
        self.width = titleSize.width + 10;
    }
}

@end
