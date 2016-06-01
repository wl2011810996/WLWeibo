//
//  WLStatusRetweetedFrame.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusRetweetedFrame.h"
#import "WLStatus.h"
#import "WLUser.h"
#import "WLStatusPhotosView.h"

@implementation WLStatusRetweetedFrame

-(void)setRetweetedStatus:(WLStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    //1.昵称
    CGFloat nameX = WLStatusCellInset;
    CGFloat nameY = WLStatusCellInset*0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:WLStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame)+WLStatusCellInset*0.5;
    CGFloat textW = WLScreenW - 2*textX;
    CGSize textSize = [retweetedStatus.text sizeWithFont:WLStatusRetweetedTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    self.textFrame = (CGRect){{textX,textY},textSize};
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + WLStatusCellInset;
        CGSize photosSize = [WLStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + WLStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + WLStatusCellInset;
    }
    
    //4.自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = WLScreenW;
    self.frame = CGRectMake(x, y, w, h);
    
    
}

@end
