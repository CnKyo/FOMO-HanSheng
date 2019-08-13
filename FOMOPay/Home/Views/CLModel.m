//
//  CLModel.m
//  FOMOPay
//
//  Created by clkj on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLModel.h"


@implementation CLModel

+ (instancetype)CLModelObjectWithDic:(NSDictionary *)dic{
    CLModel  *model = [[CLModel alloc]initWithDic:dic];
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
   
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
         
    }
    
    return  self;
}



@end
