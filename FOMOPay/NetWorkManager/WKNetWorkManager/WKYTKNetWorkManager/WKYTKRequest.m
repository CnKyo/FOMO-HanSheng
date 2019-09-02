//
//  WKYTKRequest.m
//  RazerPay
//
//  Created by apple on 21/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKYTKRequest.h"

@implementation WKYTKRequest{
}
/**
 实例化参数方法
 
 @param para 参数(字典)
 @return 返回当前对象
 */
- (id)initWithPara:(NSDictionary *)para{
    self = [super init];
    if (self) {
        self.para = para;
        
    }
    return self;
}
-(id)requestArgument{
    return self.para;
}
- (NSString *)requestUrl{
    return _mRequestUrl;
}
//- (NSInteger)cacheTimeInSeconds {
//    return 60*3;
//}
-(NSURLRequest *)buildCustomUrlRequest{
    return nil;
}
-(NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
    NSMutableDictionary *requestheaders = [NSMutableDictionary new];

    NSString *mToken = [WKAccountManager shareInstance].token;
    if (mToken.length>0) {
        [requestheaders setValue:[NSString stringWithFormat:@"Bearer Session=%@",mToken] forKey:@"Authorization"];
    }
    return requestheaders;
}
-(YTKRequestMethod)requestMethod{
    return self.mRequestMethods;
}
@end
