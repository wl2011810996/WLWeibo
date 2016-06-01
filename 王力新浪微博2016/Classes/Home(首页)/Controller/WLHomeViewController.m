//
//  WLHomeViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLHomeViewController.h"
#import "WLOneViewController.h"
#import "WLTitleButton.h"
#import "WLPopMenu.h"
#import "AFNetworking.h"
#import "WLAccountTool.h"
#import "WLAccount.h"
#import "UIImageView+WebCache.h"
#import "WLStatus.h"
#import "WLUser.h"
#import "MJExtension.h"
#import "WLLoadMoreFooter.h"
#import "WLHttpTool.h"
#import "WLHomeStatusesParam.h"
#import "WLHomeStatusesResult.h"
#import "WLStatusTool.h"
#import "WLUserInfoResult.h"
#import "WLUserInfoParam.h"
#import "WLUserTool.h"
#import "WLStatusCell.h"
#import "WLStatusFrame.h"
#import "WLStatusDetailViewController.h"

@interface WLHomeViewController ()<WLPopMenuDelegate>

@property(nonatomic,strong)NSMutableArray *statusFrames;

@property(nonatomic,strong)WLLoadMoreFooter *footer;
@property(nonatomic,strong)WLTitleButton *titleButton;

@property (nonatomic, weak) UIRefreshControl *refreshControl;

@end

@implementation WLHomeViewController

-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =[UIColor whiteColor];
//    self.tableView.backgroundColor = WLColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupNavBar];
    
    [self setupRefresh];
    
    [self setupUserInfo];
}

