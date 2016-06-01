//
//  WLCommonGroup.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCommonGroup : NSObject
/** 组头 */
@property (nonatomic,strong)NSString *header;
/** 组尾 */
@property (nonatomic,strong)NSString *footer;
/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic,strong)NSArray *items;

+(instancetype)group;

@end
