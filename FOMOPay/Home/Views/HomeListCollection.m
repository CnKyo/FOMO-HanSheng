//
//  HomeListCollection.m
//  FOMOPay
//
//  Created by Lever on 2019/9/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeListCollection.h"
#import "HomeListCollectionCell.h"
@interface HomeListCollection ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HomeListCollection

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView *mCollView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    
//    mCollView.collectionViewLayout = layout;
    
    mCollView.delegate = self;
    
    mCollView.dataSource = self;
    
    [mCollView registerNib:[UINib nibWithNibName:@"HomeListCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
//    mCollView.backgroundColor = [UIColor redColor];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/2, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if(cell ==nil){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
