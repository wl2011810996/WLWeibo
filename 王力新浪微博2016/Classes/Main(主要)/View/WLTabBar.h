//
//  WLTabBar.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/18.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTabBar;
@protocol WLTabBarDelegate <NSObject>

-(void)tabBarDidClickPlusButton:(WLTabBar *)tabBar;

@end

@interface WLTabBar : UITabBar

@property (nonatomic,weak)id <WLTabBarDelegate>tabBardelegate;

@end
