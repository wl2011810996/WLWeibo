//
//  WLEmotionKeyboard.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/13.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLEmotionKeyboard.h"
#import "WLEmotionListView.h"
#import "WLEmotionToolbar.h"
#import "MJExtension.h"
#import "WLEmotion.h"
#import "WLEmotionTool.h"


@interface WLEmotionKeyboard()<WLEmotionToolbarDelegate>

@property (nonatomic, weak) WLEmotionListView *listView;

@property (nonatomic, weak) WLEmotionToolbar *toolbar;

@property(nonatomic,strong)NSArray *defaultEmotions;

@property(nonatomic,strong)NSArray *emojiEmotions;

@property(nonatomic,strong)NSArray *lxhEmotions;

@end

@implementation WLEmotionKeyboard

-(NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [WLEmotion objectArrayWithFile:plist];
      [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

-(NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [WLEmotion objectArrayWithFile:plist];
        [self.emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    
    return _emojiEmotions;
}


- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [WLEmotion objectArrayWithFile:plist];
      [self.lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+(instancetype)keyboard
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];

        // 1.添加表情列表
        WLEmotionListView *listView = [[WLEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        WLEmotionToolbar *toolbar = [[WLEmotionToolbar alloc] init];
        toolbar.delegate = self;
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toolbar.width = self.width;
    self.toolbar.height = 35;
    self.toolbar.y = self.height - self.toolbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toolbar.y;
}

#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(WLEmotionToolbar *)toolbar didSelectedButton:(WLEmotionType)emotionType
{
    switch (emotionType) {
        case WLEmotionTypeDefault:// 默认
            self.listView.emotions = self.defaultEmotions;
            break;
            
        case WLEmotionTypeEmoji: // Emoji
            self.listView.emotions = self.emojiEmotions;
            break;
            
        case WLEmotionTypeLxh: // 浪小花
            self.listView.emotions = self.lxhEmotions;
            break;
        case WLEmotionTypeRecent:
            self.listView.emotions = [WLEmotionTool recentEmotions];
        default:
            break;
    }
    
}

@end
