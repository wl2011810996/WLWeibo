//
//  WLControllerTool.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLControllerTool.h"
#import "WLTabBarViewController.h"
#import "WLNewFeatureController.h"

@implementation WLControllerTool

+(void)chooseRootViewController
{
    
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本：显示HMTabBarViewController
        [UIApplication sharedApplication].statusBarHidden = NO;
        window.rootViewController = [[WLTabBarViewController alloc] init];
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[WLNewFeatureController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}



@end
