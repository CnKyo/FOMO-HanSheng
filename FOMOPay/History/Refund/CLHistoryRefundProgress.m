//
//  CLHistoryRefundProgress.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRefundProgress.h"

@interface CLHistoryRefundProgress ()<UITableViewDataSource,UITableViewDelegate>
@property NSInteger i;
@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSArray *mRData;
@property (nonatomic,strong)NSArray *mLeftDate;//左边的日期
@property (nonatomic,strong)NSArray *mRightData;
@property (nonatomic,strong)NSArray *mRightDataHint;
@end

@implementation CLHistoryRefundProgress

- (void)viewDidLoad {
    [super viewDidLoad];
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mBtView = [CLNavgationView_button shareDefaultNavRightButtonRefundProgress];
    model.mRightView = mBtView ;
    mBtView.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 102) {
            
           CLHistoryDetailsOfRefund *vc = [CLHistoryDetailsOfRefund new];
            [self pushToViewController: vc];
            
        }
    };
    self.title = @"退款进度";
    [self CLAddNavType:CLNavType_default andModel:model completion:^(NSInteger tag) {
        
        switch (tag) {
            case 0:
            {
                DebugLog(@"左边按钮");
            }
                break;
            case 1:
            {
                DebugLog(@"右边按钮");
            }
                break;
            default:
                break;
        }
    }];
    [self LoadCellType:9];
    self.mData=@[@"收款人",@"汇款金额",@"获得金额"];
    self.mRData=@[@"Angela Lee",@"SGD182.00",@"CNY910.00"];
    self.mLeftDate = @[@"7月7日",@"7月8日",@"7月9日",@"7月30日"];
    self.mRightData = @[@"提交退款订单",@"已收到退款申请",@"正在为您处理退款订单",@"退款成功"];

    self.i = 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return self.mData.count;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHistoryDetailsOfRemittancesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell == nil){
        cell = [[CLHistoryDetailsOfRemittancesCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if(indexPath.section == 0){
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        if(indexPath.row == 2){
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        cell.mLeftName.text= [_mData objectAtIndex:indexPath.row];
        cell.mLeftName.textAlignment = NSTextAlignmentLeft;
        cell.mRightData.text = [_mRData objectAtIndex:indexPath.row];
        cell.mRightData.textAlignment = NSTextAlignmentRight;
        
    }
    //提示小文字离大文字的间距全部为8
    
    //左侧时间为创建时间
    if(indexPath.section == 1){
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
        cell.mRightData.hidden = YES;
        cell.mLeftName.font = kCommonFont(14);
        if(indexPath.row == 0){
            cell.mLeftName.text = @"汇款进度";
            cell.mLeftName.font = kCommonFont(16);
            cell.mLeftName.textColor = ssRGBHex(0x8C9091);
            
        }
        
        
        if(indexPath.row == 1){
            for(id subview in cell.contentView.subviews){
                [subview removeFromSuperview];
            }
            
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 112)];//背景条
                bgview1.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview1];
                UILabel *titleLabel1 = [[UILabel alloc]init]; //背景条上的点
                titleLabel1.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel1.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel1.layer.cornerRadius = 10/2 ;
                titleLabel1.clipsToBounds = YES ;
                
                [bgview1 addSubview:titleLabel1];
                UILabel  *mLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(97, 20, 118, 16)];
                mLabel1.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel1.font = kCommonFont(16);
                mLabel1.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel1];
                
                UILabel *mTitleHint1= [[UILabel alloc]initWithFrame:CGRectMake(97, mLabel1.frame.size.height +14 +8, 256, 57)];//提示小文字
                mTitleHint1.textColor = ssRGBHex(0x8C9091);
                mTitleHint1.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint1.numberOfLines = 0;
                mTitleHint1.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint1];
                
