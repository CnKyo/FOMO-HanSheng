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
    
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:para andUrl:url andRequestMethod:YTKRequestMethodPOST];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"错误的说明:%@",request.responseString);
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
    }];
}
+ (void)deleteWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
   
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:para andUrl:url andRequestMethod:YTKRequestMethodDELETE];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"错误的说明:%@",request.responseString);
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
    }];
}
+ (void)newGetWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
 
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:para andUrl:url andRequestMethod:YTKRequestMethodGET];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
    }];
}
+ (void)putWithUrl:(NSString *)url para:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
   
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:para andUrl:url andRequestMethod:YTKRequestMethodPUT];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
            if ([errorDes isEqualToString:@""]) {
                
            }
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
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
+ (void)WKGetLoginOtp:(NSDictionary *)para block:(void(^)(NSString *result,BOOL success))block{

    [self newPostWithUrl:kGetLoginOtp para:para block:^(id result,BOOL success) {
        if (success) {
            block(result,success);
        }else{
            block(result,success);
        }
        
    }];
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
            }else if ([result isKindOfClass:[NSString class]]){
                block([[CLTool stringToDic:result] objectForKey:@"sessionToken"],success);
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
#pragma mark----****----退出登录
/**
 退出登录
 
 @param block 返回值
 */
+ (void)WKLogOut:(void(^)(id result,BOOL success))block{
    [self deleteWithUrl:kGetToken para:@{} block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----获取app的配置信息
/**
 获取app的配置信息
 
 @param block 返回值
 */
+ (void)WKGetAppConfig:(void(^)(id result,BOOL success))block{
    [self newGetWithUrl:KGetConfig para:@{} block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----获取汇款列表
/**
 获取汇款列表
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRemiitablePara:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self newGetWithUrl:kGetRemmittableList para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----添加退款账号
/**
 添加退款账号
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKAddRefundAccount:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self putWithUrl:kAddRefundAccount para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----获取退款账户
/**
 获取退款账户
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRefundAccount:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self newGetWithUrl:kAddRefundAccount para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****---- 创建收款人信息
/**
 创建收款人信息
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKCreateRecipientAcc:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self newPostWithUrl:kCreateRecipientAcc para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----获取票据信息
/**
 获取票据信息
 
 @param block 返回值
 */
+ (void)WKGetRecipient:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self newGetWithUrl:kGetRecipientInfo para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----获取收款人详情
/**
 获取收款人详情
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKGetRecipientDetail:(NSString *)para block:(void(^)(id result,BOOL success))block{
    
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:@{} andUrl:[NSString stringWithFormat:@"%@%@",kGetRecipientDetail,para] andRequestMethod:YTKRequestMethodGET];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
    }];
}
#pragma mark----****----开始汇款
/**
 开始汇款
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKRemiitanceNow:(NSDictionary *)para block:(void(^)(id result,BOOL success))block{
    [self newPostWithUrl:kStartRemiitance para:para block:^(id result, BOOL success) {
        block(result,success);
    }];
}
#pragma mark----****----删除收款人
/**
 删除收款人
 
 @param para 参数
 @param block 返回值
 */
+ (void)WKDeleteRecipient:(NSString *)para block:(void(^)(id result,BOOL success))block{
    
    WKYTKManager *mGetToken = [[WKYTKManager alloc] initWithPara:@{} andUrl:[NSString stringWithFormat:@"%@%@",kGetRecipientDetail,para] andRequestMethod:YTKRequestMethodDELETE];
    [mGetToken startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        DebugLog(@"请求的结果是:%@",request.responseString);
        block(request.responseString,YES);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSString *errorDes = @"";
        if ([request.responseJSONObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)request.responseObject;
            errorDes = [dic objectForKey:@"message"];
        }else{
            errorDes = request.error.localizedDescription;
        }
        block(errorDes,NO);
    }];
}
@end
