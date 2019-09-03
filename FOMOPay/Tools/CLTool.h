//
//  CLTool.h
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTool : NSObject
+ (BOOL)isIphoneX;
+ (CGFloat)bottmHeight;

+ (NSDictionary *)stringToDic:(NSString *)text;

+ (NSString *)nullCheck:(NSString *)checkString;

+ (NSString *)deleteSpace:(NSString *)text;

+ (NSString *)getCuurenceCode:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
