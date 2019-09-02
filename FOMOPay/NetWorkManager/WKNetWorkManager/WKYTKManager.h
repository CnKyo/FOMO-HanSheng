//
//  WKAppInit.h
//  RazerPay
//
//  Created by apple on 25/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKYTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKYTKManager : WKYTKRequest
/**
 实例化参数方法
 
 @param para 参数(字典)
 @return 返回当前对象
 */
- (id)initWithPara:(NSDictionary *)para;

/**
 实例化i请求方法

 @param para 请求的参数(内部已将加密方式进行特殊处理,外部只需将正常参数传入即可)
 @param mUrl 请求地址
 @param method 请求方式(如果传空,默认为GET方式请求)
 @return 返回请求对象
 */
- (id)initWithPara:(NSDictionary *)para andUrl:(NSString *)mUrl andRequestMethod:(YTKRequestMethod)method;

@property(assign,nonatomic)NSInteger mCackTime;
@end

NS_ASSUME_NONNULL_END
