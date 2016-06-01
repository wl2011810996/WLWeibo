//
//  WLStatusDetailTopToolbar.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusDetailTopToolbar.h"
#import "WLStatus.h"

@interface WLStatusDetailTopToolbar ()

@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIButton *attitudeButton;

@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@property (nonatomic, weak) UIButton *selectedButton;

- (IBAction)buttonClick:(id)sender;

@end

@implementation WLStatusDetailTopToolbar

+(instancetype)toolbar
{
    return [[[NSBundle mainBundle]loadNibNamed:@"WLStatusDetailTopToolbar" owner:nil options:nil]lastObject];
}

-(void)drawRect:(CGRect)rect
{
    rect.origin.y = 10;
    [[UIImage resizedImage:@"statusdetail_comment_top_background"]drawInRect:rect];
}

-(void)awakeFromNib
{
    self.retweetButton.tag = WLStatusDetailTopToolbarButtonTypeRetweeted;
    self.commentButton.tag = WlStatusDetailTopToolbarButtonTypeComment;
    self.backgroundColor = WLGlobalBg;
    
}

-(void)setDelegate:(id<WLStatusDetailTopToolbarDelegate>)delegate
{
    _delegate = delegate;
    [self buttonClick:self.commentButton];
}

- (IBAction)buttonClick:(UIButton *)button {
    self.selectedButtonType = button.tag;
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowView.centerX = button.centerX;
    }];
    
    if ([self.delegate respondsToSelector:@selector(topToolbar:didSelectedButton:)]) {
        [self.delegate topToolbar:self didSelectedButton:button.tag];
    }
}

-(void)setStatus:(WLStatus *)status
{
    _status = status;
    
    [self setupBtnTitle:self.retweetButton count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentButton count:status.commments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.attitudeButton count:status.attitudes_count defaultTitle:@"赞"];
}

-(void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    if (count>=10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@",count / 10000.0,defaultTitle];
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else if (count>0)
    {
        defaultTitle = [NSString stringWithFormat:@"%d %@",count,defaultTitle];
    }else
    {
        defaultTitle = [NSString stringWithFormat:@"0 %@",defaultTitle];
    }
    
    [button setTitle:defaultTitle forState:UIControlStateNormal];
#warning 最好同时设置多种状态下的文字
    [button setTitle:defaultTitle forState:UIControlStateSelected];
    
}

@end
