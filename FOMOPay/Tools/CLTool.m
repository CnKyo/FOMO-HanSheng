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
@end
