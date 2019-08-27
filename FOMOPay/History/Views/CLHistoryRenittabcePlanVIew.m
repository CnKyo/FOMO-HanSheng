//
//  CLHistoryRenittabcePlanCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRenittabcePlanView.h"
static dispatch_once_t disOncePortrait;
@interface  CLHistoryRenittabcePlanView()
//记录数量
@property(nonatomic,assign)NSInteger Count ;
//背景线
@property(nonatomic,strong)UIView * bgLinkView ;
//进度线
@property(nonatomic,strong)UIView * progressLinkView ;
//文字点数组
@property(nonatomic,strong)NSMutableArray * titleArr ;
@end
@implementation CLHistoryRenittabcePlanView

//-(instancetype)initWithFrame:(CGRect)frame setDirection:(BOOL)Direction setCount:(NSInteger)Count{
-(instancetype)initsetCount:(NSInteger)Count{
    if (([super init])) {
        if(Count>2){
        self.Count = Count;
            DebugLog(@"count%ld",(long)self.Count);
        _bgLinkView = [[UIView alloc]init];
        _bgLinkView.backgroundColor  = ssRGBAlpha(170, 170, 170, 0.7);
        [self addSubview:self.bgLinkView];
        
        _progressLinkView = [[UIView alloc]init];
        _progressLinkView.backgroundColor = ssRGBAlpha(38, 161, 99, 1.0);
        [self addSubview:self.progressLinkView];
       
        for (int i=0; i<Count; i++) {
            UILabel * titleLabel = [[UILabel alloc]init];
            titleLabel.backgroundColor = ssRGBHex(0x005CB6);
            titleLabel.frame =CGRectMake(0, 0, spotWH, spotWH);
            titleLabel.layer.cornerRadius = spotWH/2 ;
            titleLabel.clipsToBounds = YES ;
            titleLabel.tag = i ;
            titleLabel.font = [UIFont systemFontOfSize:titleFont] ;
            titleLabel.textAlignment = 1 ;
           
            [self addSubview:titleLabel];
            [self.titleArr addObject:titleLabel];
        }
    }else{//数量不够两个时
        
        //纵向
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((self.bounds.size.width-30)/2, 0, 30, self.bounds.size.height)];
        title.textColor = ssRGBAlpha(102, 102, 102, 1.0) ;
        title.textAlignment = 1 ;
        title.numberOfLines = 0 ;
        title.font = [UIFont systemFontOfSize:15] ;
        title.text = @"请把数量设置在两个或者两个以上" ;
        [self addSubview:title];
    }
    
}
return self ;
}


- (void)layoutSubviews{
    
    //纵向
    self.bgLinkView.frame = CGRectMake((self.bounds.size.width-linkWH)/2, space, linkWH, self.bounds.size.height-space*2);
    for (int i=0; i<self.Count; i++) {
        UILabel * titleLab = self.titleArr[i];
        titleLab.center = CGPointMake(self.bgLinkView.center.x, space+(self.bounds.size.height-space*2)/(self.Count-1)*i);
    }
    
    dispatch_once(&disOncePortrait,^ {
        [self setTitleContent:self.PortraitRecordIndex];
    });
    
    self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
}

-(void)changPortraitLinkViewAnimations{
    [UIView animateWithDuration:0.4 animations:^{
        self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
    }completion:^(BOOL finished) {
        [self setTitleContent:self.PortraitRecordIndex];
    }];
}

-(void)setTitleContent:(NSInteger)index{
    for (int i=0; i<self.Count; i++) {
        if (index==i) { //当前状态
            UILabel * changTitle = self.titleArr[index] ;
//            changTitle.text = [NSString stringWithFormat:@"%ld",index+1] ;
//            changTitle.layer.borderWidth = 1 ;
//            changTitle.layer.borderColor = ssRGBAlpha(102, 102, 102, 1.0).CGColor ;
            changTitle.backgroundColor = ssRGBHex(0x005CB6); ;
            [UIView animateWithDuration:0.2 animations:^{
                changTitle.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
            
        }else{//恢复状态
            UILabel * titleLab = self.titleArr[i];
            titleLab.backgroundColor = ssRGBAlpha(102, 102, 102, 1.0) ;
            titleLab.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }
}

//数组
-(NSMutableArray * )titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:self.Count] ;
    }
    return _titleArr ;
}

#pragma mark--上一步
-(void)lastStep{
    //纵
    if (self.PortraitRecordIndex==0) return ;
    self.PortraitRecordIndex-- ;
    [self changPortraitLinkViewAnimations];
}


#pragma mark--下一步
-(void)nextStep{
    
    if (self.PortraitRecordIndex==self.Count-1) return ;
    self.PortraitRecordIndex++ ;
    [self changPortraitLinkViewAnimations];
}

@end
