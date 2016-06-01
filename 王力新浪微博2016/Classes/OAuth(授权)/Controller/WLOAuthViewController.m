//
//  WLOAuthViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WLTabBarViewController.h"
#import "WLNewFeatureController.h"
#import "WLControllerTool.h"
#import "WLAccount.h"
#import "WLAccountTool.h"
#import "WLAccessTokenParam.h"


@interface WLOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WLOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",KWeiBoAppKey,KWeiboUrl]]]];
    [self.view addSubview:webView];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"加载中"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    /**
     
     http://www.baidu.com/?code=bdd2e29af93e281e403770f386706f87
     */
    
    WLLog(@"%@",url);
    
    NSRange range = [url rangeOfString:@"http://www.baidu.com/?code="];
    if (range.location != NSNotFound) {
        int from = range.location + range.length;
       NSString *code = [url substringFromIndex:from];
        
        [self accessTokenWithCode:code];
        
    }
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
//    WLAccessTokenParam *param = [[WLAccessTokenParam alloc]init];
//    param.client_id = KWeiBoAppKey;
//    param.client_secret = KWeiBoAppSecret;
//    param.redirect_uri = KWeiboUrl;
//    param.grant_type = @"authorization_code";
//    param.code = code;
//    [WLAccountTool accessTokenWithParam:param success:^(WLAccount *account) {
//        [MBProgressHUD hideHUD];
//        
//        NSLog(@"%@",account);
//        
////        WLAccount *account1 = [WLAccount accountWithDict:account];
//        [WLAccountTool save:account];
//
////        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
////        NSString *filePath = [doc stringByAppendingPathComponent:@"account.plist"];
////        [responseObject writeToFile:filePath atomically:YES];
//        
//        [WLControllerTool chooseRootViewController];
//    } failure:^(NSError *error) {
//            [MBProgressHUD hideHUD];
//        WLLog(@"%@",error);
//    }];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = KWeiBoAppKey;
    params[@"client_secret"] = KWeiBoAppSecret;
    params[@"redirect_uri"] = KWeiboUrl;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *accountDict) {
        
        [MBProgressHUD hideHUD];
        
        WLAccount *account = [WLAccount accountWithDict:accountDict];
        
        [WLAccountTool save:account];
        
        
        
//        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//        NSString *filePath = [doc stringByAppendingPathComponent:@"account.plist"];
//        [responseObject writeToFile:filePath atomically:YES];
        
        [WLControllerTool chooseRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
        
    }];
    
}




@end
