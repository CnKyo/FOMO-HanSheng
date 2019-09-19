//
//  xModel.h
//  FOMOPay
//
//  Created by clkj on 2019/9/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface xModel : NSObject
//@interface mMode : NSObject
@property (nonatomic,strong) NSString *mLName; //全名

@property (nonatomic,strong) NSString *mLNationality; //国籍

@property (nonatomic,strong) NSString *mLGender; // 性别

@property (nonatomic,strong) NSString *mLBankName; //银行

@property (nonatomic,strong) NSString *mLBankCity; //开户城市

@property (nonatomic,strong) NSString *mLAccNumber; //账户号码

@property (nonatomic,strong) NSString *mLReleationShip; // 关系

@property (nonatomic,strong) NSString *mLContNumber; // 联系号码




#pragma -----------这是右边的数据
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *fullName;
@property (strong,nonatomic) NSString *gender;
@property (strong,nonatomic) NSString *nationality;
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *contactNumber;

@property (strong,nonatomic) NSString *bankName;
@property (strong,nonatomic) NSString *accountNumber;
@property (strong,nonatomic) NSString *relationship;
@property (strong,nonatomic) NSString *createdAt;
@property (strong,nonatomic) NSString *updatedAt;
@property (strong,nonatomic) NSString *bankCity;

@property (assign,nonatomic) BOOL needRefresh;
@end


NS_ASSUME_NONNULL_END
