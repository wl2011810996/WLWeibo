//
//  UIImage+Extension.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/8.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+(UIImage *)imageWithName:(NSString *)name
{
    UIImage *image = nil;
    if (IOS7) { // 处理iOS7的情况
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
    
//    UIImage *image = nil;
//    
//    if (IOS7) {
//        name = [name stringByAppendingString:@"_os7"];
//        image = [UIImage imageNamed:name];
//        
//        NSLog(@"\n %@",name);
//        
//    }
//    
//    if (image == nil) {
//        image =  [UIImage imageNamed:name];
//    }
//    
//    return image;
    
    /*
     tabbar_discover_selected_os7
     2016-03-09 12:11:24.828 王力新浪微博2016[34946:3366645]
     tabbar_profile_selected_os7
     2016-03-09 12:11:24.830 王力新浪微博2016[34946:3366645]
     tabbar_message_center_selected_os7
     2016-03-09 12:11:24.834 王力新浪微博2016[34946:3366645]
     tabbar_home_selected_os7

     
     */
    
    
//    UIImage *image = nil;
//    if (IOS7) {
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        image  = [UIImage imageNamed:newName];
//    }
//    
//    if (image == nil) {
//        image = [UIImage imageNamed:name];
//    }
//    
//    return image;
    
//    UIImage *image = nil;
//    if (IOS7) { // 处理iOS7的情况
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        image = [UIImage imageNamed:newName];
//    }
//    
//    if (image == nil) {
//        image = [UIImage imageNamed:name];
//    }
//    return image;
}

@end
