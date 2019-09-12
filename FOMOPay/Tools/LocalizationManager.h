//
//  LocalizationManager.h
//  FOMOPay
//
//  Created by clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum: NSUInteger{
    LocalizationManager_guide = 0,
    LocalizationManager_login = 1,
}LocalizationManagerType;




@interface LocalizationManager : NSObject
/// 获取当前资源文件
+ (NSBundle *)bundle;
/// 初始化语言文件
+ (void)initUserLanguage;
/// 获取应用当前语言
+ (NSString *)userLanguage;
/// 设置当前语言
+ (void)setUserlanguage:(NSString *)language;
/// 通过Key获得对应的string
+ (NSString *)getStringByKey:(NSString *)key;

+ (NSString *)getSystemLanguage;


+ (void)setGuidelanguage:(NSString *)language andType:(NSUInteger)mType;//设置引导页的语言
@end

NS_ASSUME_NONNULL_END
