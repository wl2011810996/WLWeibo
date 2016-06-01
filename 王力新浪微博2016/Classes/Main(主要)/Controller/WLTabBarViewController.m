//
//  WLTabBarViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLTabBarViewController.h"
#import "WLHomeViewController.h"
#import "WLDiscoverViewController.h"
#import "WLMessageViewController.h"
#import "WLProfileViewController.h"
#import "WLNavigationController.h"
#import "WLTabBar.h"
#import "WLComposeViewController.h"
#import "WLUserTool.h"
#import "WLAccountTool.h"
#import "WLAccount.h"


@interface WLTabBarViewController ()<WLTabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic, weak) WLHomeViewController *home;
@property (nonatomic, weak) WLMessageViewController *message;
@property (nonatomic, weak) WLProfileViewController *profile;

@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;

@end

@implementation WLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
//    self.view.backgroundColor = [UIColor redColor];
    
    [self addChildViewControllers];
    
    [self addCustomTabBar];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)addCustomTabBar
{
    WLTabBar *tabBar = [[WLTabBar alloc]init];
    
    tabBar.tabBardelegate = self;
    
    //    NSLog(@"%@",self.tabBar);
    
    [self setValue:tabBar forKey:@"tabBar"];
}

-(void)addChildViewControllers
{
    WLHomeViewController *home = [[WLHomeViewController alloc]init];
    [self addChildViewController:home withTitle:@"主页" withImage:@"tabbar_home" withSelectedImage:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedViewContoller = home;
    
    WLDiscoverViewController *discover = [[WLDiscoverViewController alloc]init];
    [self addChildViewController:discover withTitle:@"发现" withImage:@"tabbar_discover" withSelectedImage:@"tabbar_discover_selected"];

    WLMessageViewController *message = [[WLMessageViewController alloc]init];
    [self addChildViewController:message withTitle:@"消息" withImage:@"tabbar_message_center" withSelectedImage:@"tabbar_message_center_selected"];
    self.message = message;
    
    WLProfileViewController *profile = [[WLProfileViewController alloc]init];
    [self addChildViewController:profile withTitle:@"我" withImage:@"tabbar_profile" withSelectedImage:@"tabbar_profile_selected"];
    self.profile = profile;
    
//    NSLog(@"%@",self.tabBar);
}

-(void)getUnreadCount
{
    WLUnreadCountParam *params = [WLUnreadCountParam param];
    params.uid = [WLAccountTool account].uid;
    [WLUserTool unreadCountWithParam:params success:^(WLUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;

    } failure:^(NSError *error) {
        
    }];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController *vc = [viewController.viewControllers firstObject];
    if ([vc isKindOfClass:[WLHomeViewController class]]) {
        if (self.lastSelectedViewContoller == vc) {
            [self.home refresh:YES];
        }else
        {
            [self.home refresh:NO];
        }
    }
    self.lastSelectedViewContoller = vc;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    [self.tabBar setNeedsLayout];
//}

-(void)addChildViewController:(UIViewController *)vc withTitle:(NSString *)title withImage:(NSString *)image withSelectedImage:(NSString *)selectedImage
{
    
//    UIViewController *  vc = [[[NSClassFromString(name) class] alloc]init];
//    vc.view.backgroundColor = KRandomColor;
//        vc.view.frame = self.view.bounds;
    
    vc.title = title;
    
//    vc.tabBarItem.title = title;
//    vc.navigationItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] =[UIColor blackColor];
    textAttrs [NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    UIImage *selectedImageName = [UIImage imageWithName:selectedImage];
    
    if (IOS7) {
        selectedImageName = [selectedImageName imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    vc.tabBarItem.selectedImage = selectedImageName;
    WLNavigationController *nav = [[WLNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}

-(void)tabBarDidClickPlusButton:(WLTabBar *)tabBar
{
    // 弹出发微博控制器
    WLComposeViewController *compose = [[WLComposeViewController alloc] init];
    WLNavigationController *nav = [[WLNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
