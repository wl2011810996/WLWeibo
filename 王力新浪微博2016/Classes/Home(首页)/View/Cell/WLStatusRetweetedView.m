//
//  WLStatusRetweetedView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusRetweetedView.h"
#import "WLStatusRetweetedFrame.h"
#import "WLStatus.h"
#import "WLUser.h"
#import "WLStatusPhotosView.h"

@interface WLStatusRetweetedView()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak)WLStatusPhotosView *photosView;

@end

@implementation WLStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = WLStatusRetweetedNameFont;
        nameLabel.textColor = WLColor(74, 102, 105);
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = WLStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.配图相册
        WLStatusPhotosView *photosView = [[WLStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        
    }
    return self;
}

-(void)setRetweetedFrame:(WLStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    WLStatus *retweetedStatus = retweetedFrame.retweetedStatus;
   // 取出用户数据
    WLUser *user = retweetedStatus.user;
    
     // 1.昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
      // 2.正文（内容）
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) {
        self.photosView.frame = retweetedFrame.photosFrame;
         self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    }else
    {
        self.photosView.hidden = YES;
    }
    
    
    
}

@end
