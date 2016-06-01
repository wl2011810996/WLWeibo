//
//  WLSearchBar.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/13.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLSearchBar.h"

@implementation WLSearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        UIImageView *imgv = [[UIImageView alloc]init];
        imgv.contentMode = UIViewContentModeCenter;
        [imgv setImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        imgv.width = imgv.image.size.width +10;
        imgv.height = imgv.image.size.height;
        self.leftView = imgv;
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(instancetype)searchBar
{
   return  [[self alloc]init];
}

@end
