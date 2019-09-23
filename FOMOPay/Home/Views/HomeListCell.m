//
//  HomeListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListCollectionCell.h"
#import "HomeListCollectionModel.h"
#import "CLCollectionAddSelect.h"
@interface HomeListCell()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UIView *valueView;
@property (weak, nonatomic) IBOutlet UIButton *changeCountryButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage1;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *showImage1;
@property (weak, nonatomic) IBOutlet UIView *rightView1;
@property (weak, nonatomic) IBOutlet UIView *valueView1;
@property (weak, nonatomic) IBOutlet UIButton *changeCountryButton1;

@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIView *exchangeRateView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage2;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel2;
@property (weak, nonatomic) IBOutlet UIView *valueView2;
@property (weak, nonatomic) IBOutlet UIView *amountView;

@property (weak, nonatomic) IBOutlet UIButton *exchangeRateButton;
@property (weak, nonatomic) IBOutlet UIView *CountryView;
@property (weak, nonatomic) IBOutlet UIView *ContryViewOne;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;


@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;
@property (nonatomic, strong) NSArray *array3;

@property (nonatomic, assign) NSInteger mTag;

@property (nonatomic, assign) WKRemmitableStatus mStatus;

@property (nonatomic, strong) NSString *mOut;
@property (nonatomic, strong) NSString *mIn;

@property (nonatomic,strong) NSMutableArray *mDataArr;



