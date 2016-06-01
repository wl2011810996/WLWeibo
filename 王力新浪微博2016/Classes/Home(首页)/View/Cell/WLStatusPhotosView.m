//
//  WLStatusPhotosView.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/6.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusPhotosView.h"
#import "WLStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WLPhoto.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define WLStatusPhotosMaxCount 9
#define WLStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define WLStatusPhotoW 70
#define WLStatusPhotoH WLStatusPhotoW
#define WLStatusPhotoMargin 10

@interface WLStatusPhotosView()

@property (nonatomic, weak) UIImageView *imageView;
@property(nonatomic,assign)CGRect lastFrame;


@end

@implementation WLStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        
        self.userInteractionEnabled = YES;
        
        // 预先创建9个图片控件
        for (int i = 0; i<WLStatusPhotosMaxCount; i++) {
            WLStatusPhotoView *photoView = [[WLStatusPhotoView alloc]init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
        
    }
    return self;
}


-(void)tapPhoto:(UIGestureRecognizer *)recognizer
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    
    NSMutableArray *photos = [NSMutableArray array];
    int count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        WLPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc]init];
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    
    browser.photos = photos;
    
    browser.currentPhotoIndex = recognizer.view.tag;
    [browser show];
    
//    UIView *cover = [[UIView alloc]init];
//    cover.frame = [UIScreen mainScreen].bounds;
//    cover.backgroundColor = [UIColor blackColor];
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)]];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    
//    WLStatusPhotoView *photoView = (WLStatusPhotoView *)recognizer.view;
//    UIImageView *imageView = [[UIImageView alloc]init];
//    [imageView setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
//    imageView.frame = [cover convertRect:photoView.frame fromView:self];
//    self.lastFrame = imageView.frame;
//    [cover addSubview:imageView];
//    self.imageView = imageView;
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        CGRect frame = imageView.frame;
//        frame.size.width = cover.width; // 占据整个屏幕;
//        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
//        frame.origin.x = 0;
//        frame.origin.y = (cover.height - frame.size.height) * 0.5;
//        imageView.frame = frame;
//    }];
}

-(void)tapCover:(UIGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:2.0 animations:^{
        recognizer.view.backgroundColor = [UIColor clearColor];
        self.imageView.frame = self.lastFrame;
    }completion:^(BOOL finished) {
        [recognizer.view removeFromSuperview];
        self.imageView = nil;
    }];
}

-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    WLLog(@"/n------%@-------/n",pic_urls);
    
    
    
    for (int i = 0; i<WLStatusPhotosMaxCount; i++) {
        WLStatusPhotoView *photoView = self.subviews[i];
        if (i < pic_urls.count) {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        }else
        {
             photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.pic_urls.count;
    int maxCols = WLStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        WLStatusPhotoView *photoView = self.subviews[i];
        photoView.width = WLStatusPhotoW;
        photoView.height = WLStatusPhotoH;
        photoView.x = (i % maxCols) * (WLStatusPhotoW + WLStatusPhotoMargin);
        photoView.y = (i / maxCols) * (WLStatusPhotoH + WLStatusPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = WLStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * WLStatusPhotoW + (totalCols - 1) * WLStatusPhotoMargin;
    CGFloat photosH = totalRows * WLStatusPhotoH + (totalRows - 1) * WLStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
