//
//  WKOrderTimeLineCell.m
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKOrderTimeLineCell.h"

@implementation WKOrderTimeLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.mPoint.layer.masksToBounds = YES;
    self.mPoint.layer.cornerRadius = self.mPoint.mj_w/2;
    
    self.mPoint.backgroundColor = KMethodColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMItem:(WKOrderOperation *)mItem{
    if (mItem.operatedAt.length>0) {
        NSArray *mDateArr = [CLTool WKStringSeparatedStringWithTag:@"-" andText:[mItem.operatedAt substringToIndex:10]];
        
        self.mDate.text = [NSString stringWithFormat:@"%@月%@日",mDateArr[1],mDateArr[2]];
        self.mDate.hidden = NO;
    }else{
        self.mDate.hidden = YES;
    }
    
//    self.mTitle.text = mItem.operation;
    self.mTitle.text  = [self mOperation:mItem.operation];
    self.mContent.text = mItem.comment;
    if (mItem.comment.length<=0) {
        self.mContent.hidden = YES;
    }else{
        self.mContent.hidden = NO;
    }
    
    if (mItem.mStatus == YES) {
        self.mPoint.backgroundColor = KMethodColor;
        self.mTopLine.backgroundColor = KMethodColor;
        self.mBottomLine.backgroundColor = KMethodColor;
    }else{
        self.mPoint.backgroundColor = kGrayColor;
        self.mTopLine.backgroundColor = kGrayColor;
        self.mBottomLine.backgroundColor = kGrayColor;
    }
    if (mItem.mShowTop == YES) {
        self.mTopLine.backgroundColor = KMethodColor;

    }else{
        self.mTopLine.backgroundColor = kGrayColor;

    }
}

- (NSString *)mOperation:(NSString *)status{ //中英文转换
    if ([status isEqualToString:@"submit"]) {
        return @"提交汇款订单";
    }else{
         return status;
    }
//    return status;
}

@end
