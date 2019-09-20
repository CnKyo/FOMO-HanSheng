//
//  xModel.h
//  FOMOPay
//
//  Created by clkj on 2019/9/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface xModel : NSObject

@end


@interface FormObj : NSObject
@property (nonatomic,strong) NSString *mTitle;

@property (nonatomic,strong) NSString *mContent;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) NSInteger tag;

@property (nonatomic,assign) BOOL needRefresh;

@end

@interface ResultObj : NSObject

@end