@end

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mOut = @"SGD";
    self.mIn = @"CNY";
    
    self.mStatus = WKRemmitableStatus_out;

    NSString *mRate = [WKAccountManager shareInstance].mRate;
    if ([mRate floatValue]<=0) {
        mRate = @"0";

    }
    _exchangeRateLabel.text = mRate;
    
    _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
    
    _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
    
    _logoImage.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2"];
    _logoImage1.image = [UIImage yh_imageNamed:@"pdf_CNY"];
    _logoImage2.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2"];
    _logoImage.layer.borderWidth = 1;
    _logoImage.layer.cornerRadius = 20;
    _logoImage.layer.masksToBounds= YES;
    _logoImage.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    
    _logoImage1.layer.borderWidth = 1;
    _logoImage1.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    _logoImage1.layer.cornerRadius = 20;
    _logoImage1.layer.masksToBounds= YES;
    
    _logoImage2.layer.borderWidth = 1;
    _logoImage2.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    _logoImage2.layer.cornerRadius = 20;
    _logoImage2.layer.masksToBounds= YES;
    
    _myTextField.delegate = self;
    _myTextField1.delegate = self;
    _myTextField2.delegate = self;
    [_myTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_myTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_myTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _valueView.layer.borderWidth = 2;
    _valueView.layer.borderColor = ssRGBHex(0x005CB6).CGColor;

    _valueView1.layer.borderWidth = 2;
    _valueView1.layer.borderColor = ssRGBHex(0xD50037).CGColor;
    
    _valueView2.layer.borderWidth = 2;
    _valueView2.layer.borderColor = ssRGBHex(0x7F7F7F).CGColor;
    
    _exchangeRateButton.enabled = NO;
    _exchangeRateButton.layer.cornerRadius = 5.0;
    
    _array1 = @[@"pdf_CNY",@"pdf_TWD",@"pdf_MYR",@"pdf_HKD",@"pdf_IDR",@"pdf_PHP"];
    _array2 = @[@"CNY",@"TWD",@"MYR",@"HKD",@"IDR",@"PHP"];
    _array3 = @[@"(人民币)",@"(新台币)",@"(令吉)",@"(港元)",@"(印尼卢比)",@"(菲律宾比索)"];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //纵向间距
    layout.minimumLineSpacing = 0;
    //横向间距
    layout.minimumInteritemSpacing = 0;
    _myCollectionView.collectionViewLayout = layout;
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    
    [_myCollectionView registerNib:[UINib nibWithNibName:@"HomeListCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeListCollectionCell"];
    [self loadData];
    
}
- (NSMutableArray *)mDataArr{
    if(!_mDataArr){
        _mDataArr = [NSMutableArray new];
    }
    return _mDataArr;
}

-(void)loadData{
    NSArray *mLogoArr =@[@"pdf_CNY",@"pdf_TWD",@"pdf_MYR",@"pdf_HKD",@"pdf_IDR",@"pdf_PHP"];
    NSArray *mTitleArr =@[@"CNY",@"TWD",@"MYR",@"HKD",@"IDR",@"PHP"];
    NSArray *mNameArr =@[@"(人民币)",@"(新台币)",@"(令吉)",@"(港元)",@"(印尼卢比)",@"(菲律宾比索)"];
    [self.mDataArr removeAllObjects];
    for (int i=0; i<mLogoArr.count; i++) {
        ForCollection *mItem = [ForCollection new];
        mItem.tag = i;
        mItem.mLogo = mLogoArr[i];
        mItem.mTitle = mTitleArr[i];
        mItem.mName = mNameArr[i];
        [self.mDataArr addObject:mItem];
    }
    [self.myCollectionView reloadData];
    
}

- (void)setType:(HomeListCellType)type{
    
    if (type == HomeListCellTypeHome) {
        
        [_exchangeRateButton setTitle:@"汇款" forState:UIControlStateNormal];
        
    }else{
        
        [_exchangeRateButton setTitle:@"修改" forState:UIControlStateNormal];
    }
}

- (void)isShowGetAmountView:(BOOL)isShow{
    
    if (isShow) {
        
        _rightView1.backgroundColor = kCommonColor(255, 232, 237, 1);
        _valueView1.hidden = NO;
        
    }else{
        
        _rightView1.backgroundColor = [UIColor whiteColor];
        _valueView1.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_HomeListCellBlock) {
        
        _HomeListCellBlock(textField.text,textField.tag);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(string.length >0){
        unichar single = [string characterAtIndex:0];
        if(single == '0'){
            TOASTMESSAGE(@"汇出金额必须大于0");
             [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
        
    }
    return [self validateNumber:string];
}


- (void)textFieldDidChange:(UITextField *)textField{
    
//    if (textField.tag == 4000) {
//        self.mStatus = WKRemmitableStatus_out;
//
//        if ([textField.text isEqualToString:@"0"]) {
//            
//            _myTextField1.text = @"0";
//            _myTextField2.text = @"0";
//            
//        }else if (textField.text.length == 0){
//            
//            _myTextField1.text = nil;
//            _myTextField2.text = nil;
//            
//        }else{
//            
//            _myTextField1.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*[_exchangeRateLabel.text floatValue]];
//            _myTextField2.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*1.2];
//        }
//    }else if (textField.tag == 4001){
//        self.mStatus = WKRemmitableStatus_in;
//
//        if ([textField.text isEqualToString:@"0"]) {
//            
//            _myTextField.text = @"0";
//            _myTextField2.text = @"0";
//            
//        }else if (textField.text.length == 0){
//            
//            _myTextField.text = nil;
//            _myTextField2.text = nil;
//            
//        }else{
//            
//            _myTextField.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]/[_exchangeRateLabel.text floatValue]];
//            _myTextField2.text = [NSString stringWithFormat:@"%.4f",(long)[_myTextField.text floatValue]*1.2];
//        }
//    }else{
//        self.mStatus = WKRemmitableStatus_pay;
//
//        if ([textField.text isEqualToString:@"0"]) {
//            
//            _myTextField.text = @"0";
//            _myTextField1.text = @"0";
//
//        }else if (textField.text.length == 0){
//            
//            _myTextField.text = nil;
//            _myTextField1.text = nil;
//            
//        }else{
//            
//            _myTextField.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*0.8];
//            _myTextField1.text = [NSString stringWithFormat:@"%.4f",(long)[_myTextField.text floatValue]*[_exchangeRateLabel.text floatValue]];
//        }
//    }
    
    if (textField.text.length > 0 && ![textField.text isEqual:@"0"]) {
        
        _exchangeRateButton.enabled = YES;
        _exchangeRateButton.backgroundColor = kLoginTitleColor;
        
    }else{
        
        _exchangeRateButton.enabled = NO;
        _exchangeRateButton.backgroundColor = kCommonColor(140, 144, 145, 1);
    }
    
    
//    [self caculateAmount:textField.text];
}

- (IBAction)exchangeRateButtonClicked:(UIButton *)sender {
    
    if (_HomeListCellButtonBlock) {
        
        _HomeListCellButtonBlock(_unitNameLabel.text);
    }
}

- (IBAction)showButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.mTag = sender.tag;
    if (sender.selected == YES) {
        
        if (sender.tag == 1000) {
            
//            CLCollectionAddSelect *m = [CLCollectionAddSelect new];
////            m.view.frame = self.ContryViewOne.frame;
//            m.view.frame = self.CountryView.frame;
//            [self.ContryViewOne addSubview:m.view];
//            self.ContryViewOne.hidden = NO;
//            self.ContryViewOne.backgroundColor = [UIColor redColor];
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
//            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
//            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _changeCountryButton1.selected = NO;
            
        }else{
            
//            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
//            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
            _changeCountryButton.selected = NO;
            
        }
        _CountryView.hidden = NO;
        
        
    }else{
        
        if (sender.tag == 1000) {
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
//            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];

        }else{
             _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
        }
        _CountryView.hidden = YES;
    }
}

#pragma mark ---- UICollectionViewDataSource ----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.mDataArr.count;
//    return 6;
}

- (NSInteger)nmumberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kScreenWidth/2,90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeListCollectionCell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeListCollectionCell" forIndexPath:indexPath];
    }
    if(indexPath.section == 0){
      
    }
    ForCollection *mCellmItem = _mDataArr[indexPath.row];
    cell.iconImage.image = [UIImage yh_imageNamed:mCellmItem.mLogo];
    cell.unitLabel.text = mCellmItem.mTitle;
    cell.nameLabel.text = mCellmItem.mName;
//    cell.iconImage.image = [UIImage yh_imageNamed:_array1[indexPath.row]];
//    cell.unitLabel.text = _array2[indexPath.row];
//    cell.nameLabel.text = _array3[indexPath.row];

    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ForCollection *m =_mDataArr[indexPath.row];
    NSString *mUnit = _array2[indexPath.row];
    NSString *mName = _array3[indexPath.row];

    if (self.mTag == 1000) {
        
//        self.mOut = mUnit;
        self.mOut = m.mTitle;
        
//        self.unitNameLabel2.text = mUnit;
        self.unitNameLabel2.text = m.mTitle;
        
        self.chinaNameLabel2.text = m.mName;
//        self.chinaNameLabel2.text = mName;
        
        self.unitNameLabel.text = m.mTitle;
//        self.unitNameLabel.text = mUnit;
//        self.chinaNameLabel.text = mName;
        self.chinaNameLabel.text = m.mName;
        [self.mDataArr replaceObjectAtIndex:indexPath.row withObject:m];
//        [self.myCollectionView reloadData];
//     [weakSelf.mDataArr replaceObjectAtIndex:mIndexPath.row withObject:mItem];
    }else{
        
//        self.mIn = mUnit;
        self.mIn = m.mTitle;
        
//        self.unitNameLabel1.text = mUnit;
        self.unitNameLabel.text = m.mTitle;
//        self.chinaNameLabel1.text = mName;
        self.chinaNameLabel1.text = m.mName;
    }
    
    if (self.mSelectedBlock) {
        self.mSelectedBlock(self.unitNameLabel.text,self.unitNameLabel1.text);
    }
    
    [self updateLogo:mUnit];
    _CountryView.hidden = YES;
     self.changeCountryButton.selected = NO;
    self.changeCountryButton1.selected = NO;
    self.showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
    self.showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
//    self.showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
}

