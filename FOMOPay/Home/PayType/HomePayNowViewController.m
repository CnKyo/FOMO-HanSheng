//
//  HomePayNowViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayNowViewController.h"
#import "HomePayNowListCell.h"

@interface HomePayNowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomePayNowViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Paynow";
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    
    CLNavModel *mNewModel = [CLNavModel new];
//    mNewModel.mTitle = @"Paynow";
    [self CLAddNavType:CLNavType_default andModel:mNewModel completion:^(NSInteger tag) {
        
    }];
    
    [self loadTableView];
    
//    [self loadData];
}

- (void)loadTableView{
    
    NSInteger bottomSafeHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;
        
    }else{
        
        bottomSafeHeight = 0;
    }
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bottomSafeHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height + 1);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomePayNowListCell" bundle:nil] forCellReuseIdentifier:@"HomePayNowListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePayNowListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePayNowListCell"];
    if (!cell) {
        
        cell = [[HomePayNowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePayNowListCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak __typeof(self)weakSelf = self;
    
    cell.codeImage.image =[self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:@"www.baidu.com"] withSize:150];
    cell.HomePayNowListCellBlock = ^(NSInteger tag) {
        
        if (tag == 0) {     //下载二维码
            
            UIImage *image = nil;
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
        }else{  //完成
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    
    return cell;
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error != NULL){
        
        [WKHudManager WKShowErrorHud:@"保存失败" view:self.view];
        
    }else{
        
        [WKHudManager WKShowSuccessHud:@"保存成功" view:self.view];
    }
}


//生成二维码
- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{

    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


//-(void)loadData{
//    [self showLoading:nil];
//        [WKNetWorkManager WKGetOrderDetail:self.mItem.serialNumber block:^(id result, BOOL success) {
//            [self hiddenLoading];
//            if (success) {
//                NSDictionary *mResponse = [CLTool stringToDic:result];
//                if ([[mResponse objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
//                    self.mItem = [WKOrderInfo yy_modelWithDictionary:[mResponse objectForKey:@"order"]];
//                }
//            }else{
//                TOASTMESSAGE(result);
//            }
//            self.mRData=@[self.mItem.recipient.fullName,[NSString stringWithFormat:@"%@%@",self.mItem.remittable.source.currencyCode,self.mItem.remittable.source.amount],[NSString stringWithFormat:@"%@%@",self.mItem.remittable.target.currencyCode,self.mItem.remittable.target.amount]];
//
//            [self.mTabView reloadData];
//        }];
//    }


@end
