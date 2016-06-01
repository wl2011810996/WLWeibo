//
//  WLStatusDetailView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusDetailView.h"
#import "WLStatusRetweetedView.h"
#import "WLStatusOriginalView.h"
#import "WLStatusDetailFrame.h"


@interface WLStatusDetailView()

@property (nonatomic, weak) WLStatusOriginalView *originalView;
@property (nonatomic, weak) WLStatusRetweetedView *retweetedView;

@end

@implementation WLStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        [self setupOriginalView];
        
        [self setupRetweetedView];
    }
    return self;
}



-(void)setupOriginalView
{
    WLStatusOriginalView *originalView = [[WLStatusOriginalView alloc]init];
    [self addSubview:originalView];
    self.originalView = originalView;
}


-(void)setupRetweetedView
{
    WLStatusRetweetedView *retweetedView = [[WLStatusRetweetedView alloc]init];
    [self addSubview:retweetedView];
    self.retweetedView = retweetedView;
}


-(void)setDetailFrame:(WLStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    self.frame = detailFrame.frame;
    
    self.originalView.originalFrame = detailFrame.originalFrame;
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}


@end