-(void)setupRefresh
{
    UIRefreshControl *refreshControll = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControll];
    
    [refreshControll addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    [refreshControll beginRefreshing];
    self.refreshControl = refreshControll;
    
    [self refreshControlStateChange:refreshControll];
    
    WLLoadMoreFooter *footer = [WLLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

-(void)setupUserInfo
{
    WLUserInfoParam *params = [[WLUserInfoParam alloc]init];
    params.access_token = [WLAccountTool account].access_token;
    params.uid = [WLAccountTool account].uid;
    [WLUserTool userInfoWithParam:params success:^(WLUserInfoResult *user) {
        
//        // 字典转模型
//        WLUser *user = (WLUser *)result;
//         WLUser *user = [WLUser objectWithKeyValues:response];

         // 设置用户的昵称为标题
         [self.titleButton setTitle:user.name forState:UIControlStateNormal];

         // 存储帐号信息
         WLAccount *account = [WLAccountTool account];
         account.name = user.name;
         [WLAccountTool save:account];
        
    } failure:^(NSError *error) {
        
    }];
    
//    // 1.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WLAccountTool account].access_token;
//    params[@"uid"] = [WLAccountTool account].uid;
//    
//    // 2.发送GET请求
//    
//    [WLHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id response) {
//        
//        // 字典转模型
//         WLUser *user = [WLUser objectWithKeyValues:response];
//
//         // 设置用户的昵称为标题
//         [self.titleButton setTitle:user.name forState:UIControlStateNormal];
//
//         // 存储帐号信息
//         WLAccount *account = [WLAccountTool account];
//         account.name = user.name;
//         [WLAccountTool save:account];
//        
//    } failure:^(NSError *error) {
//        
//    }];

}

#pragma mark - 加载微博数据

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WLStatus *status in statuses) {
        WLStatusFrame *frame = [[WLStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

-(void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) {
        [self.refreshControl beginRefreshing];
        
        [self loadNewStatuses:self.refreshControl];
    }else if (fromSelf)
    {
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}

-(void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    WLHomeStatusesParam *params = [WLHomeStatusesParam param];
    WLStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    
    WLStatus *fristStatus = firstStatusFrame.status;
    if (fristStatus) {
        params.since_id = @([fristStatus.idstr longLongValue]);
    }
    [WLStatusTool homeStatusesWith:params success:^(WLHomeStatusesResult *result) {
        NSArray *newStatueses = [self statusFramesWithStatuses:result.statuses];

        
        [self.statusFrames insertObjects:newStatueses atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatueses.count)]];

        //        for (NSDictionary *dict in resultDict[@"statuses"]) {
        //            WLStatus *status = [WLStatus statusWithDict:dict];
        //            [self.statuses addObject:status];
        //        }
        [self.tableView reloadData];

        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];

        [self showNewStatusesCount:newStatueses.count];
        
    } failure:^(NSError *error) {
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
}

-(void)showNewStatusesCount:(int)count
{
    UILabel *label = [[UILabel alloc]init];
    
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    } else {
        label.text = @"没有最新的微博数据";
    }
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 0.75;
    //    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        //        label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
    
}

/**
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 开始：由慢到快，结束：由快到慢
 UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 由慢到块
 UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 由快到慢
 UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性，匀速
 */


-(void)setupNavBar
{
//    UITextField *textField = [[UITextField alloc]init];
//    textField.frame = CGRectMake(100, 100, 100, 100);
//    textField.backgroundColor = [UIColor redColor];
//    textField.inputAccessoryView = [[[NSBundle mainBundle]loadNibNamed:@"Empty" owner:nil options:nil]lastObject];
//    [self.view addSubview:textField];
    
    
    WLTitleButton *titleButton = [[WLTitleButton alloc]init];
    titleButton.width = 100;
    titleButton.height = 35;
    
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[UIImage imageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateSelected];
    NSString *name = [WLAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton = titleButton;
    self.navigationItem.titleView = titleButton;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" withHightImage:@"navigationbar_friendsearch_highlighted" withTarget:self withAction:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" withHightImage:@"navigationbar_pop_highlighted" withTarget:self withAction:@selector(pop)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}

- (void)titleClick:(UIButton *)titleButton
{
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    
    WLPopMenu *popMenu = [WLPopMenu popMenuWithContentView:button];
    popMenu.delegate = self;
    popMenu.dimBackground = YES;
    [popMenu showInRect:CGRectMake(100, 100, 100, 100)];
}

-(void)friendSearch
{
    WLOneViewController *oneVC = [[WLOneViewController alloc]initWithNibName:@"WLOneViewController" bundle:nil];
    oneVC.title = @"OneVC";
    [self.navigationController pushViewController:oneVC animated:YES];
}

-(void)dismissPopMenu:(WLPopMenu *)popMenu
{
    WLTitleButton *button =  (WLTitleButton *)self.navigationItem.titleView;
    [button setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

-(void)pop
{
    WLLog(@"pop--");
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.footer.hidden = (self.statusFrames.count==0);
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLStatusCell *cell = [WLStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    
//    WLStatus *status= self.statusFrames[indexPath.row];
//    cell.textLabel.text = status.text;
//    
//    WLUser *user = status.user;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",user.name];
//    
////     下载头像
//    NSString *imageUrlStr = user.profile_image_url;
//    [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    
    WLLog(@"%@",[cell subviews]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLStatusDetailViewController *detail = [[WLStatusDetailViewController alloc]init];
    WLStatusFrame *frame = self.statusFrames[indexPath.row];
    detail.status = frame.status;
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)loadMoreStatuses
{
    WLHomeStatusesParam *params = [WLHomeStatusesParam param];
    WLStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    WLStatus *lastStatus =  lastStatusFrame.status;
    if (lastStatus) {
        // max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
       params.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    [WLStatusTool homeStatusesWith:params success:^(WLHomeStatusesResult *result) {
//         // 微博字典数组
//         NSArray *statusDictArray = result.statuses;
//         // 微博字典数组 ---> 微博模型数组
//         NSArray *newStatuses = [WLStatus objectArrayWithKeyValuesArray:statusDictArray];

        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
         // 将新数据插入到旧数据的最后面
         [self.statusFrames addObjectsFromArray:newFrames];

         // 重新刷新表格
         [self.tableView reloadData];

         // 让刷新控件停止刷新（恢复默认的状态）
         [self.footer endRefreshing];
        
    } failure:^(NSError *error) {
        //让刷新控件停止刷新（恢复默认的状态）
         [self.footer endRefreshing];
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count<=0 || self.footer.isRefreshing) {
        return;
    }
    
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    
    if (delta <= (sawFooterH - 0)) {
        [self.footer startRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadMoreStatuses];
        });
    }
    
}


@end