//                [self LoadButtonCancelAndQuery];
            }else if(self.i >indexPath.row){
                cell.mLeftName.hidden = YES;
                //                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(18, 13, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                
                UIView *bgview1 = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 48)];//背景条
                bgview1.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview1];
                UILabel *titleLabel1= [[UILabel alloc]init]; //背景条上的点
                titleLabel1.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel1.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel1.layer.cornerRadius = 10/2 ;
                titleLabel1.clipsToBounds = YES ;
                [bgview1 addSubview:titleLabel1];
                UILabel *mLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel1.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel1.textColor =  ssRGBHex(0x8C9091);
                mLabel1.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel1];
            }}
        //第二个
        if(indexPath.row == 2){
            
            for(id subview in cell.contentView.subviews){
                [subview removeFromSuperview];
            }
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(17, 16, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 106)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, -5, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 14, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97,15, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
                
            }else if(self.i >indexPath.row){
                
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(17, 14, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 48)];//背景条
                bgview.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 41)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        //第三个
        if(indexPath.row == 3){
            for(id subview in cell.contentView.subviews){
                [subview removeFromSuperview];
            }
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(17, 16, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 82)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, -5, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 16, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 16+8, 256, 57)];//提示小文字
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
//                [self LoadContactButton];
                
            }else if(self.i >indexPath.row){
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(18, 13, 46, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                //                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 47)];//背景条
                bgview.backgroundColor =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 41)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        
        
        //第四个
        if(indexPath.row == 4){
            for(id subview in cell.contentView.subviews){
                [subview removeFromSuperview];
            }
            if (self.i == indexPath.row) {
                cell.mLeftName.hidden = YES;
                UILabel *mLeftData= [[UILabel alloc]initWithFrame:CGRectMake(13, 20, 60, 14)];//左边日期
                mLeftData.textColor = ssRGBHex(0x8C9091);
                mLeftData.text = [_mLeftDate objectAtIndex:indexPath.row - 1];
                mLeftData.font =kCommonFont(14);
                [cell.contentView addSubview:mLeftData];
                
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 22, 1.5, 0)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor =ssRGBHex(0x005CB6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                
                [bgview addSubview:titleLabel];
                UILabel  *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 16, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.font = kCommonFont(16);
                mLabel.textColor  =ssRGBHex(0x005CB6);
                [cell.contentView addSubview:mLabel];
                //-------------------------------------------------------------------------判断成功失败时候的按钮
                if([mLabel.text isEqual:@"汇款成功"]){
                    
//                    [self LoadSureButton];
                    //                    [self LoadAlterButton];
                }else if([mLabel.text isEqual:@"汇款出错"]){
//                    [self LoadAlterButton];
                    mLabel.textColor  = ssRGBHex(0xD50037);
                };
                
                UILabel *mTitleHint = [[UILabel alloc]initWithFrame:CGRectMake(97, 18, 256, 57)];//提示小文字//
                mTitleHint.textColor = ssRGBHex(0x8C9091);
                mTitleHint.text=[_mRightDataHint objectAtIndex:indexPath.row - 1];
                mTitleHint.numberOfLines = 0;
                mTitleHint.font = kCommonFont(12);
                [cell.contentView addSubview:mTitleHint];
                
                
                //            }else if(self.i >indexPath.row){
                //                cell.mLeftName.text =[_mLeftDate objectAtIndex:indexPath.row - 1];
                //                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 39)];//背景条
                //                bgview.backgroundColor =ssRGBHex(0x005CB6);
                //                [cell.contentView addSubview:bgview];
                //                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                //                titleLabel.backgroundColor = ssRGBHex(0x005CB6);
                //                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                //                titleLabel.layer.cornerRadius = 10/2 ;
                //                titleLabel.clipsToBounds = YES ;
                //                [bgview addSubview:titleLabel];
                //                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                //                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                //                mLabel.textColor =  ssRGBHex(0x8C9091);
                //                mLabel.font = kCommonFont(16);
                //                [cell.contentView addSubview:mLabel];
            }else{
                cell.mLeftName.hidden = YES;
                UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(68, 16, 1.5, 0)];//背景条
                bgview.backgroundColor =ssRGBHex(0xE6E6E6);
                [cell.contentView addSubview:bgview];
                UILabel *titleLabel = [[UILabel alloc]init]; //背景条上的点
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(-4, 0, 10, 10);
                titleLabel.layer.cornerRadius = 10/2 ;
                titleLabel.clipsToBounds = YES ;
                [bgview addSubview:titleLabel];
                UILabel *mLabel = [[UILabel alloc]initWithFrame:CGRectMake(97, 13, 118, 16)];
                mLabel.text= [_mRightData objectAtIndex:indexPath.row - 1];
                mLabel.textColor =  ssRGBHex(0x8C9091);
                mLabel.font = kCommonFont(16);
                [cell.contentView addSubview:mLabel];
            }}
        if(indexPath.row == 5){
            for(id subview in cell.contentView.subviews){
                [subview removeFromSuperview];
            }
            cell.mLeftName.hidden = YES;
            cell.mRightData.hidden = YES;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 62;
    }else if(indexPath.section == 1 && indexPath.row ==0){
        return 62;
    }
    if(indexPath.section ==1 &&indexPath.row==1 &&self.i==1){
        return 118;
    
    }else{
        return 41;
    }
}



@end
