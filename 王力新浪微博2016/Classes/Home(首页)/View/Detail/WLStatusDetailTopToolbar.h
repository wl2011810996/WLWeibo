//
//  WLStatusDetailTopToolbar.h
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WLStatusDetailTopToolbarButtonTypeRetweeted,
    WlStatusDetailTopToolbarButtonTypeComment,
}WlStatusDetailTopToolbarButtonType;

@class WLStatusDetailTopToolbar,WLStatus;

@protocol WLStatusDetailTopToolbarDelegate <NSObject>

@optional
-(void)topToolbar:(WLStatusDetailTopToolbar *)topToolbar didSelectedButton:(WlStatusDetailTopToolbarButtonType)buttonType;

@end

@interface WLStatusDetailTopToolbar : UIView

+(instancetype)toolbar;

@property (nonatomic,weak)id <WLStatusDetailTopToolbarDelegate> delegate;

@property (nonatomic,assign)WLStatus *status;

@property (nonatomic,assign)WlStatusDetailTopToolbarButtonType selectedButtonType;

@end
