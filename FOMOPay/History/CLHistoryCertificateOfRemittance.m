//
//  CLHistoryCertificateOfRemittance.m
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryCertificateOfRemittance.h"

@interface CLHistoryCertificateOfRemittance ()<UIScrollViewDelegate,UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *mWebView;

//@property (nonatomic,assign)CGFloat webHeihgt;
@end

@implementation CLHistoryCertificateOfRemittance

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"汇款证明";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
                DebugLog(@"左边按钮");
            }
                break;
            case 1:
            {
                DebugLog(@"右边按钮");
            }
                break;
            default:
                break;
        }
    }];
    
    UIView *mView = [UIView new];
    mView.backgroundColor = ssRGBHex(0xF6F5FA);
    [self.view addSubview:mView];
    
//    UIImageView *mImg = [UIImageView new];
//    mImg.backgroundColor  = [UIColor redColor];
//    [self.view addSubview:mImg];
    
//    UIWebView *webView = [UIWebView new];
    self.mWebView = [UIWebView new];
    self.mWebView.delegate = self;

//    [NSURL URLWithString:[WKAccountManager shareInstance].appConfig.tncLink]
    [self.mWebView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:@"http://www.baidu.com"]]];
    
    [self.view addSubview:self.mWebView];
    
//    [mImg addSubview:webView];
    UIButton *mButton = [UIButton new];
    [mButton setTitle:@"导出证明图片" forState:UIControlStateNormal];
    [mButton addTarget:self action:@selector(SavaImg:) forControlEvents:UIControlEventTouchUpInside];
    mButton.titleLabel.font = kCommonFont(14);
    mButton.backgroundColor = ssRGBHex(0x005CB6);
    [mButton setTitleColor:ssRGBHex(0xffffff) forState:UIControlStateNormal];
    mButton.layer.cornerRadius = 4;
    [mView addSubview:mButton];
    
    
    
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-BottomHeight);
        make.height.offset(76);
        make.width.offset(kScreenWidth);
    }];
    
    
    [self.mWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(20 + kAppStatusBarHeight +44);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(mView.mas_top);
    }];
    
//    [mImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(20 + kAppStatusBarHeight +44);
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(mView.mas_top);
//    }];
    
    
    [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mView).mas_offset(22);
        make.left.equalTo(mView).mas_offset(10);
        make.right.equalTo(mView).mas_offset(-10);
        make.bottom.equalTo(mView).mas_offset(-10);
    }];


}
- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    DebugLog(@"开始加载网页");
    [self showLoading:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0)){
    DebugLog(@"加载完成");
    [self hiddenLoading];
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    self.webHeihgt = fittingSize.height;
    
//    CGFloat webViewHeight=[webView.scrollView contentSize].height;
//
//    CGRect newFrame = webView.frame;
//
//    newFrame.size.height = webViewHeight;
//
//    webView.frame = newFrame;
   

}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0)) {
    DebugLog(@"加载失败");
    [self hiddenLoading];
    TOASTMESSAGE(error.description);
    
}

-(void)SavaImg:(UIButton *)sender{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, self.webHeihgt), NO, 0.0);
////    UIGraphicsBeginImageContextWithOptions(self.mWebView.bounds.size,NO,0.0);
//    [self.mWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    if([self isOrUsePhotos]){
        UIImageWriteToSavedPhotosAlbum([self imageRepresentation], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"权限不足，点击确定前往设置" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
//            if([[UIApplication sharedApplication] canOpenURL:url]) {
//
//                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                [[UIApplication sharedApplication] openURL:url];
//
//            }
          
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                DebugLog(@"%id",success);


            }];
//             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertCtrl addAction:action1];
        
        [alertCtrl addAction:action2];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        // 保存失败
        TOASTMESSAGE(@"导出失败");
    } else {
        // 保存成功
        TOASTMESSAGE(@"导出成功");
    }
}


