//
//  Header.h
//  FOMOPay
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */

#import "CLNavModel.h"

typedef enum : NSUInteger {
    LoadNavType_Default =0,
    LoadNavType_Other =1,
    LoadCellType_Style1 =2,
    LoadCellType_Style2 =3,
    LoadCellType_Style3 =4,
} Type;


typedef enum : NSUInteger {
    ///默认
    CLNavType_default = 0,
    ///首页
    CLNavType_home = 1,
    ///其他
    CLNavType_other = 2,
    
} CLNavType;
