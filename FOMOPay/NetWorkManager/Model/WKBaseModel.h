//
//  WKBaseModel.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKBaseModel : NSObject

@property (assign,nonatomic) BOOL success;
///0:成功。  1:失败。 99:app到期需续费。
@property (assign,nonatomic) NSInteger error_code;

@property (strong,nonatomic) id result;

@property (strong,nonatomic) NSString *message;

@end


@interface WKUserInfo : NSObject

@property (strong,nonatomic) NSString *idNumber;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *idType;
@property (strong,nonatomic) NSString *mobileNumber;

@end

@interface WKLaunchAdInfo : NSObject

@property (strong,nonatomic) NSString *startPageLogo;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *loginPageTitle;
@property (strong,nonatomic) NSString *loginPageLogo;
@property (strong,nonatomic) NSString *createTime;


@end

@interface WKFollowRecordObj : NSObject

@property (strong,nonatomic) NSString *patient_diagnosis;
@property (strong,nonatomic) NSString *patient_name;
@property (strong,nonatomic) NSString *message_user_id;
@property (strong,nonatomic) NSString *patient_sex;
@property (strong,nonatomic) NSString *message_patient_follow_num;
@property (strong,nonatomic) NSString *patient_age;
///1:未读 2:已读
@property (strong,nonatomic) NSString *message_status;
@property (strong,nonatomic) NSString *patient_tele;

@property (strong,nonatomic) NSString *patient_id;

@property (strong,nonatomic) NSString *message_id;

@end

@interface WKUnreadObj : NSObject

@property (strong,nonatomic) NSString *total;
@property (strong,nonatomic) NSString *sysNotRead;
@property (strong,nonatomic) NSString *followNotRead;

@end

@interface WKSysNotifyObj : NSObject
@property (strong,nonatomic) NSString *message_title;
@property (strong,nonatomic) NSString *message_id;
@property (strong,nonatomic) NSString *message_content;
@property (strong,nonatomic) NSString *message_created_time;
///1:未读  2:已读
@property (strong,nonatomic) NSString *message_status;

@end


@interface WKPatientCategoryObj : NSObject
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *patient_name;
@property (strong,nonatomic) NSString *patient_tele;
@property (strong,nonatomic) NSString *patient_diagnosis;

@property (strong,nonatomic) NSString *patient_id;
@property (strong,nonatomic) NSString *patient_sex;
@property (strong,nonatomic) NSString *patient_age;

@end


@interface WKComprehensiveRecordList : NSObject

@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSArray *list;


@end

@interface WKComprehensiveRecord : NSObject
@property (strong,nonatomic) NSString *dial_time;
@property (strong,nonatomic) NSString *dial_user_id;
@property (strong,nonatomic) NSString *dial_user_nick_name;
@property (strong,nonatomic) NSString *dial_id;

@property (strong,nonatomic) NSString *dial_phone;
@property (strong,nonatomic) NSString *dial_custom_id;

@end


@interface WKPatientCustomComprehensiveInfo : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSArray *data;

@end

@interface WKPatientCustomDetailInfo : NSObject
///1:输入框。2:文本框。3:单选。4:多选。5:选填。6时间选择控件。
@property (strong,nonatomic) NSString *typeId;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSString *mDescription;

@property (strong,nonatomic) NSString *value;
@property (strong,nonatomic) NSString *fieldName;

@end


@interface WKPatientPhoneRecordsObj : NSObject
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *follow_time;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *context;
@property (strong,nonatomic) NSString *name;

@end


@interface WKAppConfigObj : NSObject
@property (strong,nonatomic) NSString *rmtMaxAmt;
@property (strong,nonatomic) NSString *rmtMinAmt;
@property (strong,nonatomic) NSString *tncLink;
@property (strong,nonatomic) NSArray *appAvailableVersion;

@end

@interface WKRefundAccount : NSObject
@property (strong,nonatomic) NSString *bank;
@property (strong,nonatomic) NSString *city;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *number;
@property (strong,nonatomic) NSString *createdAt;
@property (strong,nonatomic) NSString *updatedAt;

@end


@interface WKAddAccInfoObj : NSObject
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger tag;
@property (strong,nonatomic) NSString *content;
@end


@interface WKResipientInfoObj : NSObject
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


@class WKRemiitableEntitySource,WKRemiitableEntityTarget,WKRemiitableEntityServiceCharge,WKRemiitableEntityChargable;
@interface WKRemiitableEntity : NSObject
@property (strong,nonatomic) NSString *rate;
///汇款金额
@property (strong,nonatomic) WKRemiitableEntitySource *source;
///获得金额
@property (strong,nonatomic) WKRemiitableEntityTarget *target;
///服务费
@property (strong,nonatomic) WKRemiitableEntityServiceCharge *serviceCharge;
///总的付款金额
@property (strong,nonatomic) WKRemiitableEntityChargable *chargable;
@end

@interface WKRemiitableEntitySource : NSObject
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *amount;
@end
@interface WKRemiitableEntityTarget : NSObject
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *amount;
@end
@interface WKRemiitableEntityServiceCharge : NSObject
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *amount;
@end
@interface WKRemiitableEntityChargable : NSObject
@property (strong,nonatomic) NSString *currencyCode;
@property (strong,nonatomic) NSString *amount;
@end

@class WKOrderInfo;
@interface WKCreateOrderInfoObj : NSObject

@property (strong,nonatomic) WKOrderInfo *order;

@property (strong,nonatomic) NSString *qrCode;

@end

@interface WKOrderInfo : NSObject

@property (strong,nonatomic) NSString *serialNumber;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) WKRemiitableEntity *remittable;
@property (strong,nonatomic) NSString *amount;
@property (strong,nonatomic) WKResipientInfoObj *recipient;
@property (strong,nonatomic) NSString *purpose;
@property (strong,nonatomic) NSString *sourceOfFund;
@property (strong,nonatomic) NSArray *operations;
@property (strong,nonatomic) NSString *createdAt;
@property (strong,nonatomic) NSString *updatedAt;

@end

@interface WKOrderOperation : NSObject

@property (strong,nonatomic) NSString *mOperator; // 操作者
@property (strong,nonatomic) NSString *roleName;
@property (strong,nonatomic) NSString *operation;
@property (strong,nonatomic) NSString *fromStatus;
@property (strong,nonatomic) NSString *toStatus;
@property (strong,nonatomic) NSString *comment;
@property (strong,nonatomic) NSString *operatedAt;//时间

@property (assign,nonatomic) BOOL mStatus;///状态  yes:需要显示蓝色的点. no:不需要显示蓝色的点
@property (assign,nonatomic) BOOL mShowTop;///状态  yes:需要显示蓝色的点. no:不需要显示蓝色的点

@end
