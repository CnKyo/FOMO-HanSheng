//
//  CLCollectionAdd.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAdd.h"

@interface CLCollectionAdd ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSArray *mAddLeftDateSource;
@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) UILabel *mLabel;
@property (nonatomic,strong) NSString *mModeString;
@end

@implementation CLCollectionAdd

- (void)viewDidLoad {
    [super viewDidLoad]; self.title = @"添加新收款人";
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
    
    [self LoadCellType:6];
   
    [self loadData];
}

- (void)loadData{
    _mAddLeftDateSource=@ [@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"账号号码"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mAddLeftDateSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMeLanguage *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.mMeLanguageLeftLabel.text = [_mAddLeftDateSource objectAtIndex:indexPath.row];
    [cell.mMeLanguageLeftLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [cell.mMeLanguageLeftLabel setTextColor:ssRGBHex(0x8C9091)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    if(indexPath.row ==0){
        UITextField *mNameText = [UITextField new];
        mNameText.backgroundColor  = [UIColor redColor];
        mNameText.delegate = self;
        mNameText.textAlignment = NSTextAlignmentRight;
        mNameText.clearButtonMode = UITextFieldViewModeAlways;
        [cell.contentView addSubview:mNameText];
//       cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);自定义下划线
        
        [mNameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-10);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            make.height.offset(30);
            make.width.offset(200);
        }];
    }
    if(indexPath.row == 1){
        _mLabel = [UILabel new];
        _mLabel.text = @"请选择";
        _mLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:_mLabel];
        
        UIImageView *mImageView = [UIImageView new];
        mImageView.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [cell.contentView addSubview:mImageView];
        [_mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-42);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
           
        }];
        [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(24);
            make.width.offset(24);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            make.right.equalTo(cell).offset(-10);
        }];
    }
    if(indexPath.row == 2){
        UILabel *mLabel = [UILabel new];
        mLabel.text = @"请选择";
        mLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:mLabel];
        
        UIImageView *mImageView = [UIImageView new];
        mImageView.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [cell.contentView addSubview:mImageView];
        [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-42);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            
        }];
        [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(24);
            make.width.offset(24);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            make.right.equalTo(cell).offset(-10);
        }];
    }
    
    if(indexPath.row == 3){
        UILabel *mLabel = [UILabel new];
        mLabel.text = @"请选择";
        mLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:mLabel];
        
        UIImageView *mImageView = [UIImageView new];
        mImageView.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [cell.contentView addSubview:mImageView];
        [mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(-42);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            
        }];
        [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(24);
            make.width.offset(24);
            make.centerY.equalTo(cell.mMeLanguageLeftLabel);
            make.right.equalTo(cell).offset(-10);
        }];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在当前控制器添加子控制器的view的调用方法
    if(indexPath.row == 1){
        NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
        self.mSelectView = [CLCollectionAddSelect new];
       
        self.mSelectView.modelArray  = modelArray;
      
        [self.view addSubview:self.mSelectView.view];
        
        [self.mSelectView initWithModelArray:self.mAddLeftDateSource and:indexPath.row];
       
     
       
        
//        self.mSelectView.view.alpha = 0.5;
//        self.mSelectView.view.backgroundColor = ssRGBAlpha(120, 120, 122, 0.8);
        
        
    }
    }
-(void)initWithModelString:(NSString *)modelString{
    self.mModeString = modelString;
    DebugLog(@"接受到传递过来的值为%@",self.mModeString);
}
@end
