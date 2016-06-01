//
//  WLCommonCell.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCommonItem;
@interface WLCommonCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)setIndexPath:(NSIndexPath *)indexPath rowsInsection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic,strong)WLCommonItem *item;

@end
