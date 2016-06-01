//
//  WLStatusFrame.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLStatus,WLStatusDetailFrame;

@interface WLStatusFrame : NSObject

@property(nonatomic,assign)CGRect toolbarFrame;
@property(nonatomic,strong)WLStatusDetailFrame *detailFrame;


@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,strong)WLStatus *status;


@end
