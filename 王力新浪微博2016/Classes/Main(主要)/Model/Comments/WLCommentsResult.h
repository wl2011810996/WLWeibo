//
//  WLCommentsResult.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCommentsResult : NSObject

/** 评论数组 */
@property (nonatomic, strong) NSArray *comments;
/** 评论总数 */
@property (nonatomic, assign) int total_number;

@end
