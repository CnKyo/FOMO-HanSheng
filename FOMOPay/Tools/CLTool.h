//
//  CLTool.h
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
NS_ASSUME_NONNULL_BEGIN

@interface CLTool : NSObject
+ (BOOL)isIphoneX;
+ (CGFloat)bottmHeight;

+ (NSDictionary *)stringToDic:(NSString *)text;

+ (NSString *)nullCheck:(NSString *)checkString;

+ (NSString *)deleteSpace:(NSString *)text;

+ (NSString *)getCuurenceCode:(NSString *)text;

#pragma mark----****----字典转json字符串
/**
 字典转json字符串
 
 @param mJsonDic 要转换的字典
 @return 返回json字符串
 */
+ (NSString *)WKDicToJsonString:(NSDictionary *)mJsonDic;




#pragma mark----****----返回一个图片的名字
+ (NSString *)GetCountryLogo:(NSString *)text;
#pragma mark----****----获取订单状态
/**
 获取订单状态

 @param status 状态
 @return 返回说明
 */
+ (WKOrderStatusType)WKGetOrderStatus:(NSString *)status;
#pragma mark----****----字符串截取
/**
 字符串截取
 
 @param mTag 截取的标记
 @param mText 要截取的内容
 @return 返回截取后的内容(数组)
 */
+ (NSArray *)WKStringSeparatedStringWithTag:(NSString *)mTag andText:(NSString *)mText;
@end

NS_ASSUME_NONNULL_END