- (void)updateLogo:(NSString *)text{
    NSString *mImg = @"";
    if (self.mTag == 1000) {
        if ([text isEqualToString:@"CNY"]) {
            mImg = @"pdf_CNY";
        }else if ([text isEqualToString:@"TWD"]){
            mImg = @"pdf_TWD";
        }else if ([text isEqualToString:@"MYR"]){
            mImg = @"pdf_MYR";
        }else if ([text isEqualToString:@"HKD"]){
            mImg = @"pdf_HKD";
        }else if ([text isEqualToString:@"IDR"]){
            mImg = @"pdf_IDR";
        }else{
            mImg = @"pdf_PHP";
        }
        self.logoImage.image = [UIImage yh_imageNamed:mImg];
        self.logoImage2.image = [UIImage yh_imageNamed:mImg];
    }else{
        if ([text isEqualToString:@"CNY"]) {
            mImg = @"pdf_CNY";
        }else if ([text isEqualToString:@"TWD"]){
            mImg = @"pdf_TWD";
        }else if ([text isEqualToString:@"MYR"]){
            mImg = @"pdf_MYR";
        }else if ([text isEqualToString:@"HKD"]){
            mImg = @"pdf_HKD";
        }else if ([text isEqualToString:@"IDR"]){
            mImg = @"pdf_IDR";
        }else{
            mImg = @"pdf_PHP";
        }
        self.logoImage1.image = [UIImage yh_imageNamed:mImg];
    }
   
    
}

