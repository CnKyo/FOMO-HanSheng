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
@property (nonatomic,strong) NSString *mName; //全名

@property (nonatomic,strong) NSString *mNationality; //国籍

@property (nonatomic,strong) NSString *mGender; // 性别

@property (nonatomic,strong) NSString *mBankName; //银行

@property (nonatomic,strong) NSString *mBankCity; //开户城市

@property (nonatomic,strong) NSString *mAccNumber; //账户号码

@property (nonatomic,strong) NSString *mReleationShip; // 关系

@property (nonatomic,strong) NSString *mContNumber; // 联系号码

//@end
@end


NS_ASSUME_NONNULL_END
