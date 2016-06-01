//
//  WLStatusPhotosView.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/6.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLStatusPhotosView : UIView

/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property(nonatomic,strong)NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+(CGSize)sizeWithPhotosCount:(int)photosCount;



@end
