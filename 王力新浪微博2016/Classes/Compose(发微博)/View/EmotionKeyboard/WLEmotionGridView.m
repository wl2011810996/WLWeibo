//
//  WLEmotionGridView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/14.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotionGridView.h"
#import "WLEmotion.h"
#import "WLEmotionView.h"
#import "WLEmotionPopView.h"
#import "WLEmotionTool.h"

@interface WLEmotionGridView()

@property (nonatomic, weak) UIButton *deleteButton;

@property(nonatomic,strong)NSMutableArray *emotionViews;

@property (nonatomic,strong)WLEmotionPopView *popView;

@end

@implementation WLEmotionGridView

- (WLEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [WLEmotionPopView popView];
    }
    return _popView;
}

-(NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
         [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 给自己添加一个长按手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (WLEmotionView *)emotionViewWithPoint:(CGPoint )point
{
    __block WLEmotionView *foundEmotionView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(WLEmotionView *emotionView, NSUInteger idx, BOOL * stop) {
        if (CGRectContainsPoint(emotionView.frame, point)) {
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

-(void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    WLEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.popView dismiss];
        
        [self selecteEmotion:emotionView.emotion];
    }else
    {
        [self.popView showFromEmotionView:emotionView];
    }
}

-(void)deleteClick
{
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WLEmotionDidDeletedNotification object:nil userInfo:nil];
}

-(void)selecteEmotion:(WLEmotion *)emotion
{
    if (emotion == nil) {
        return;
    }
#warning 注意：先添加使用的表情，再发通知
    // 保存使用记录
    [WLEmotionTool addRecentEmotion:emotion];
    
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WLEmotionDidSelectedNotification object:nil userInfo:@{WLSelectedEmotion : emotion}];
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    int count = emotions.count;
    int currentEmotionViewCount = self.emotionViews.count;
    
    for (int i= 0; i<count; i++) {
        WLEmotionView *emotionView = nil;
        if (i>=currentEmotionViewCount) {
            emotionView = [[WLEmotionView alloc]init];
            emotionView.backgroundColor = WLRandomColor;
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        }else
        {
            emotionView = self.emotionViews[i];
        }
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
        
    }
    
    for (int i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

-(void)emotionClick:(WLEmotionView *)emtionView
{
    [self.popView showFromEmotionView:emtionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
        
        
        // 选中表情
        [self selecteEmotion:emtionView.emotion];
    });
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftInset = 15;
    CGFloat topInset =15;
    

    // 1.排列所有的表情
    int count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / WLEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / WLEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.subviews[i];
        emotionView.x = leftInset + (i % WLEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / WLEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    
    //    // 2.删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;
    
}




@end
