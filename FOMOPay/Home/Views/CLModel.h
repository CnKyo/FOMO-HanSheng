//
//  CLModel.h
//  FOMOPay
//
//  Created by clkj on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLModel : NSObject
@property (nonatomic,strong)NSDictionary *Array;
@property (nonatomic,strong)NSArray *Image;
@property (nonatomic,strong)NSArray *TitleLable;
@property (nonatomic,strong)NSArray *Subhead;
@property (nonatomic,strong)NSArray *RightTitle;



@property (strong,nonatomic) NSString *Title;

@property (assign,nonatomic) BOOL selected;

@property (assign,nonatomic) NSInteger number;
-(instancetype)initWithDic:(NSDictionary *)dic ;

+(instancetype)CLModelObjectWithDic:(NSDictionary *)dic;
@end


NS_ASSUME_NONNULL_END
