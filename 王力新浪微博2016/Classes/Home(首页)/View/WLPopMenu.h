//
//  WLPopMenu.h
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/13.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WLPopMenuArrowCenter = 0,
    WLPopMenuArrowRight = 1,
    WLPopMenuArrowLeft = 2
}WLPopMenuArrowPostion;

@class WLPopMenu;
@protocol WLPopMenuDelegate <NSObject>

-(void)dismissPopMenu:(WLPopMenu *)popMenu;



@end

@interface WLPopMenu : UIView

@property(nonatomic,assign)id <WLPopMenuDelegate>delegate;

@property(nonatomic,assign,getter=isDimBackground)BOOL dimBackground;


@property(nonatomic,assign)WLPopMenuArrowPostion popMenuArrowPosition;

-(void)setBackground:(UIImage *)background;

+(instancetype)popMenuWithContentView:(UIView *)view;

-(void)showInRect:(CGRect)rect;


@end
