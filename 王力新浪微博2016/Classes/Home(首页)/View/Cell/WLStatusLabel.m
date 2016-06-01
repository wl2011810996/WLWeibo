//
//  WLStatusLabel.m
//  王力新浪微博2016
//
//  Created by 荣耀iMac on 16/5/17.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLStatusLabel.h"
#import "WLLink.h"

#define WLLinkBackgroundTag 100000

@interface WLStatusLabel()

@property (nonatomic,weak)UITextView *textView;

@property (nonatomic,strong)NSMutableArray *links;

@end

@implementation WLStatusLabel

-(NSMutableArray *)links
{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            
            NSString *linkText = attrs[WLLinkText];
            
            if (linkText == nil) {
                return ;
            }
            
            WLLink *link = [[WLLink alloc]init];
            link.text = linkText;
            link.range = range;
            
            NSMutableArray *rects = [NSMutableArray array];
            self.textView.selectedRange = range;
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0||selectionRect.rect.size.height ==0) {
                    continue;
                }
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            [links addObject:link];
            
        }];
        self.links = links;
    }
    return _links;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITextView *textView = [[UITextView alloc]init];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.userInteractionEnabled = NO;
        
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        
        textView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:textView];
        
        self.textView = textView;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}


#pragma mark -公共接口
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    self.textView.attributedText = attributedText;
    self.links = nil;
}

#pragma mark - 事件处理
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:touch.view];
    
    WLLink *touchinglink = [self touchingLinkWithPoint:point];
    
    [self showLinkBackground:touchinglink];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    WLLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        [[NSNotificationCenter defaultCenter]postNotificationName:WLLinkDidSelectedNotification object:@{WLLinkText:touchingLink.text}];
    }
    [self touchesCancelled:touches withEvent:event];
}


-(void)showLinkBackground:(WLLink *)link
{
    for (UITextSelectionRect *sectionRect in link.rects) {
        UIView *bg = [[UIView alloc]init];
        bg.tag = WLLinkBackgroundTag;
        bg.frame = sectionRect.rect;
        bg.backgroundColor = [UIColor redColor];
        [self insertSubview:bg atIndex:0];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

-(void)removeAllLinkBackground
{
    for (UIView *child in self.subviews) {
        if (child.tag == WLLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}


-(WLLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block WLLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(WLLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selection in  link.rects) {
            if (CGRectContainsPoint(selection.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}


@end
