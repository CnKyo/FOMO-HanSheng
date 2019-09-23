//
//  HomeListCollectionModel.h
//  FOMOPay
//
//  Created by clkj on 2019/9/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeListCollectionModel : NSObject

@end


@interface ForCollection : NSObject
@property (nonatomic,strong) NSString *mLogo;
@property (nonatomic,strong) NSString *mTitle;
@property (nonatomic,strong) NSString *mName;
@property (nonatomic,assign) NSInteger tag;

@end
NS_ASSUME_NONNULL_END
