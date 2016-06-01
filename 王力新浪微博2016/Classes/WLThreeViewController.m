//
//  WLThreeViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/10.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLThreeViewController.h"

@interface WLThreeViewController ()

@end

@implementation WLThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"哈哈" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"hahah" withHightImage:nil withTarget:nil withAction:nil];
}

@end
