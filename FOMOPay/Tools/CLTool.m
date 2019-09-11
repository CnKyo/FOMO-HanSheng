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
    
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符

    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"\\|\n|\r|\t"];
    NSString *newJson = [[jsonString componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    
    return newJson;
}


#pragma mark----****----返回一个图片的名字
+ (NSString *)GetCountryLogo:(NSString *)text{
    if ([text containsString:@"CNY"]) {
        return @"pdf_CNY";
    }else if ([text containsString:@"MYR"]){
        return @"pdf_MYR";
    }else if ([text containsString:@"PHP"]){
        return @"pdf_PHP";
    }else if ([text containsString:@"IDR"]){
        return @"pdf_IDR";
    }else if ([text containsString:@"TWD"]){
        return @"pdf_TWD";
    }else if ([text containsString:@"HKD"]){
        return @"pdf_HKD";
    }else if ([text containsString:@"SGD"]){
        return @"pdf_home_transfer_2";
    }else{
        return @"pdf_home_transfer_2";
    }
}

#pragma mark----****----获取订单状态
/**
 获取订单状态
 
 @param status 状态
 @return 返回说明
 */
+ (WKOrderStatusType)WKGetOrderStatus:(NSString *)status{
    if ([status isEqualToString:@"pending"]) {
        return WKOrderStatus_Processing;
    }else if([status isEqualToString:@"processing"]){
        return WKOrderStatus_Processing;
    }else if([status isEqualToString:@"remitting"]){
        return WKOrderStatus_Processing;
    }else if([status isEqualToString:@"successful"]){
        return WKOrderStatus_Sucess;
    }else if([status isEqualToString:@"failed"]){
        return WKOrderStatus_Fail;
    }else if([status isEqualToString:@"refunding"]){
        return WKOrderStatus_Refunding;
    }else if([status isEqualToString:@"refunded"]){
        return WKOrderStatus_Sucess;
    }else if([status isEqualToString:@"cancelled"]){
        return WKOrderStatus_Cancel;
    }else if([status isEqualToString:@"error1"]){
        return WKOrderStatus_Error1;
    }else{
        ///error2
        return WKOrderStatus_Error2;
    }
}
/**
 字符串截取
 
 @param mTag 截取的标记
 @param mText 要截取的内容
 @return 返回截取后的内容(数组)
 */
+ (NSArray *)WKStringSeparatedStringWithTag:(NSString *)mTag andText:(NSString *)mText{
    return [mText componentsSeparatedByString:mTag];
    
}

#pragma mark----****---- 用户是否允许接收通知
/**
 用户是否允许接收通知
 
 @return 返回YES or NO
 */
+ (BOOL)WKIsUserOpenNotificationEnable{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0){// system is iOS8
        
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (UIUserNotificationTypeNone != setting.types) {
            
            return YES;
        }
        
    } else {
        //iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        
        if(UIRemoteNotificationTypeNone != type) {
            return YES;
        }
    }
    
    return NO;
    
}

#pragma mark----****----如果用户关闭推送通知就跳转到设置界面设置
/**
 如果用户关闭推送通知就跳转到设置界面设置
 */
+ (void)WKGoToOpenAppSystemSetting{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url options:@{} completionHandler:nil];
        }
    }
    
}
@end
