//
//  WLComposeViewController.m
//  王力新浪微博2016
//
//  Created by 王力 on 16/3/18.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "WLComposeViewController.h"
#import "WLTextView.h"
#import "WLComposeToolBar.h"
#import "WLComposePhotosView.h"
#import "WLAccountTool.h"
#import "WLAccount.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WLSendStatusResult.h"
#import "WLSendStatusParam.h"
#import "WLStatusTool.h"
#import "WLEmotionKeyboard.h"
#import "WLEmotion.h"
#import "WLEmotionTextView.h"

@interface WLComposeViewController ()<UITextViewDelegate,WLComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)WLEmotionTextView *textView;
@property(nonatomic,strong)WLComposeToolBar *toolBar;
@property(nonatomic,strong)WLComposePhotosView *photosView;

@property(nonatomic,strong)WLEmotionKeyboard *keyboard;

@property(nonatomic,assign,getter=isChangingKeyboard)BOOL changingKeyboard;

@end

@implementation WLComposeViewController

-(WLEmotionKeyboard *)keyboard
{
    if (!_keyboard) {
        self.keyboard = [WLEmotionKeyboard keyboard];
        self.keyboard.backgroundColor = [UIColor clearColor];
        self.keyboard.width = WLScreenW;
        self.keyboard.height = 216;
    }
    return _keyboard;

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    [self setupPhotosView];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:WLEmotionDidSelectedNotification object:nil];
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:WLEmotionDidDeletedNotification object:nil];

}


-(void)setupPhotosView
{
    WLComposePhotosView *photosView = [[WLComposePhotosView alloc]init];
    photosView.width = self.textView.width;
    photosView.height = self.textView.height;
    photosView.y = 70;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

-(void)setupToolBar
{
    WLComposeToolBar *toolBar = [[WLComposeToolBar alloc]init];
    toolBar.backgroundColor = [UIColor clearColor];
    toolBar.width = self.view.width;
    toolBar.delegate = self;
    toolBar.height = 44;
    self.toolBar = toolBar;

    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
}

-(void)setupTextView
{
    WLEmotionTextView *textView = [[WLEmotionTextView alloc]init];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    textView.placeholder = @"分享新鲜事...";
    
    
    textView.font = [UIFont systemFontOfSize:18];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

#pragma mark 

-(void)keyboardWillHide:(NSNotification *)note
{
    if (self.changingKeyboard) {
        self.changingKeyboard = NO;
    }
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}


-(void)keyboardWillShow:(NSNotification *)note
{
    CGFloat dutation = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey]doubleValue];
    [UIView animateWithDuration:dutation animations:^{
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}


-(void)setupNavBar
{
    NSString *name = [WLAccountTool account].name;
    if (name) {
        // 构建文字
        NSString *prefix = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        
        // 创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    } else {
        self.title = @"发微博";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


-(void)composeTool:(WLComposeToolbar *)toolbar didClickedButton:(WLComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case WLComposeToolbarButtonTypeCamera:
    
            [self openCamera];
            
            break;
            
        case WLComposeToolbarButtonTypePicture:
            
            [self openAlbum];
            
            break;
            
        case WLComposeToolbarButtonTypeEmotion:
            [self openEmtion];
            break;
        case WLComposeToolbarButtonTypeMention:
            
            break;
        case WLComposeToolbarButtonTypeTrend:
            
            break;
            
        default:
            break;
    }
}

-(void)openCamera
{
    WLLog(@"openCamera");
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    WLLog(@"openAlbum");
}

-(void)openEmtion
{
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        self.toolBar.showEmotionButton = YES;
    }else
    {
        self.textView.inputView = self.keyboard;
        
        self.toolBar.showEmotionButton = NO;
    }
    
    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
    
    
}

/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    WLEmotion *emotion = note.userInfo[WLSelectedEmotion];
    WLLog(@"%@ %@", emotion.chs, emotion.emoji);
    
    [self.textView appendEmotion:emotion];
    
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    [self.textView deleteBackward];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}


/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发表有图片的微博
 */
- (void)sendStatusWithImage
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WLAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送POST请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
#warning 目前新浪开放的发微博接口 最多 只能上传一张图片
        UIImage *image = [self.photosView.images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        // 拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
}


// 图文混排 ： 图片和文字混合在一起排列

/**
 *  发表没有图片的微博
 */
- (void)sendStatusWithoutImage
{
//    WLSendStatusParam *params = [[WLSendStatusParam alloc]init];
//    params.access_token =[WLAccountTool account].access_token;
//    params.starus = self.textView.text;
//    [WLStatusTool sendStatusesWith:params success:^(WLSendStatusResult *result) {
//        [MBProgressHUD showSuccess:@"发表成功"];
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"发表失败"];
//    }];
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WLAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送POST请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
          [MBProgressHUD showSuccess:@"发表成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showError:@"发表失败"];
      }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled =textView.hasText;
}

/**
 *  发送
 */
- (void)send
{
//    WLLog(@"send");
    // 1.发表微博
    if (self.photosView.images.count) {
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.textView resignFirstResponder];
    return YES;
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addImage:image];
}







@end
