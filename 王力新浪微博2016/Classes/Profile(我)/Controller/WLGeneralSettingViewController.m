//
//  WLGeneralSettingViewController.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLGeneralSettingViewController.h"
#import "WLCommonGroup.h"
#import "WLCommonItem.h"
#import "WLCommonArrowItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonLabelItem.h"

@implementation WLGeneralSettingViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGroups];
}

-(void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

-(void)setupGroup0
{
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    WLCommonLabelItem *readMode = [WLCommonLabelItem itemWithTitle:@"阅读模式"];
    readMode.text = @"有图模式";
    
    group.items = @[readMode];
    
}

-(void)setupGroup1
{
    
}


-(void)setupGroup2
{
    
}

@end
