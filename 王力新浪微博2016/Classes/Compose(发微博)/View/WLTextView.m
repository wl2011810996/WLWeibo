//
//  WLTextView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/24.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLTextView.h"

@interface WLTextView()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation WLTextView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.backgroundColor =[UIColor clearColor];
        _placeholderLabel.numberOfLines = 0;
        
        [self addSubview:_placeholderLabel];
        
        self.placeholderColor = [UIColor lightGrayColor];
        
        self.font = [UIFont systemFontOfSize:14];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)textDidChange
{
    self.placeholderLabel.hidden = self.hasText;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _placeholderLabel.x = 5;
    _placeholderLabel.y = 8;
    _placeholderLabel.width = self.width - 2*_placeholderLabel.x;
    
    CGSize size = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
   CGSize placehoderSize= [self.placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:size];
    _placeholderLabel.height = placehoderSize.height;

    WLLog(@"%@",NSStringFromCGRect(self.placeholderLabel.frame));
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}



-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end
