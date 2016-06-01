//
//  WLNavigationController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/10.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLNavigationController.h"

@interface WLNavigationController ()

@end

@implementation WLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+(void)initialize
{
    [self barNavigationAttributeAppear];
    
    [self tabBarAttributeAppear];
   
}

+(void)tabBarAttributeAppear
{
    UIBarButtonItem *appear = [UIBarButtonItem appearance];
    
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [appear setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *hightextAttrs = [NSMutableDictionary dictionary];
    hightextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    hightextAttrs[UITextAttributeTextColor] = [UIColor redColor];
    [appear setTitleTextAttributes:hightextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionary];
    disabletextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    disabletextAttrs[UITextAttributeTextColor] = [UIColor grayColor];
    [appear setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
}

+(void)barNavigationAttributeAppear
{
    UINavigationBar *appear = [UINavigationBar appearance];
    
    if (IOS7) {
        [appear setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    dictionary[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    dictionary[UITextAttributeTextColor] = [UIColor blackColor];
    dictionary[UITextAttributeFont] = [UIFont systemFontOfSize:20];
    
    [appear setTitleTextAttributes:dictionary];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" withHightImage:@"navigationbar_back_highlighted" withTarget:self withAction:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" withHightImage:@"navigationbar_more_highlighted" withTarget:self withAction:@selector(more)];
    }
    
  
    
    [super pushViewController:viewController animated:animated];
}


-(void)back
{
    [self popViewControllerAnimated:YES];
}

-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}


@end
