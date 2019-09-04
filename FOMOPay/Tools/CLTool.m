//
//  CLTool.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLTool.h"

@implementation CLTool

+ (BOOL)isIphoneX {
    BOOL isIphoneX = NO;
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            isIphoneX = YES;
        }
    }
    return isIphoneX;
}

+ (CGFloat)bottmHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom;
    }
    return 0;
}
+ (NSDictionary *)stringToDic:(NSString *)text{
    if (text == nil) {
        return nil;
    }
    
    NSData *jsonData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        DebugLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)nullCheck:(NSString *)checkString
{
    if ([checkString isEqualToString:@"(null)"] || [checkString isEqualToString:@"null"]||[checkString isEqualToString:@"(NULL)"]||[checkString isEqualToString:@"NULL"]||[checkString isEqualToString:@"<null>"] ) {
        return @"";
    }else{
        return checkString;
    }
}

+ (NSString *)deleteSpace:(NSString *)text{
    if((NSNull *)text != [NSNull null] && text && [text isKindOfClass:[NSString class]]){
        return [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }else {
        NSString *string = [self nullCheck:[NSString stringWithFormat:@"%@", text]];
        return string ? string : @"";
    }
}
+ (NSString *)getCuurenceCode:(NSString *)text{
    if ([text containsString:@"中国"]) {
        return @"CNY";
    }else if ([text containsString:@"马来西亚"]){
        return @"MYR";
    }else if ([text containsString:@"菲律宾"]){
        return @"PHP";
    }else if ([text containsString:@"越南"]){
        return @"VND";
    }else if ([text containsString:@"中国台湾"]){
        return @"TWD";
    }else if ([text containsString:@"泰国"]){
        return @"THD";
    }else if ([text containsString:@"中国香港"]){
        return @"HKD";
    }else if ([text containsString:@"新加坡"]){
        return @"SGD";
    }else if ([text containsString:@"日本"]){
        return @"JYP";
    }else{
        return @"SGD";
    }
}

#pragma mark----****----字典转json字符串
/**
 字典转json字符串
 
 @param mJsonDic 要转换的字典
 @return 返回json字符串
 */
+ (NSString *)WKDicToJsonString:(NSDictionary *)mJsonDic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mJsonDic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
@end
