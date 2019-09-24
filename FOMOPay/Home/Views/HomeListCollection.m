//
//  HomeListCollection.m
//  FOMOPay
//
//  Created by Lever on 2019/9/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeListCollection.h"
#import "HomeListCollectionCell.h"
//#import "HomeListCollectionModel.h"
@interface HomeListCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *mDataArr;

@property (nonatomic,strong) UICollectionView *mCollView;
@end

@implementation HomeListCollection

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = ssRGBHex(0xFFFFFF);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    
    layout.minimumInteritemSpacing = 0;
    
    self.mCollView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
//    UICollectionView *mCollView = [UICollectionView new];
    
    self.mCollView.collectionViewLayout = layout;
    
    self.mCollView.backgroundColor = ssRGBHex(0xffffff);
    
    self.mCollView.delegate = self;
    
    self.mCollView.dataSource = self;
    
    self.mCollView.alwaysBounceHorizontal = NO;
    
//    mCollView.scrollEnabled = NO;
    
    [self.mCollView registerNib:[UINib nibWithNibName:@"HomeListCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.mCollView];
    [self loadData];
    [self.mCollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(81);
        make.width.offset(kScreenWidth);
    }];
    
    
//    mCollView.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)mDataArr{
    if(!_mDataArr){
        _mDataArr = [NSMutableArray new];
    }
    return _mDataArr;
}

-(void)loadData{
    NSArray *mLogoArr = @[@"pdf_home_transfer_2"];
    NSArray *mTitleArr = @[@"SGD"];
    NSArray *mNameArr = @[@"(新币)"];
    [self.mDataArr removeAllObjects];
    for(int  i=0;i<mLogoArr.count;i++){
        ForCollection *mItem = [ForCollection new];
        mItem.tag = i;
        mItem.mLogo = mLogoArr[i];
        mItem.mTitle = mTitleArr[i];
        mItem.mName = mNameArr[i];
        
        [self.mDataArr addObject:mItem];
        
    }
    [self.mCollView reloadData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.mDataArr.count;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/2, 82);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(cell ==nil){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }
    ForCollection *mCellmItem =_mDataArr[indexPath.row];
    cell.iconImage.image = [UIImage yh_imageNamed:mCellmItem.mLogo];
    cell.unitLabel.text = mCellmItem.mTitle;
    cell.nameLabel.text = mCellmItem.mName;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ForCollection *mSelect = _mDataArr[indexPath.row];
    DebugLog(@"%@",mSelect);
    if(self.mBlock){
        self.mBlock(mSelect);
    }
}
@end
