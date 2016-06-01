//
//  WLProfileViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLProfileViewController.h"
#import "WLCommonGroup.h"
#import "WLCommonItem.h"
#import "WLCommonArrowItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonLabelItem.h"
#import "WLSettingViewController.h"

@interface WLProfileViewController ()

@end

@implementation WLProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroups];
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting
{
    WLSettingViewController *setting = [[WLSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(void)setupGroups
{
      [self setupGroups0];
      [self setupGroups1];
}

-(void)setupGroups0
{
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    WLCommonArrowItem *newFriend = [WLCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    
    group.items = @[newFriend];
}

-(void)setupGroups1
{
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    WLCommonArrowItem *album = [WLCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    WLCommonArrowItem *collect = [WLCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"1";
    
    WLCommonArrowItem *like = [WLCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.badgeValue = @"10";
    like.subtitle = @"(36)";
    
    group.items = @[album,collect,like];
}

@end
