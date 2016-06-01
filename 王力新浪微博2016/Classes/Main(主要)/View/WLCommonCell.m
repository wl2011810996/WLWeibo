//
//  WLCommonCell.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/16.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLCommonCell.h"
#import "WLCommonArrowItem.h"
#import "WLCommonLabelItem.h"
#import "WLCommonSwitchItem.h"
#import "WLCommonCenterItem.h"
#import "WLBadgeView.h"

@interface WLCommonCell()

@property (nonatomic,strong)UIImageView *rightArrow;

@property (nonatomic,strong)UISwitch *rightSwitch;

@property (nonatomic,strong)UILabel *rightLabel;

@property (nonatomic,strong)WLBadgeView *badgeView;

@end

@implementation WLCommonCell

#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

-(WLBadgeView *)badgeView
{
    if (_badgeView == nil) {
        self.badgeView = [[WLBadgeView alloc]init];
    }
    return _badgeView;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    WLCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WLCommonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

-(void)setIndexPath:(NSIndexPath *)indexPath rowsInsection:(int)rows
{
//    UIImageView *bgView = (UIImageView *)self.backgroundView;
//    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;

    UIImageView *bgView = (UIImageView *)self.backgroundView;
//    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
//        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
//        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
//        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
//        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }

}

-(void)setItem:(WLCommonItem *)item
{
    _item = item;
    
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;

    if (item.badgeValue) {
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([item isKindOfClass:[WLCommonArrowItem class]])
    {
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[WLCommonSwitchItem class]])
    {
        self.accessoryView = self.rightSwitch;
    }else if ([item isKindOfClass:[WLCommonLabelItem class]])
    {
        WLCommonLabelItem *labelItem = (WLCommonLabelItem *)item;
        self.rightLabel.text = labelItem.text;
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font];
        self.accessoryView = self.rightLabel;
    }else
    {
        self.accessoryView = nil;
    }
    
    
}

@end
