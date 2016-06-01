//
//  WLBaseViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/12.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLBaseViewController.h"

@interface WLBaseViewController ()

@end

@implementation WLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" withHightImage:@"navigationbar_back_highlighted" withTarget:self withAction:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" withHightImage:@"navigationbar_more_highlighted" withTarget:self withAction:@selector(more)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)more
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}






@end
