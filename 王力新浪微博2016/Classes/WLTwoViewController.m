//
//  WLTwoViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/10.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLTwoViewController.h"
#import "WLThreeViewController.h"

@interface WLTwoViewController ()

- (IBAction)buttonClick:(id)sender;
@end

@implementation WLTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)buttonClick:(id)sender {
    WLThreeViewController *threeVC = [[WLThreeViewController alloc]initWithNibName:@"WLThreeViewController" bundle:nil];
    [self.navigationController pushViewController:threeVC animated:YES];
    
}
@end
