//
//  WKYTKRequest.h
//  RazerPay
//
//  Created by apple on 21/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "YTKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKYTKRequest : YTKRequest

/**
 实例化参数方法

 @param para 参数(字典)
 @return 返回当前对象
 */
- (id)initWithPara:(NSDictionary *)para;

@property(strong,nonatomic) NSString *mRequestUrl;

@property (assign,nonatomic) YTKRequestMethod mRequestMethods;

@property (strong,nonatomic) NSDictionary *para;

@end

NS_ASSUME_NONNULL_END
