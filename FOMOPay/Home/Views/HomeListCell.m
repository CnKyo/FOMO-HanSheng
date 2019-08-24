//
//  HomeListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListCollectionCell.h"

@interface HomeListCell()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UIView *valueView;
@property (weak, nonatomic) IBOutlet UIButton *changeCountryButton;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage1;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *showImage1;
@property (weak, nonatomic) IBOutlet UITextField *myTextField1;
@property (weak, nonatomic) IBOutlet UIView *rightView1;
@property (weak, nonatomic) IBOutlet UIView *valueView1;
@property (weak, nonatomic) IBOutlet UIButton *changeCountryButton1;

@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIView *exchangeRateView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage2;
@property (weak, nonatomic) IBOutlet UILabel *unitNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *chinaNameLabel2;
@property (weak, nonatomic) IBOutlet UITextField *myTextField2;
@property (weak, nonatomic) IBOutlet UIView *valueView2;
@property (weak, nonatomic) IBOutlet UIView *amountView;

@property (weak, nonatomic) IBOutlet UIButton *exchangeRateButton;
@property (weak, nonatomic) IBOutlet UIView *CountryView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) NSArray *array1;
@property (nonatomic, strong) NSArray *array2;
@property (nonatomic, strong) NSArray *array3;

@end

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _exchangeRateLabel.text = @"5.01";
    _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
    _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
    
    _logoImage.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2"];
    _logoImage1.image = [UIImage yh_imageNamed:@"pdf_home_transfer_1"];
    _logoImage2.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2"];

    _myTextField.delegate = self;
    _myTextField1.delegate = self;
    _myTextField2.delegate = self;
    [_myTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_myTextField1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_myTextField2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _valueView.layer.borderWidth = 1;
    _valueView.layer.borderColor = kLoginTitleColor.CGColor;

    _valueView1.layer.borderWidth = 1;
    _valueView1.layer.borderColor = kCommonColor(213, 0, 55, 1).CGColor;
    
    _valueView2.layer.borderWidth = 1;
    _valueView2.layer.borderColor = kCommonColor(127, 127, 127, 1).CGColor;
    
    _exchangeRateButton.enabled = NO;
    _exchangeRateButton.layer.cornerRadius = 5.0;
    
    _array1 = @[@"",@"",@"",@"",@"",@""];
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

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag == 4000) {

        if ([textField.text isEqualToString:@"0"]) {
            
            _myTextField1.text = @"0";
            _myTextField2.text = @"0";
            
        }else if (textField.text.length == 0){
            
            _myTextField1.text = nil;
            _myTextField2.text = nil;
            
        }else{
            
            _myTextField1.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*[_exchangeRateLabel.text floatValue]];
            _myTextField2.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*1.2];
        }
    }else if (textField.tag == 4001){
        
        if ([textField.text isEqualToString:@"0"]) {
            
            _myTextField.text = @"0";
            _myTextField2.text = @"0";
            
        }else if (textField.text.length == 0){
            
            _myTextField.text = nil;
            _myTextField2.text = nil;
            
        }else{
            
            _myTextField.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]/[_exchangeRateLabel.text floatValue]];
            _myTextField2.text = [NSString stringWithFormat:@"%.4f",(long)[_myTextField.text floatValue]*1.2];
        }
    }else{
        
        if ([textField.text isEqualToString:@"0"]) {
            
            _myTextField.text = @"0";
            _myTextField1.text = @"0";

        }else if (textField.text.length == 0){
            
            _myTextField.text = nil;
            _myTextField1.text = nil;
            
        }else{
            
            _myTextField.text = [NSString stringWithFormat:@"%.4f",(long)[textField.text floatValue]*0.8];
            _myTextField1.text = [NSString stringWithFormat:@"%.4f",(long)[_myTextField.text floatValue]*[_exchangeRateLabel.text floatValue]];
        }
    }
    
    if (textField.text.length > 0) {
        
        _exchangeRateButton.enabled = YES;
        _exchangeRateButton.backgroundColor = kLoginTitleColor;
        
    }else{
        
        _exchangeRateButton.enabled = NO;
        _exchangeRateButton.backgroundColor = kCommonColor(140, 144, 145, 1);
    }
    
    if (_HomeListCellBlock) {
        
        _HomeListCellBlock(textField.text,textField.tag);
    }
}

- (IBAction)exchangeRateButtonClicked:(UIButton *)sender {
    
    if (_HomeListCellButtonBlock) {
        
        _HomeListCellButtonBlock(_unitNameLabel.text);
    }
}

- (IBAction)showButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        
        if (sender.tag == 1000) {
            
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
            _changeCountryButton1.selected = NO;
            
        }else{
            
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_cell_out"];
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
            _changeCountryButton.selected = NO;
        }
        _CountryView.hidden = NO;
        
    }else{
        
        if (sender.tag == 1000) {
            
            _showImage.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];

        }else{
            
            _showImage1.image = [UIImage yh_imageNamed:@"pdf_home_packUp_icon"];
        }
        _CountryView.hidden = YES;
    }
}

#pragma mark ---- UICollectionViewDataSource ----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
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
    
    cell.iconImage.image = [UIImage yh_imageNamed:_array1[indexPath.row]];
    cell.unitLabel.text = _array2[indexPath.row];
    cell.nameLabel.text = _array3[indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
