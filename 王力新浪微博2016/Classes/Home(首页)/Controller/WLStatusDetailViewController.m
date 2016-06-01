//
//  WLStatusDetailViewController.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusDetailViewController.h"
#import "WLStatusDetailView.h"
#import "WLStatusDetailFrame.h"
#import "WLStatus.h"
#import "WLStatusTool.h"
#import "WLComment.h"
#import "WLStatusDetailBottomToolbar.h"
#import "WLStatusDetailTopToolbar.h"

@interface WLStatusDetailViewController ()<UITableViewDataSource,UITableViewDelegate,WLStatusDetailTopToolbarDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)WLStatusDetailTopToolbar *topToolbar;
@property (nonatomic,strong)NSMutableArray *comments;
@property (nonatomic,strong)NSMutableArray *resposts;

@end

@implementation WLStatusDetailViewController

-(NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

-(NSMutableArray *)resposts
{
    if (_resposts == nil) {
        self.resposts = [NSMutableArray array];
    }
    return _resposts;
}

-(WLStatusDetailTopToolbar *)topToolbar
{
    if (!_topToolbar) {
        self.topToolbar = [WLStatusDetailTopToolbar toolbar];
    }
    
    self.topToolbar.status = self.status;
    
    self.topToolbar.delegate = self;
    
    return _topToolbar;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博正文";
    
//    [self setupTableView];
//    
//    [self setupDetailView];
    
//    [self setupBottomToolbar];
}

-(void)setupTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.width = self.view.width;
    tableView.height = self.view.height-35;
    tableView.backgroundColor = WLGlobalBg;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

-(void)setupDetailView
{
    WLStatusDetailView *detailView = [[WLStatusDetailView alloc]init];
    WLStatusDetailFrame *detailFrame = [[WLStatusDetailFrame alloc]init];
    self.status.retweeted_status.detail = YES;
    detailFrame.status = self.status;
    detailView.detailFrame = detailFrame;
    detailView.height = detailFrame.frame.size.height;
    self.tableView.tableHeaderView = detailView;
}

-(void)setupBottomToolbar
{
    WLStatusDetailTopToolbar *bottomToolbar = [[WLStatusDetailTopToolbar alloc]init];
    bottomToolbar.y = CGRectGetMaxY(self.tableView.frame);
    bottomToolbar.width = self.view.width;
    bottomToolbar.height = self.view.height - self.tableView.height;
    [self.view addSubview:bottomToolbar];
}

#pragma mark --TableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topToolbar.selectedButtonType == WLStatusDetailTopToolbarButtonTypeRetweeted) {
        return self.comments.count;
    }else
    {
        return self.resposts.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (self.topToolbar.selectedButtonType == WlStatusDetailTopToolbarButtonTypeComment) {
        WLComment *cmt = self.comments[indexPath.row];
        cell.textLabel.text = cmt.text;
    }else
    {
        WLStatus *status = self.resposts[indexPath.row];
        cell.textLabel.text = status.text;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.topToolbar.height;
}

#pragma mark - 顶部工具条的代理
-(void)topToolbar:(WLStatusDetailTopToolbar *)topToolbar didSelectedButton:(WlStatusDetailTopToolbarButtonType)buttonType
{
    [self.tableView reloadData];
    switch (buttonType) {
        case WlStatusDetailTopToolbarButtonTypeComment:
            [self loadComments];
            break;
        case WLStatusDetailTopToolbarButtonTypeRetweeted:
            [self loadRetweeteds];
            break;
    }
}

-(void)loadComments
{
    WLRepostsParam *param = [WLRepostsParam param];
    param.id = self.status.idstr;
    WLStatus *status = [self.resposts firstObject];
    param.since_id = status.idstr;
    
    [WLStatusTool repostsWithParam:param success:^(WLRepostsResult *result) {
        self.status.commments_count = result.total_number;
        self.topToolbar.status = self.status;
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.resposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


-(void)loadRetweeteds
{
    WLRepostsParam *param = [WLRepostsParam param];
    param.id = self.status.idstr;
    WLStatus *status = [self.resposts firstObject];
    param.since_id = status.idstr;
    
    [WLStatusTool repostsWithParam:param success:^(WLRepostsResult *result) {
        self.status.reposts_count = result.total_number;
        self.topToolbar.status = self.status;
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.resposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}




@end
