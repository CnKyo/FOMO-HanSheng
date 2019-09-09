//
//  PublicHeader.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/21.
//  Copyright © 2019 王钶. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h


#endif /* PublicHeader_h */


//#define kBaseUrl                     @"http://192.168.0.35:8080"
#define kBaseUrl                              @"https://hanshan.uat.fomopay.net"
///获取版本信息
#define kGetAppVersion                              @"/customer/app/v2/version"

#define kGetLoginOtp                             @"/customer/app/v2/login"
///获取token
#define kGetToken                             @"/customer/app/v2/session"
///登录
#define kLogin                             @"/customer/app/v2/login"
///获取配置信息
#define KGetConfig                             @"/customer/app/v2/configuration"
///汇款
#define kGetRemmittableList                             @"/customer/app/v2/remittable"
///添加退款账户
#define kAddRefundAccount                             @"/customer/app/v2/refundAccount"
///获取收款列表信息
#define kGetRecipientInfo                             @"/customer/app/v2/recipients"
///创建收款账户
#define kCreateRecipientAcc                             @"/customer/app/v2/recipient"
///获取收款人详情
#define kGetRecipientDetail                             @"/customer/app/v2/recipient/"
///订单相关(订单列表,订单详情,发起支付订单,)
#define kAboutOrder                             @"/customer/app/v2/order"

///订单列表
#define kOrderList                             @"/customer/app/v2/orders"
