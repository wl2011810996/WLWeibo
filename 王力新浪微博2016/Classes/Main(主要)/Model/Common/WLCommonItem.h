//
//  WLCommonItem.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCommonItem : NSObject
/** 图标 */
@property (nonatomic,strong)NSString *icon;
/** 标题 */
@property (nonatomic,strong)NSString *title;
/** 子标题 */
@property (nonatomic,strong)NSString *subtitle;
/** 右边显示的数字标记 */
@property (nonatomic,strong)NSString *badgeValue;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic,assign)Class destVcClass;
/** 封装点击这行cell想做的事情 */
// block 只能用 copy
@property (nonatomic,copy)void (^opetation)();

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+(instancetype)itemWithTitle:(NSString *)title;

@end
