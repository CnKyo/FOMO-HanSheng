//
//  WKLoginManager.h
//  FOMOPay
//
//  Created by clkj on 2019/9/5.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKLoginManager : NSObject
/**
 单例方法
 
 @return 返回对象
 */
+ (instancetype)shareInstance;

/**
 跳转到登录界面
 */
- (void)presentLoginViewController:(void(^)(void))completion;
@end


NS_ASSUME_NONNULL_END