- (UIImage *)imageRepresentation{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize boundsSize = self.mWebView.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize contentSize = self.mWebView.scrollView.contentSize;
    CGFloat contentHeight = contentSize.height;
    
    CGPoint offset = self.mWebView.scrollView.contentOffset;
    
    [self.mWebView.scrollView setContentOffset:CGPointMake(0, 0)];
    
    NSMutableArray *images = [NSMutableArray array];
    while (contentHeight > 0) {
        UIGraphicsBeginImageContextWithOptions(boundsSize, NO, 0.0);
        [self.mWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [images addObject:image];
        
        CGFloat offsetY = self.mWebView.scrollView.contentOffset.y;
        [self.mWebView.scrollView setContentOffset:CGPointMake(0, offsetY + boundsHeight)];
        contentHeight -= boundsHeight;
    }
    
    [self.mWebView.scrollView setContentOffset:offset];
    
    CGSize imageSize = CGSizeMake(contentSize.width * scale,
                                  contentSize.height * scale);
    UIGraphicsBeginImageContext(imageSize);
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        [image drawInRect:CGRectMake(0,
                                     scale * boundsHeight * idx,
                                     scale * boundsWidth,
                                     scale * boundsHeight)];
    }];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fullImage;
}


//- (NSData *)PDFData{
//    UIViewPrintFormatter *fmt = [self viewPrintFormatter];
//    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
//    [render addPrintFormatter:fmt startingAtPageAtIndex:0];
//    CGRect page;
//    page.origin.x=0;
//    page.origin.y=0;
//    page.size.width=600;
//    page.size.height=768;
//
//    CGRect printable=CGRectInset( page, 50, 50 );
//    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
//    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
//
//    NSMutableData * pdfData = [NSMutableData data];
//    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
//
//    for (NSInteger i=0; i < [render numberOfPages]; i++)
//    {
//        UIGraphicsBeginPDFPage();
//        CGRect bounds = UIGraphicsGetPDFContextBounds();
//        [render drawPageAtIndex:i inRect:bounds];
//
//    }
//    UIGraphicsEndPDFContext();
//    return pdfData;
//}

//判断用户是否开了权限
- (BOOL)isOrUsePhotos{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            
            //无权限
          
            return  NO;
            
        }
        
    }
    
    else{
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        
//        if (status == PHAuthorizationStatusRestricted ||
//
//            status == PHAuthorizationStatusDenied) {
        if(status == PHAuthorizationStatusAuthorized){
            //无权限
           
            return YES;
            
        }
        
    }
    
    return NO;
    
}

#pragma mark---保存为pdf数据
- (void)savePDF{
    
    NSData*pdfData = [self converToPDF];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/testFile.pdf"]];
    
  
    BOOL result = [pdfData writeToFile:path atomically:YES];
    
    if(result) {
        
        
        
        NSLog(@"保存成功");
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertCtrl addAction:action1];
        
        [alertCtrl addAction:action2];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }else{
        
        NSLog(@"保存失败");
        
    }
    
    
    
}


#pragma mark---将_myWebView转化为PDF的DATA数据

- (NSData*)converToPDF{
    
    UIViewPrintFormatter *fmt = [self.mWebView viewPrintFormatter];
    
    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
    
    [render addPrintFormatter:fmt startingAtPageAtIndex:0];
    
    CGRect page;
    
    page.origin.x=0;
    
    page.origin.y=0;
    
    page.size.width=600;
    
    page.size.height=768;
    
    CGRect printable=CGRectInset( page,50,50);
    
    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    
    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
    
    NSMutableData * pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
    
    
    
    for(NSInteger i=0; i < [render numberOfPages]; i++)
        
    {
        
        UIGraphicsBeginPDFPage();
        
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        
        [render drawPageAtIndex:i inRect:bounds];
        
    }
    
    UIGraphicsEndPDFContext();
    
    return pdfData;
    
}

@end
