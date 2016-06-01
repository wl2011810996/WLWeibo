//
//  WLSettingViewController.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLSettingViewController.h"
#import "WLCommonGroup.h"
#import "WLCommonItem.h"
#import "WLCommonLabelItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonCenterItem.h"
#import "WLCommonArrowItem.h"
#import "WLGeneralSettingViewController.h"

@interface WLSettingViewController()

@end

@implementation WLSettingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
    [self setupGroups];
    
    [self setupFooter];
    
}

-(void)setupGroups
{
    [self setupGroups0];
    [self setupGroups1];
    [self setupGroups2];
    
}

-(void)setupGroups0
{
    WLCommonGroup *group = [WLCommonGroup group];
    group.header = @"tail部";
    [self.groups addObject:group];
    
    WLCommonArrowItem *item = [WLCommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[item];
    
    
}


-(void)setupGroups1
{
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    WLCommonArrowItem *newFriend = [WLCommonArrowItem itemWithTitle:@"主题,背景"];
    
    group.items = @[newFriend];
    
    
}


-(void)setupGroups2
{
    WLCommonGroup *group = [WLCommonGroup group];
    group.header = @"头部";
    [self.groups addObject:group];
    
    WLCommonArrowItem *item = [WLCommonArrowItem itemWithTitle:@"通用设置"];
    item.destVcClass = [WLGeneralSettingViewController class];
    
    group.items = @[item];
    
}

-(void)setupFooter
{
    UIButton *logout = [[UIButton alloc]init];
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:WLColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}


@end
