//
//  WLCommonViewController.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLCommonViewController.h"
#import "WLCommonGroup.h"
#import "WLCommonItem.h"
#import "WLCommonArrowItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonLabelItem.h"
#import "WLCommonCell.h"

@interface WLCommonViewController()

@property (nonatomic,strong)NSMutableArray *groups;

@end

@implementation WLCommonViewController

-(NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

-(instancetype)init
{
   return  [self initWithStyle:UITableViewStyleGrouped];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = WLGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = WLStatusCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(WLStatusCellMargin - 35, 0, 0, 0);
}

#pragma mark -TableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLCommonGroup *group = self.groups[section];
    return group.items.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WLCommonGroup *group = self.groups[section];
    return group.header;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    WLCommonGroup *group = self.groups[section];
    return group.footer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCommonGroup *group = self.groups[indexPath.section];
    WLCommonItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *destVC = [[item.destVcClass alloc]init];
        destVC.title = item.title;
        [self.navigationController pushViewController:destVC animated:YES];
    }
    
    if (item.opetation) {
        item.opetation();
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCommonCell *cell = [WLCommonCell cellWithTableView:tableView];
    WLCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath rowsInsection:(int)self.groups.count];
    
    return cell;
}

@end
