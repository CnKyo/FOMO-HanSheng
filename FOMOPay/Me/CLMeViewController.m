//
//  CLMeViewController.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeViewController.h"
#import "WKLoginManager.h"
@interface CLMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *personalTableView;
@property (nonatomic,strong) NSArray *mMeDataSource;
@property (nonatomic,strong) NSArray *mMeImageDataSource;
@end

@implementation CLMeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DebugLog(@"条款的连接是:%@",[WKAccountManager shareInstance].appConfig.tncLink);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CLAddNavType:CLNavType_home andModel:nil completion:^(NSInteger tag) {
        
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
    [self LoadCellType:5];
//    _mMeDataSource=@[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
    _mMeDataSource=@[languageStr(@"language"),languageStr(@"Contact Us"),languageStr(@"Treaty Clauses"),languageStr(@"Message Notification"),languageStr(@"Logout")];
    _mMeImageDataSource=@[@"pdf_me_language.pdf",@"pdf_me_callme.pdf",@"pdf_me_pact.pdf",@"pdf_me_message.pdf",@"pdf_me_logout.pdf"];

}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组数 也就是section数
    return 2;
}

//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1) {
        return self.mMeDataSource.count;
    }else{
        return 1;
    }
}



//每个分组下边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = ssRGBHex(0xF6F5FA);
    return view;
   
}

//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 78;
    }
    return 48;
}

//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CLMeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[CLMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0) {
        cell=[[CLMeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        UIImageView *UserimageView=[[UIImageView alloc]init];
        UserimageView.image=[UIImage yh_imageNamed:@"pdf_me_userImage.pdf"];
        UserimageView.layer.cornerRadius = 24;
        UserimageView.layer.masksToBounds = YES;
        [cell.contentView addSubview:UserimageView];
        [UserimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(15);
            make.bottom.equalTo(cell).offset(-15);
            make.left.equalTo(cell).offset(15);
        }];

        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.text= [WKAccountManager shareInstance].name;
        [nameLabel setFont: [UIFont fontWithName:@"PingFangSC-Regular" size:18]];
        [cell.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(19);
            make.left.equalTo(cell).offset(84);
            
        }];
        UILabel *phoneLabel  = [[UILabel alloc]init];
        phoneLabel.text = [WKAccountManager shareInstance].mobileNumber;
        [phoneLabel setFont: [UIFont fontWithName:@"PingFangSC-Regular" size:14]];
        [cell.contentView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(47);
            make.left.equalTo(cell).offset(78);
        }];
    }
    
    if (indexPath.section==1) {
        if(indexPath.row){
            
      
        cell.mMeLeftImage.image =[UIImage yh_imageNamed:[_mMeImageDataSource objectAtIndex:indexPath.row]];
        cell.mMeLeftLable.text = [_mMeDataSource objectAtIndex:indexPath.row];
        cell.mMeLanguage.hidden = YES;
       
        }else{
            cell.mMeLanguage.text = languageStr(@"Language") ;   //设置显示的语言的text
            cell.mMeLanguage.hidden = NO;
            cell.mMeLeftImage.image =[UIImage yh_imageNamed:[_mMeImageDataSource objectAtIndex:indexPath.row]];
            cell.mMeLeftLable.text = [_mMeDataSource objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1){
    if(indexPath.row == 0){
        CLMeLanguageViewController *vc = [CLMeLanguageViewController new];
        [self pushToViewController:vc];
    }else if(indexPath.row == 1){
        CLMeCallMeViewController *vc = [CLMeCallMeViewController new];
        [self pushToViewController:vc];
    }else if(indexPath.row == 2){
        CLMeClauseOfTreaty *vc = [CLMeClauseOfTreaty new];
        [self pushToViewController:vc];
    }else if(indexPath.row == 3){
        CLMeMessageViewController *vc = [CLMeMessageViewController new];
        [self pushToViewController:vc];
    }else {
        
        [self showLoading:@"log outing..."];
        [WKNetWorkManager WKLogOut:^(id result,BOOL success) {
            [self hiddenLoading];
            if (success) {
                [[WKAccountManager shareInstance] WKClearnAll];
                [[WKLoginManager shareInstance]presentLoginViewController:^{

                }];
//                LogInViewController *vc = [LogInViewController new];
//                [self pushToViewController:vc];
            }else{
                TOASTMESSAGE([NSString stringWithFormat:@"%@",result]);
            }
        }];
//        [[WKLoginManager shareInstance]presentLoginViewController:^{
//        //
//        }];

    }
}
}

-(void)changeLanguage
{
//    CLMeLanguageViewController *vc = [CLMeLanguageViewController new];
//    [vc back];
//    vc.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:vc animated:NO];
    
}



@end
