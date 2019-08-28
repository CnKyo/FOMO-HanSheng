//
//  CLMeLanguageViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeLanguageViewController.h"

@interface CLMeLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *languageArray;
@property (nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation CLMeLanguageViewController
-(NSArray *)languageArray
{
    if (!_languageArray) {
        _languageArray=@[@"简体中文",@"English"];
    }
    return _languageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = languageStr(@"Choosing Language");
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
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
    [self LoadCellType:8];
    [self languageArray];
    [self setDefaultLanguage];
}

-(void)setDefaultLanguage
{
    // 假装只有两种语言·=-= ·
    if([[LocalizationManager userLanguage] isEqualToString:@"en"])
    {
        self.indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    }
    else
    {
        self.indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.languageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeSwitchLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(!cell){
        cell = [[CLMeSwitchLanguage alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.mLeftName.text = [_languageArray objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==self.indexPath.row) {
        cell.mRightImg.image = [UIImage yh_imageNamed:@"pdf_me_language_selected.pdf"];
    }
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [UIView new];
    headView.backgroundColor = ssRGBHex(0xF6F6F6);
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"触发点击事件");
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPath=indexPath;
    if (self.indexPath.row==0) {
        [LocalizationManager setUserlanguage:@"zh-Hans"];
    }else if (self.indexPath.row==1)
    {
        [LocalizationManager setUserlanguage:@"en"];
    }
    [self.mTabView reloadData];

}


-(void)back
{
    UIActivityIndicatorView *ac=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    ac.center=self.view.center;
    ac.hidesWhenStopped=YES;
    ac.color=clBlueRGB;
    [self.view addSubview:ac];
    [ac startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ac stopAnimating];   //动画
        [self.navigationController popViewControllerAnimated:YES];
    });
}
@end
