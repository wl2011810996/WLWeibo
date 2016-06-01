//
//  WLStatusCell.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/4/1.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLStatusFrame;

@interface WLStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)WLStatusFrame *statusFrame;

@end
