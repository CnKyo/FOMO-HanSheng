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
    
//    if ([WKAccountManager shareInstance].token.length > 0) {
//
//        [PPNetworkHelper setValue:[WKAccountManager shareInstance].token forHTTPHeaderField:@"token"];
//    }
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
    
//    if ([WKAccountManager shareInstance].token.length>0) {
//        [PPNetworkHelper setValue:[WKAccountManager shareInstance].token forHTTPHeaderField:@"token"];
//    }
    [PPNetworkHelper setValue:@"2" forHTTPHeaderField:@"typeId"];
    
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

+ (void)posFormData:(NSString *)url para:(NSString *)para block:(void(^)(WKBaseModel *info))block{
    
    //由于是POST，将一些凭证如AccessToken之类的拼接在一起，这种叫URL参数，同GET一样
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kBaseUrl,url];
//    NSString *newURLString = [NSString stringWithFormat:@"%@?typeId=2?token=%@?returnVisitCycle=%@",urlString,[WKAccountManager shareInstance].token,para];
    NSString *newURLString = [NSString stringWithFormat:@"%@?typeId=2?token=%@?returnVisitCycle=%@",urlString,@"11111",para];

    NSURL *mUrl = [NSURL URLWithString:newURLString];
    //创建请求request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:mUrl cachePolicy:0 timeoutInterval:30];
    //设置请求方式为POST
    request.HTTPMethod = @"POST";
    //设置请求内容格式
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain",@"multipart/form-data", nil];
    [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        DebugLog(@"请求成功---%@---%@",responseObject,[responseObject class]);
        if (error) {
            
            DebugLog(@"%@",error.description);
            return ;
        }
        NSDictionary *dict = (NSDictionary *)responseObject;
        //以下结构没做放空处理，只为了尽快看到效果，请大家自行处理下
        NSDictionary *resultDict = dict[@"result"];
        if (!resultDict) {
            
            DebugLog(@"result没有值，很抱歉，估计错误了！");
            return;
        }
    }];
}

+ (void)postWithFormData:(NSString *)url para:(NSString *)para block:(void(^)(WKBaseModel *info))block{
    
    NSString *boundary = [[NSUUID UUID]UUIDString];//随机字符串，用作分割符
    NSString *BoundarySingle = [[NSString alloc]initWithFormat:@"--%@",boundary];
    
    //结束符--tsunamierFileFlag--
    NSMutableString *str = [[NSMutableString alloc]init];
    [str appendFormat:@"%@\r\n",BoundarySingle];
    [str appendFormat:@"Content-Disposition: form-data; returnVisitCycle=\"%@\"\r\n",para];//这个是参数名
    [str appendFormat:@"Content-Type: text/plain;charset=UTF-8\r\n"];
    [str appendFormat:@"Content-Transfer-Encoding:8bit\r\n\r\n"];
    [str appendFormat:@"Content-Transfer-Encoding:binary\r\n\r\n"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,url]]];
    NSString *ContentType = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@;charset=UTF-8",boundary];
    [request setValue:ContentType forHTTPHeaderField:@"Content-Type"];
    
