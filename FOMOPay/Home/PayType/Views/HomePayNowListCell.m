//
//  HomePayNowListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayNowListCell.h"
#import <CoreImage/CoreImage.h>
@interface HomePayNowListCell()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@property (weak, nonatomic) IBOutlet UIImageView *downLoadImage;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation HomePayNowListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _finishButton.layer.cornerRadius = 5.0;
    
    _downLoadImage.image = [UIImage yh_imageNamed:@"pdf_home_payNow_downLoad"];
    
    NSString *string = @"仅接受汇款人本人账户付款";
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:kCommonColor(213, 0, 55, 1) range:NSMakeRange(3, 7)];
    [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length)];
    _alertLabel.attributedText = AttributedStr;
//    _codeImage.image=[self
//                      createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:@"www.baidu.com"] withSize:150];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)payNowButtonClicked:(UIButton *)sender {
    
    if (_HomePayNowListCellBlock) {
        
        _HomePayNowListCellBlock(sender.tag);
    }
}

////生成二维码
//- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
//    
//    // 1.实例化二维码滤镜
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
//    [filter setDefaults];
//    // 3.将字符串转换成NSdata
//    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
//    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
//    [filter setValue:data forKey:@"inputMessage"];
//    // 5.生成二维码
//    CIImage *outputImage = [filter outputImage];
//    return outputImage;
//}
//
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
//{
//    CGRect extent = CGRectIntegral(image.extent);
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    
//    // 1.创建bitmap;
//    size_t width = CGRectGetWidth(extent) * scale;
//    size_t height = CGRectGetHeight(extent) * scale;
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    
//    // 2.保存bitmap到图片
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    CGContextRelease(bitmapRef);
//    CGImageRelease(bitmapImage);
//    return [UIImage imageWithCGImage:scaledImage];
//}

@end
