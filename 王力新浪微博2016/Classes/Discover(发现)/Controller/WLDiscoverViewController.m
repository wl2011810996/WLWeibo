//
//  WLDiscoverViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLDiscoverViewController.h"
#import "WLSearchBar.h"
#import "WLCommonLabelItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonArrowItem.h"
#import "WLCommonGroup.h"
#import "WLCommonItem.h"
#import "WLCommonCell.h"
#import "WLOneViewController.h"
#import "WLTwoViewController.h"

@interface WLDiscoverViewController ()

@end

@implementation WLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroups];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"系统设置" style:UIBarButtonItemStyleDone target:self action:@selector(btnClick)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"系统设置" style:UIBarButtonItemStyleDone target:self action:@selector(btnClick)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
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
    [self.groups addObject:group];
    
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    WLCommonArrowItem *hotStatus = [WLCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [WLOneViewController class];
    
    WLCommonArrowItem *findPeople = [WLCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.badgeValue = @"N";
    findPeople.destVcClass = [WLOneViewController class];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
    
}

-(void)setupGroups1
{
    // 1.创建组
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    WLCommonItem *gameCenter = [WLCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.destVcClass = [WLTwoViewController class];
    
    WLCommonLabelItem *near = [WLCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.destVcClass = [WLTwoViewController class];
//    near.text = @"测试文字";
    
    WLCommonSwitchItem *app = [WLCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
    app.destVcClass = [WLTwoViewController class];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

-(void)setupGroups2
{
    WLCommonGroup *group = [WLCommonGroup group];
    [self.groups addObject:group];
    
    WLCommonSwitchItem *video = [WLCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    video.opetation = ^{
        WLLog(@"----点击了视频---");
    };
    
    WLCommonSwitchItem *music = [WLCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
    WLCommonLabelItem *movie = [WLCommonLabelItem itemWithTitle:@"电影" icon:@"movie"];
    movie.opetation = ^{
        WLLog(@"---点击了电影---");
    };
    
    WLCommonLabelItem *cast = [WLCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.badgeValue = @"5";
    cast.subtitle = @"(10)";
//    cast.text = @"axxxx";
    
    WLCommonArrowItem *more = [WLCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video,music,movie,cast,more];
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    WLSearchBar *searchBar = [WLSearchBar searchBar];
//    searchBar.width = 300;
//    searchBar.height = 30;
//    self.navigationItem.titleView = searchBar;
//    
//}

-(void)btnClick
{
    
}


//
//#pragma mark - Table view data source
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"发现测试数据----%d", indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *newVc = [[UIViewController alloc] init];
//    newVc.view.backgroundColor = [UIColor yellowColor];
//    newVc.title = @"新控制器";
//    [self.navigationController pushViewController:newVc animated:YES];
//}

@end
