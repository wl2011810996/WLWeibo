//
//  WLUser.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/22.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLUser : NSObject

/** string 	友好显示名称 */
@property(nonatomic,copy)NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property(nonatomic,copy)NSString *profile_image_url;

/** 会员类型 */
@property(nonatomic,assign)int mbtype;

/** 会员等级 */
@property(nonatomic,assign)int mbrank;


@property(nonatomic,assign,getter=isVip,readonly)BOOL vip;



+(instancetype)userWithDict:(NSDictionary *)dict;

@end
