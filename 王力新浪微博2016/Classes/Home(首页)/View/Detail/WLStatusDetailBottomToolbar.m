//
//  WLStatusDetailBottomToolbar.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusDetailBottomToolbar.h"

@implementation WLStatusDetailBottomToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        [self setupBtnWithIcon:@"timeline_icon_comment" title:@"转发"];
        [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"转发"];
    }
    return self;
}

-(UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:13];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    return btn;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageWithName:@"statusdetail_toolbar_background"]drawInRect:rect];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int btnCount = self.subviews.count;
    
    CGFloat margin = 10;
    CGFloat btnW = (self.width - (btnCount + 1)*margin)/btnCount;
    CGFloat btnY = 5;
    CGFloat btnH = self.height - 2 * btnY;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnY;
        btn.x = margin + i * (btnW +margin);
    }
}

@end
