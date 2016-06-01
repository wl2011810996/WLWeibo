//
//  WLStatusOriginalView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusOriginalView.h"
#import "WLStatusOriginalFrame.h"
#import "WLStatus.h"
#import "WLUser.h"
#import "UIImageView+WebCache.h"
#import "WLStatusPhotosView.h"



@interface WLStatusOriginalView()

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;

/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) WLStatusPhotosView *photosView;

@end

@implementation WLStatusOriginalView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = WLStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = WLStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = WLStatusOrginalTimeFont;
        timeLabel.backgroundColor = [UIColor cyanColor];
        timeLabel.textColor = [UIColor orangeColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = WLStatusOrginalSourceFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
//        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        WLStatusPhotosView *photosView = [[WLStatusPhotosView alloc]init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
    }
    return self;
}



-(void)setOriginalFrame:(WLStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    
    WLStatus *status = originalFrame.status;
    WLUser *user = status.user;
    
    // 1.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    }else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 2.正文（内容）
    self.textLabel.text = status.text;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 3.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame)+WLStatusCellInset * 0.5;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + WLStatusCellInset * 0.5;
//    CGSize timeSize = [status.created_at sizeWithFont:WLStatusOrginalTimeFont];
    CGSize timeSize =[status.created_at sizeWithAttributes:@{NSFontAttributeName:WLStatusOrginalTimeFont}];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 4.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + WLStatusCellInset;
    CGFloat sourceY = timeY;
        CGSize sourceSize =[status.source sizeWithAttributes:@{NSFontAttributeName:WLStatusOrginalSourceFont}];
//    CGSize sourceSize = [status.source sizeWithFont:WLStatusOrginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    // 6.配图相册
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
         self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
    }else
    {
        self.photosView.hidden = YES;
    }
}

@end
