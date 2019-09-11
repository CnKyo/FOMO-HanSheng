//
//  WKOrderDetailView.m
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKOrderDetailView.h"
#import "WKOrderTimeLineCell.h"
@interface WKOrderDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) WKOrderInfo *mItem;

@end

@implementation WKOrderDetailView

+ (WKOrderDetailView *)shareView{

    WKOrderDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKOrderDetailView" owner:self options:nil] objectAtIndex:0];
    view.mTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    view.mTableView.delegate = view;
    view.mTableView.dataSource = view;
    view.mTableView.scrollEnabled = NO;
    
    UINib   *nib = [UINib nibWithNibName:@"WKOrderTimeLineCell" bundle:nil];
    [view.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    view.mLeftBtn.layer.masksToBounds = YES;
    view.mRightBtn.layer.masksToBounds = YES;
    view.mCenterBtn.layer.masksToBounds = YES;
    
    
    view.mLeftBtn.layer.cornerRadius = 2;
    view.mRightBtn.layer.cornerRadius = 2;
    view.mCenterBtn.layer.cornerRadius = 2;

    view.mLeftBtn.layer.borderColor = KMethodColor.CGColor;
    view.mLeftBtn.layer.borderWidth = 1.0f;

    view.mCenterBtn.layer.borderColor = KMethodColor.CGColor;
    view.mCenterBtn.layer.borderWidth = 1.0f;

    view.mCenterBtn.hidden = YES;
    return view;
    
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if(self.mBtnBlock){
        self.mBtnBlock(sender.tag);
    }
}

-(WKOrderInfo *)mItem{
    if (!_mItem) {
        _mItem = [WKOrderInfo new];
    }
    return _mItem;
}
- (void)updateOrderInfo:(WKOrderInfo *)info{
    self.mItem = info;
    
    self.mRecipient.text = info.recipient.fullName;
    self.mTransferAmount.text = [NSString stringWithFormat:@"%@%@",info.remittable.source.currencyCode,info.remittable.source.amount];
    self.mTotleAmount.text = [NSString stringWithFormat:@"%@%@",info.remittable.target.currencyCode,info.remittable.target.amount];
    [self reloadBtnStatus:info];
    [self.mTableView reloadData];
}

- (void)reloadBtnStatus:(WKOrderInfo *)info{
    self.mTip.hidden = YES;
    if ([info.status isEqualToString:@"pending"]) {
        self.mCenterBtn.hidden = YES;
        self.mLeftBtn.hidden = NO;
        self.mRightBtn.hidden = NO;
    }else if ([info.status isEqualToString:@"processing"]){
        self.mCenterBtn.hidden = NO;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else if ([info.status isEqualToString:@"remitting"]){
        self.mCenterBtn.hidden = NO;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else if ([info.status isEqualToString:@"successful"]){
        self.mCenterBtn.hidden = YES;
        self.mLeftBtn.hidden = NO;
        self.mRightBtn.hidden = NO;
        self.mTip.hidden = NO;
        [self.mLeftBtn setTitle:@"再次汇款" forState:0];
        [self.mRightBtn setTitle:@"获得PDF收据" forState:0];
    }else if ([info.status isEqualToString:@"failed"]){
        self.mCenterBtn.hidden = NO;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
        [self.mCenterBtn setTitle:@"修改" forState:0];
    }else if ([info.status isEqualToString:@"refunding"]){
        self.mCenterBtn.hidden = YES;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else if ([info.status isEqualToString:@"refunded"]){
        self.mCenterBtn.hidden = YES;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else if ([info.status isEqualToString:@"cancelled"]){
        self.mCenterBtn.hidden = YES;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
    }else if ([info.status isEqualToString:@"error1"]){
        self.mCenterBtn.hidden = NO;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
        [self.mCenterBtn setTitle:@"修改" forState:0];

    }else{
        self.mCenterBtn.hidden = NO;
        self.mLeftBtn.hidden = YES;
        self.mRightBtn.hidden = YES;
        [self.mCenterBtn setTitle:@"修改" forState:0];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mItem.operations.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"cell";
    WKOrderTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0 ) {
        cell.mTopLine.hidden = YES;
    }else if (indexPath.row == self.mItem.operations.count-1){
        cell.mBottomLine.hidden = YES;
    }else{
        cell.mBottomLine.hidden = NO;
        cell.mTopLine.hidden = NO;

    }
    [cell setMItem:self.mItem.operations[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
