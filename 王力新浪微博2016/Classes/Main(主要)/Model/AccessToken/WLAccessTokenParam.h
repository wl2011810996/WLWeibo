//
//  WLAccessTokenParam.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/31.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLAccessTokenParam : NSObject
/**	true	string	申请应用时分配的AppKey。*/
@property(nonatomic,copy)NSString *client_id;

/**		true	string	申请应用时分配的AppSecret。*/
@property(nonatomic,copy)NSString *client_secret;

/**		true	string	请求的类型，填写authorization_code*/
@property(nonatomic,copy)NSString *grant_type;

/**		true	string	调用authorize获得的code值。*/
@property(nonatomic,copy)NSString *code;

/**		true	string	回调地址，需需与注册应用里的回调地址一致。*/
@property(nonatomic,copy)NSString *redirect_uri;



@end
