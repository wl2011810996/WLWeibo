//
//  WLPopMenu.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/13.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLPopMenu.h"

@interface WLPopMenu()

@property (nonatomic, weak) UIButton *cover;
@property (nonatomic, weak) UIImageView *container;
@property (nonatomic, weak) UIView *contentView;

@end

@implementation WLPopMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        UIImageView *container = [[UIImageView alloc]init];
        container.userInteractionEnabled = YES;
        container.image = [UIImage resizedImage:@"popover_background"];
        [self addSubview:container];
        self.container = container;
    }
    return self;
}

-(instancetype)initWithContentView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.contentView = view;
    }
    return self;
}

+(instancetype)popMenuWithContentView:(UIView *)view
{
    
    return [[self alloc]initWithContentView:view];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

-(void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.3;
    }else
    {
        self.cover.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
    }
    
}

-(void)setPopMenuArrowPosition:(WLPopMenuArrowPostion)popMenuArrowPosition
{
    _popMenuArrowPosition = popMenuArrowPosition;
    switch (_popMenuArrowPosition) {
        case WLPopMenuArrowCenter:
            self.container.image = [UIImage resizedImage:@"popover_background"];
            break;
            
        case WLPopMenuArrowLeft:
            self.container.image = [UIImage resizedImage:@"popover_background_left"];
            break;
            
        case WLPopMenuArrowRight:
            self.container.image = [UIImage resizedImage:@"popover_background_right"];
            break;
    }
}

-(void)showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    self.container.frame = rect;
    
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

-(void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(dismissPopMenu:)]) {
        [self.delegate dismissPopMenu:self];
    }
    
    [self removeFromSuperview];
}

@end
