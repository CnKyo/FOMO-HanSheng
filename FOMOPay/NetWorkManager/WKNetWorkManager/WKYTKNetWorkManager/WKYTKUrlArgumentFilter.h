//
//  WKYTKUrlArgumentFilter.h
//  RazerPay
//
//  Created by apple on 21/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetworkConfig.h"
#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface WKYTKUrlArgumentFilter : NSObject<YTKUrlFilterProtocol>

+ (WKYTKUrlArgumentFilter *)filterArgumentWithPara:(NSDictionary *)argument;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;


@end

NS_ASSUME_NONNULL_END
