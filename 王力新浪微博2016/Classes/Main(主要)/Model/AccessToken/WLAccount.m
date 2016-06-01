//
//  WLAccount.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/21.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLAccount.h"

@implementation WLAccount

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    WLAccount *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    NSDate *date = [NSDate date];
    
    account.expires_time = [date dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