- (void)caculateAmount:(NSString *)text{
    
    if (self.mStatus == WKRemmitableStatus_out) {
        ///转出
        float mAmount = [[NSString stringWithFormat:@"%.2f",[text floatValue]*[[WKAccountManager shareInstance].mRate floatValue]] floatValue];
        self.myTextField.text = text;
        self.myTextField1.text = [NSString stringWithFormat:@"%f",mAmount];
        self.myTextField2.text = [NSString stringWithFormat:@"%f",mAmount+18];

    }else if (self.mStatus == WKRemmitableStatus_in){
        ///转入
        float mAmount = [[NSString stringWithFormat:@"%.2f",[text floatValue]/[[WKAccountManager shareInstance].mRate floatValue]] floatValue];
        
        self.myTextField.text = [NSString stringWithFormat:@"%f",mAmount];
        self.myTextField1.text = text;
        self.myTextField2.text = [NSString stringWithFormat:@"%f",mAmount+18];
        
    }else{
        ///支付的金额
        float mAmount = [[NSString stringWithFormat:@"%.2f",[text floatValue]/[[WKAccountManager shareInstance].mRate floatValue]] floatValue];
        self.myTextField2.text = [NSString stringWithFormat:@"%ld",[text integerValue]+18];

        self.myTextField.text = [NSString stringWithFormat:@"%ld",[text integerValue]-18];
        self.myTextField1.text = [NSString stringWithFormat:@"%f",mAmount];
        
    }
    
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mOut forKey:@"sourceCurrencyCode"];
    [para setObject:text forKey:@"sourceAmount"];
    [para setObject:self.mIn forKey:@"targetCurrencyCode"];
    
    [WKNetWorkManager WKGetRemiitablePara:para block:^(id result, BOOL success) {
        if (success) {
            
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
-(void)setMType:(CLHomeViewControllerPushType)mType{
    if (mType == CLHomeViewControllerPushType_Create) {
        [self.exchangeRateButton setTitle:@"汇款" forState:0];
    }else{
        [self.exchangeRateButton setTitle:@"修改" forState:0];
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
          
            TOASTMESSAGE(@"金额只能输入数字!");
            break;
        }
        i++;
    }
    return res;
}




@end
