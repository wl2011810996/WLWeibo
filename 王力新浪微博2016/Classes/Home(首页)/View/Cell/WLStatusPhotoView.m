//
//  WLStatusPhotoView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/6.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusPhotoView.h"
#import "WLPhoto.h"
#import "UIImageView+WebCache.h"

@interface WLStatusPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation WLStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
        // 这种情况下创建的UIImageView是没有尺寸的
        //        UIImageView *gifView1 = [[UIImageView alloc] init];
        //        gifView1.image = image;
    }
    return self;
}

-(void)setPhoto:(WLPhoto *)photo
{
    _photo = photo;
    
    WLLog(@"%@",photo.thumbnail_pic);
    
    // 1.下载图片
//    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"] options:SDWebImageContinueInBackground];
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    //    if ([extension isEqualToString:@"gif"]) {
    //        self.gifView.hidden = NO;
    //    } else {
    //        self.gifView.hidden = YES;
    //    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
