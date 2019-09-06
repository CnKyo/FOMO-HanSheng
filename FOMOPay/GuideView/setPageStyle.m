//
//  setPageStyle.m
//  FOMOPay
//
//  Created by clkj on 2019/9/6.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "setPageStyle.h"

@implementation setPageStyle

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self =[super init];
    if(self){
        self.userInteractionEnabled = NO;
}
    return self;
}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        //        CGSize size;
        
        //        size.height = 12;
        //
        //        size.width = 12;
        //
        //        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
        //
        //                                     size.width,size.height)];
        
        if (subviewIndex == currentPage)
            
            //        subview.image =[UIImage imageNamed:@"60.png"];
        {    subview.layer.cornerRadius = 0;
            subview.layer.masksToBounds = YES;
        }
        else
        {    //subview.image =[UIImage imageNamed:@"60.png"];
            subview.layer.cornerRadius = 0;
            subview.layer.masksToBounds = YES;
            
        }
    }
}
@end
