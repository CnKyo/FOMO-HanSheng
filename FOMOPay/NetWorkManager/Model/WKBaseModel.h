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

@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *avatar;
@property (strong,nonatomic) NSString *lastLoginTime;
@property (strong,nonatomic) NSString *parent;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSString *username;
@property (strong,nonatomic) NSString *createTime;
@property (strong,nonatomic) NSString *nickName;


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


