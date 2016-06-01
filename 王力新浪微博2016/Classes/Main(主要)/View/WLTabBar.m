//
//  WLTabBar.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/18.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLTabBar.h"

@interface WLTabBar()

@property(nonatomic,weak)UIButton *plusButton;

@end

@implementation WLTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addPlusButton];
        
        if (!IOS7) {
             self.backgroundImage = [UIImage imageWithName:@"tabbar_background"];
        }
        self.selectionIndicatorImage = [UIImage imageWithName:@"navigationbar_button_background"];
    }
    return self;
}

-(void)addPlusButton
{
    UIButton *plusButton = [[UIButton alloc]init];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

-(void)plusButtonClick
{
    // 通知代理
    if ([self.tabBardelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.tabBardelegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupPlusButtonFrame];
    
    [self setupAllTabBarButtonsFrame];
}

-(void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width*0.5, self.height*0.5);
}

-(void)setupAllTabBarButtonsFrame
{
//    WLLog(@"%@",self.subviews);
    
    /*
     "<_UITabBarBackgroundView: 0x7fd8bc02ce20; frame = (0 0; 320 49); opaque = NO; autoresize = W; userInteractionEnabled = NO; layer = <CALayer: 0x7fd8b9c135a0>>",
     "<UIButton: 0x7fd8b9dbe960; frame = (128 2.5; 64 44); opaque = NO; layer = <CALayer: 0x7fd8b9dbeed0>>",
     "<UITabBarButton: 0x7fd8b9f2ee10; frame = (2 1; 76 48); opaque = NO; layer = <CALayer: 0x7fd8b9d751e0>>",
     "<UITabBarButton: 0x7fd8bc024860; frame = (82 1; 76 48); opaque = NO; layer = <CALayer: 0x7fd8b9ca0f80>>",
     "<UITabBarButton: 0x7fd8bc027300; frame = (162 1; 76 48); opaque = NO; layer = <CALayer: 0x7fd8bc027670>>",
     "<UITabBarButton: 0x7fd8bc02b130; frame = (242 1; 76 48); opaque = NO; layer = <CALayer: 0x7fd8bc028900>>",
     "<UIImageView: 0x7fd8b9cb2a90; frame = (0 -0.5; 320 0.5); autoresize = W; userInteractionEnabled = NO; layer = <CALayer: 0x7fd8b9c1efc0>>"
     */

    int index = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 根据索引调整位置
            [self setupTabBarButtonFrame:tabBarButton atIndex:index];
            
            // 遍历UITabBarButton中的所有子控件
            [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
            
            // 索引增加
            index++;
        }
    }
    
}

-(void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(NSInteger)index
{
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    }else
    {
        tabBarButton.x = buttonW * index;
    }
    
    tabBarButton.y = 0;
}

-(void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(NSInteger)index
{
    int selectedIndex = [self.items indexOfObject:self.selectedItem];
    
    WLLog(@"%@",tabBarButton.subviews);
    
    for (UILabel *label in tabBarButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.font =[UIFont systemFontOfSize:10];
            
            if (selectedIndex == index) {
                label.textColor = [UIColor orangeColor];
            }else
            {
                label.textColor = [UIColor blackColor];
            }
        }
    }
    
    /*
     
     "<UITabBarSwappableImageView: 0x7f9fdb7860a0; frame = (0 0; 30 30); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7f9fdb785dc0>>",
     "<UITabBarButtonLabel: 0x7f9fdb5d1bf0; frame = (0 0; 20 12); text = '\U4e3b\U9875'; opaque = NO; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x7f9fdb5d1b90>>"
     
     */
}

@end
