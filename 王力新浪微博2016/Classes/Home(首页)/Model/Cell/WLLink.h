//
//  WLLink.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLLink : NSObject

/** 链接文字 */
@property (nonatomic, copy) NSString *text;
/** 链接的范围 */
@property (nonatomic, assign) NSRange range;
/** 链接的边框 */
@property (nonatomic, strong) NSArray *rects;

@end
