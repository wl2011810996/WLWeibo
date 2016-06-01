//
//  AppDelegate.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "AppDelegate.h"
#import "WLTabBarViewController.h"
#import "WLNewFeatureController.h"
#import "WLOAuthViewController.h"
#import "WLControllerTool.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    [self.window makeKeyAndVisible];
    
    WLLog(@"%@",NSHomeDirectory());
    
//    NSString *currentVersion = [[UIDevice currentDevice]systemVersion];
    
    NSLog(@"\n%@\n",[NSBundle mainBundle].bundleIdentifier);
    
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showError:@"网络连接异常"];
                
                break;
                
            default:
                break;
        }
        
    }];
    
    [mgr startMonitoring];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filepath = [doc stringByAppendingPathComponent:@"account.data"];
    
    NSDictionary *account = [NSDictionary dictionaryWithContentsOfFile:filepath];
    
    if (account) {
        [WLControllerTool chooseRootViewController];
    }else
    {
        self.window.rootViewController = [[WLOAuthViewController alloc]init];
//         [WLControllerTool chooseRootViewController];
    }


    
    return YES;
}


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDWebImageManager sharedManager]cancelAll];
}

@end
