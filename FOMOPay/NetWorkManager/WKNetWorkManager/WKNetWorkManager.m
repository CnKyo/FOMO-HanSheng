//
//  WKNetWorkManager.m
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKNetWorkManager.h"
#import "AFHTTPSessionManager.h"



@implementation WKNetWorkManager

+ (void)getWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
    
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper openLog];
    
    [PPNetworkHelper setValue:@"2" forHTTPHeaderField:@"typeId"];

    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"GET URL = %@",urlString);
    DebugLog(@"GET 参数是:%@",para);

    [PPNetworkHelper GET:urlString parameters:para success:^(id responseObject) {
        
        DebugLog(@"请求的结果是:%@",responseObject);
        WKBaseModel *mBaseInfo = [WKBaseModel new];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *mResult = (NSDictionary *)responseObject;
            mBaseInfo.message = [mResult objectForKey:@"msg"];
            mBaseInfo.error_code = [[NSString stringWithFormat:@"%@",[mResult objectForKey:@"code"]] integerValue];
            if (mBaseInfo.error_code != 0) {
                
                mBaseInfo.success = NO;
                
            }else{
                
                mBaseInfo.success = YES;
            }
            mBaseInfo.result = [mResult objectForKey:@"data"];
            
        }else{
            
            mBaseInfo.message = @"未知错误!";
            mBaseInfo.error_code = 10009;
            mBaseInfo.success = NO;
        }
        block(mBaseInfo);
        
    } failure:^(NSError *error) {
        
        DebugLog(@"错误的说明:%@",error.localizedDescription);
        WKBaseModel *mBaseInfo = [WKBaseModel new];
        mBaseInfo.message = error.localizedDescription;
        mBaseInfo.error_code = 10009;
        mBaseInfo.success = NO;
        block(mBaseInfo);
    }];
}

+ (void)postWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
    
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper openLog];

    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"POST URL = %@",urlString);
    DebugLog(@"POST 参数是:%@",para);

    [PPNetworkHelper POST:urlString parameters:para success:^(id responseObject) {
        
        DebugLog(@"请求的结果是:%@",responseObject);
        WKBaseModel *mBaseInfo = [WKBaseModel new];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *mResult = (NSDictionary *)responseObject;
            mBaseInfo.message = [mResult objectForKey:@"msg"];
            mBaseInfo.error_code = [[NSString stringWithFormat:@"%@",[mResult objectForKey:@"code"]] integerValue];
            if (mBaseInfo.error_code != 0) {
                
                mBaseInfo.success = NO;
                
            }else{
                
                mBaseInfo.success = YES;
            }
            
            mBaseInfo.result = [mResult objectForKey:@"data"];
            
        }else{
            
            mBaseInfo.message = @"未知错误!";
            mBaseInfo.error_code = 10009;
            mBaseInfo.success = NO;
        }
        block(mBaseInfo);
        
    } failure:^(NSError *error) {
        
        DebugLog(@"错误的说明:%@",error.localizedDescription);
        WKBaseModel *mBaseInfo = [WKBaseModel new];
        mBaseInfo.message = error.localizedDescription;
        mBaseInfo.error_code = 10009;
        mBaseInfo.success = NO;
        block(mBaseInfo);
    }];
}
+ (void)newPostWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper openLog];
    
    NSString *mToken = [WKAccountManager shareInstance].token;
    if (mToken.length>0) {
        [PPNetworkHelper setValue:mToken forHTTPHeaderField:@"sessionToken"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"POST URL = %@",urlString);
    DebugLog(@"POST 参数是:%@",para);
    
    [PPNetworkHelper POST:urlString parameters:para success:^(id responseObject) {
        
        DebugLog(@"请求的结果是:%@",responseObject);
        block(responseObject,YES);
        
    } failure:^(NSError *error) {
        
        DebugLog(@"错误的说明:%@",error.localizedDescription);
        block(error.localizedDescription,NO);
        
    }];
}
+ (void)newGetWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    [PPNetworkHelper openLog];
    
    if ([WKAccountManager shareInstance].token.length>0) {
        [PPNetworkHelper setValue:[WKAccountManager shareInstance].token forHTTPHeaderField:@"sessionToken"];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
    NSLog(@"GET URL = %@",urlString);
    DebugLog(@"GET 参数是:%@",para);
    
    [PPNetworkHelper GET:urlString parameters:para success:^(id responseObject) {
        
        DebugLog(@"请求的结果是:%@",responseObject);
        block(responseObject,YES);
        
    } failure:^(NSError *error) {
        
        DebugLog(@"错误的说明:%@",error.localizedDescription);
        block(error.localizedDescription,NO);
        
    }];
}
#pragma mark----****----获取版本信息
/**
 获取版本信息
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetAppVersion:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
    [self getWithUrl:kGetAppVersion para:para block:^(WKBaseModel *info) {
        block(info);
    }];
}
#pragma mark----****----获取登录otp
/**
 获取登录otp
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetLoginOtp:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{


}
#pragma mark----****----获取Token
/**
 获取Token
 
 @param para 参数
 @param block 返回值
 */
+(void)WKGetToken:(NSDictionary *)para block:(void(^)(NSString *token,BOOL success))block{
    [self newPostWithUrl:kGetToken para:para block:^(id result,BOOL success) {
        if (success) {
            if ([result isKindOfClass:[NSDictionary class]]) {
                block([result objectForKey:@"sessionToken"],success);
            }
        }else{
            block(result,success);
        }
        
    }];
}
#pragma mark----****----登录
/**
 登录
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKLogin:(NSDictionary *)para block:(void(^)(NSDictionary *result,BOOL success))block{
    [self newPostWithUrl:kLogin para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}

@end
