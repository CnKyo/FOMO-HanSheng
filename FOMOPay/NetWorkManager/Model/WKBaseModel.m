//
//  WKBaseModel.m
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKBaseModel.h"

@implementation WKBaseModel

@end

@implementation WKUserInfo


@end

@implementation WKLaunchAdInfo


@end

@implementation WKFollowRecordObj


@end
@implementation WKUnreadObj


@end
@implementation WKSysNotifyObj


@end

@implementation WKPatientCategoryObj


@end


@implementation WKComprehensiveRecordList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [WKComprehensiveRecord class]};
}
@end

@implementation WKComprehensiveRecord


@end


@implementation WKPatientCustomComprehensiveInfo

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [WKPatientCustomDetailInfo class]};
}
@end

@implementation WKPatientCustomDetailInfo

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mDescription" : @"description"};
}
@end

@implementation WKPatientPhoneRecordsObj
@end

@implementation WKAppConfigObj
@end


@implementation WKRefundAccount
@end
