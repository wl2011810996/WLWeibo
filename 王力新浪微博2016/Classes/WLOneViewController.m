//
//  WLOneViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/10.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLOneViewController.h"
#import "WLTwoViewController.h"

@interface WLOneViewController ()
- (IBAction)buttonClick:(id)sender;

@end

@implementation WLOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)buttonClick:(id)sender {
    WLTwoViewController *twoVC = [[WLTwoViewController alloc]initWithNibName:@"WLTwoViewController" bundle:nil];
    [self.navigationController pushViewController:twoVC animated:YES];
    
}
@end
