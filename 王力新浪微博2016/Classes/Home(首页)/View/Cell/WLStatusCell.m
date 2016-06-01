//
//  WLStatusCell.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusCell.h"
#import "WLStatusDetailView.h"
#import "WLStatusToolbar.h"
#import "WLStatusFrame.h"

@interface WLStatusCell()

@property (nonatomic, weak) WLStatusDetailView *detailView;
@property (nonatomic, weak) WLStatusToolbar *toolbar;

@end

@implementation WLStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupDetailView];
        
        [self setupToolbar];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setStatusFrame:(WLStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    self.toolbar.status = statusFrame.status;
    self.toolbar.frame = statusFrame.toolbarFrame;
}

-(void)setupDetailView
{
    WLStatusDetailView *detailView = [[WLStatusDetailView alloc]init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}

-(void)setupToolbar
{
    WLStatusToolbar *toolbar = [[WLStatusToolbar alloc]init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
    
    self.backgroundColor = [UIColor clearColor];
}

@end
