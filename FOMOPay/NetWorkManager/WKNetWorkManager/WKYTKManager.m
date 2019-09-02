//
//  WKAppInit.m
//  RazerPay
//
//  Created by apple on 25/01/2019.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKYTKManager.h"

@implementation WKYTKManager{
}
#pragma mark----****----这句非常重要,一定要写,不管是继承YTKBaseRequest还是WKYTKRequest都要写,如果不这样设置,会导致参数是nil
-(id)requestArgument{
    return self.para;
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
- (NSString *)baseUrl{
    return kBaseUrl;
}
/**
 实例化i请求方法
 
 @param para 请求的参数(内部已将加密方式进行特殊处理,外部只需将正常参数传入即可)
 @param mUrl 请求地址
 @param method 请求方式(如果传空,默认为GET方式请求)
 @return 返回请求对象
 */
- (id)initWithPara:(NSDictionary *)para andUrl:(NSString *)mUrl andRequestMethod:(YTKRequestMethod)method{
    self = [super init];
    if (self) {
        
        self.mRequestUrl = mUrl;
        if (!method) {
            self.mRequestMethods = YTKRequestMethodGET;
        }else{
            self.mRequestMethods = method;
        }
        
        self.para = para;
        
    }
    return self;
}
-(NSInteger)cacheTimeInSeconds{
//    if (_mCackTime<=0) {
//        _mCackTime =60;
//    }
    return _mCackTime;
}

@end