//    if ([WKAccountManager shareInstance].token.length>0) {
//
//        [request setValue:[WKAccountManager shareInstance].token forHTTPHeaderField:@"token"];
//    }
    [request setValue:@"2" forHTTPHeaderField:@"typeId"];

    [request setHTTPMethod:@"POST"];
    request.timeoutInterval = 40;
    NSURLSession *session = [NSURLSession sharedSession];
  
    NSURLSessionTask *Task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *reciveData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if(error){
            
            NSLog(@"出现异常%@",error);
            
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200){
                
                NSLog(@"服务器成功响应!>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
                
            }else{
                
                NSLog(@"服务器返回失败>>%@",[[NSString alloc]initWithData:reciveData encoding:NSUTF8StringEncoding]);
            }
        }
        
        DebugLog(@"response:%@",response);
    }];
    
    [Task resume];
}
///**
// 获取启动页
//
// @param block 返回值
// */
//+ (void)WKGetLaunchImage:(void(^)(WKBaseModel *info,WKLaunchAdInfo *adInfo))block{
//    [self getWithUrl:kGetLaunchImage para:[NSDictionary new] block:^(WKBaseModel *info) {
//        block(info,[WKLaunchAdInfo yy_modelWithDictionary:[info.result objectForKey:@"StartPage"]]);
//    }];
//}
//+ (void)WKLogin:(NSDictionary *)para block:(void(^)(WKBaseModel *info,WKUserInfo *userInfo))block{
//    [self postWithUrl:kLoginUrl para:para block:^(WKBaseModel *info) {
//        block(info,[WKUserInfo yy_modelWithDictionary:info.result]);
//    }];
//}
///**
// 获取用户信息
//
// @param block 返回值
// */
//+ (void)WKGetUserInfo:(void(^)(WKBaseModel *info,WKUserInfo *userInfo))block{
//    [self getWithUrl:kGetUserInfo para:[NSDictionary new] block:^(WKBaseModel *info) {
//
//        WKUserInfo *mUserinfo = [WKUserInfo yy_modelWithDictionary:info.result];
//
//        [[WKAccountManager shareInstance] WKResetUserInfo:mUserinfo];
//
//        block(info,mUserinfo);
//    }];
//}
//+ (void)WKGetOtp:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSString *otp))block{
//    [self postWithUrl:kGetOTP para:para block:^(WKBaseModel *info) {
//        block(info,@"");
//    }];
//}
///**
// 修改登录密码
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKChangePWD:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kChangePwd para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
//+ (void)WKGetFollowList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetFollowList para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSDictionary class]]) {
//            id records = [info.result objectForKey:@"records"];
//            if ([records isKindOfClass:[NSArray class]]) {
//                for (NSDictionary *dic in records) {
//                    [mTempArr addObject:[WKFollowRecordObj yy_modelWithDictionary:dic]];
//                }
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
//
///**
// 获取未读消息数
//
// @param block 返回值
// */
//+ (void)WKGetUnreadNum:(void(^)(WKBaseModel *info,WKUnreadObj *count))block{
//    [self getWithUrl:kGetUnreadNum para:[NSDictionary new] block:^(WKBaseModel *info) {
//        block(info,[WKUnreadObj yy_modelWithDictionary:info.result]);
//    }];
//}
///**
// 阅读消息
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKReadMessage:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self getWithUrl:kReadMessage para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
//+ (void)WKGetFollowDetailg:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self getWithUrl:kGetFollowList para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
//+ (void)WKGetNotifyList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetNotifyList para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *records = [info.result objectForKey:@"records"];
//            if ([records isKindOfClass:[NSArray class]]) {
//                for (NSDictionary *dic in records) {
//                    [mTempArr addObject:[WKSysNotifyObj yy_modelWithDictionary:dic]];
//                }
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
//+ (void)WKGetNotifyDetail:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self getWithUrl:kGetNotifyDetail para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 修改昵称和手机号
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKChangeNickNameOrMobile:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kChangeNickNameOrMobile para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 获取患者详情信息
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetPatientDetailInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetPatientDetailInfo para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in info.result) {
//                [mTempArr addObject:[WKPatientCustomComprehensiveInfo yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 获取电话随访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetMobileFollwRecord:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetMobileFollowRecords para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in info.result) {
//                [mTempArr addObject:[WKPatientPhoneRecordsObj yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 修改电话随访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKModifyPhoneFollowRecords:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kModifyPhoneFollowRecords para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 新增电话回访记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKAddPhoneFollowRecords:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kAddPhoneFollowRecords para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 获取筛选分类模版
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetFilterTemplete:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetFilterTemplete para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in info.result) {
//                [mTempArr addObject:[WKFilterObj yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 获取患者分类
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetPatientCategory:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetPatientCategory para:para block:^(WKBaseModel *info) {
//        NSMutableArray *tempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSDictionary class]]) {
//
//            NSArray *record = (NSArray *)[info.result objectForKey:@"records"];
//            for (NSDictionary *dic in record) {
//                [tempArr addObject:[WKPatientCategoryObj yy_modelWithDictionary:dic]];
//            }
//        }
//
//        block(info,tempArr);
//    }];
//}
///**
// 查询拨号l记录
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetCallRecordList:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetCallRecordList para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//
//        if ([info.result isKindOfClass:[NSDictionary class]]) {
//            NSArray *mRecords = (NSArray *)[info.result objectForKey:@"records"];
//            for (NSDictionary *dic in mRecords) {
//                [mTempArr addObject:[WKComprehensiveRecordList yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 获取回访周期设置
//
// @param block 返回值
// */
//+ (void)WKGetFollowSeting:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kGetFollowWeekSettinh para:[NSDictionary new] block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *dic in info.result) {
//                [mTempArr addObject:[WKAccessObj yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 保存回访周期设置
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSaveFollowSetting:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kSaveFollowWeekSetting para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 获取帮助中心
//@param block 返回值
// */
//+ (void)WKGetHelpCenter:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kGetHelpCenter para:[NSDictionary new] block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 版本更新
//
// @param block 返回值
// */
//+ (void)WKUpdateVersion:(void(^)(WKBaseModel *info))block{
//    [self getWithUrl:kUpdateVersion para:[NSDictionary new] block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 搜索
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSearchInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kSearchInfo para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSDictionary class]]) {
//            NSArray *mArr = (NSArray *)[info.result objectForKey:@"records"];
//            for (NSDictionary *dic in mArr) {
//                [mTempArr addObject:[WKFollowRecordObj yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 删除患者
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKDeletePatient:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self getWithUrl:kDeletePatient para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
///**
// 获取添加患者模版
// @param para 参数
// @param block 返回值
// */
//+ (void)WKGetAddPatientStyle:(NSDictionary *)para block:(void(^)(WKBaseModel *info,NSArray *list))block{
//    [self getWithUrl:kAddPatiendStyle para:para block:^(WKBaseModel *info) {
//        NSMutableArray *mTempArr = [NSMutableArray new];
//        if ([info.result isKindOfClass:[NSArray class]]) {
//
//            for (NSDictionary *dic in info.result) {
//                [mTempArr addObject:[WKPatientCustomComprehensiveInfo yy_modelWithDictionary:dic]];
//            }
//        }
//        block(info,mTempArr);
//    }];
//}
///**
// 添加患者信息
// @param para 参数
// @param block 返回值
// */
//+ (void)WKAddPatientInfo:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//    [self postWithUrl:kAddPatientInfo para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
//
///**
// 获取推送通知开关状态
//
// @param block 返回值
// */
//+ (void)WKGetPushSwitchStatus:(void(^)(WKBaseModel *info))block{
//
//    [self getWithUrl:kGetPushSwitch para:[NSDictionary new] block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}
//
///**
// 修改推送通知开关状态
//
// @param para 参数
// @param block 返回值
// */
//+ (void)WKSavePushSwitchStatus:(NSDictionary *)para block:(void(^)(WKBaseModel *info))block{
//
//    [self getWithUrl:kSavePushSwitch para:para block:^(WKBaseModel *info) {
//        block(info);
//    }];
//}


@end
