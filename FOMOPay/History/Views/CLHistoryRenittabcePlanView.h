//
//  CLHistoryRenittabcePlanCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#define space 10
//原点大小
#define spotWH 10
//字体大小
#define titleFont spotWH/2+2
#define linkWH 1.5

@interface CLHistoryRenittabcePlanView : UIView
//-(instancetype)initWithFrame:(CGRect)frame setDirection:(BOOL)Direction setCount:(NSInteger)Count ;
-(instancetype)initsetCount:(NSInteger)Count;
@property(nonatomic,assign)NSInteger PortraitRecordIndex ;
@end


