//
//  WLHomeStatusesParam.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/28.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLBaseParam.h"

@interface WLHomeStatusesParam : WLBaseParam

/**	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
@property(nonatomic,strong)NSNumber *since_id;

/** false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
@property(nonatomic,strong)NSNumber *max_id;

/** false	int	单页返回的记录条数，最大不超过100，默认为20。*/
@property(nonatomic,strong)NSNumber *count;

@end
