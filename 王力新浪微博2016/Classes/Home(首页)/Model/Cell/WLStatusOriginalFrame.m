//
//  WLStatusOriginalFrame.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusOriginalFrame.h"
#import "WLUser.h"
#import "WLStatus.h"
#import "WLStatusPhotosView.h"

@implementation WLStatusOriginalFrame

-(void)setStatus:(WLStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = WLStatusCellInset;
    CGFloat iconY = WLStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
     // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame)+WLStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:WLStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame)+WLStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
     // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame)+WLStatusCellInset;
    CGSize textSize = [status.text sizeWithFont:WLStatusOrginalTextFont constrainedToSize:CGSizeMake(WLScreenW-2*textX, MAXFLOAT)];
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat h= 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + WLStatusCellInset;
        CGSize photosSize = [WLStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photosSize};
        h = CGRectGetMaxY(self.photosFrame) +WLStatusCellInset;
    }else{
        h = CGRectGetMaxY(self.textFrame)+WLStatusCellInset;
    }
    
      // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WLScreenW;
    self.frame = CGRectMake(x, y, w, h);
    
    
    
    
}

@end
