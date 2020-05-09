//
//  CLAddHeaderCollectionCell.m
//  Interview
//
//  Created by cl on 2020/3/16.
//  Copyright © 2020 cl. All rights reserved.
//
//PushTransitionDemo
#import "CLAddHeaderCollectionCell.h"
#import "KSBatteryView.h"
#import "KSBatteryModel.h"
#import "ImageTool.h"
@interface CLAddHeaderCollectionCell()



@property(strong,nonatomic)UIView *batteryView;

@property(nonatomic,strong)UIImageView *leftImageV;
@property(nonatomic,strong)UILabel *leftL;
@property(nonatomic,strong)UIImageView *rightImageV;
@property(nonatomic,strong)UILabel *rightL;
@property(nonatomic,strong)KSBatteryView *batteryleftV;
@property(nonatomic,strong)KSBatteryView *batteryRightV;
@end

@implementation CLAddHeaderCollectionCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    _bgImage = [[UIImageView alloc] init];
    _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [ImageTool cuttingImageView:self.bgImage cuttingDirection:UIRectCornerAllCorners cornerRadii:10 borderWidth:0 borderColor:[UIColor clearColor] backgroundColor:[UIColor clearColor]];
    
    NSString *name = @"mid_bg-1";//
    _bgImage.image = [UIImage imageNamed:@"WechatIMG14"];//mid_bg
    [self addSubview:_bgImage];
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.contentMode = UIViewContentModeScaleAspectFit;
    _headerImg.image = [UIImage imageNamed:@"图层 2566"];
    [self addSubview:_headerImg];
    [_headerImg sizeToFit];
    
    _headerName = [[UILabel alloc]init];
    
    _headerName.textColor = [UIColor blackColor];
    [self addSubview:_headerName];
    
    UIView *batteryV = [[UIView alloc]init];
//    batteryV.backgroundColor = [UIColor greenColor];
    [self addSubview:batteryV];
    self.batteryView = batteryV;
    
    KSBatteryView *battery= [[KSBatteryView alloc]initWithFrame:CGRectMake(0,  7, 12, 7) num:10 isFemale:NO];
//    battery.transform = CGAffineTransformMakeRotation(-M_PI_2);
    battery.transform = CGAffineTransformRotate(battery.transform, -M_PI_2);
    [batteryV addSubview:battery];
    self.batteryleftV = battery;
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(15+2.5, 0, 20, 20)];
    leftImg.image = [UIImage imageNamed:@"组 19"];
    [batteryV addSubview:leftImg];
    self.leftImageV = leftImg;
    UILabel *leftL = [[UILabel alloc]init];
    leftL.textAlignment = NSTextAlignmentLeft;
    leftL.textColor = [UIColor colorFromHexStr:@"#333333"];
    leftL.font = [UIFont systemFontOfSize:10];
    [batteryV addSubview:leftL];
    leftL.text = [[NSString stringWithFormat:@"%d",10] stringByAppendingString:@"%"];
    [leftL sizeToFit];
    self.leftL = leftL;
    
    KSBatteryView *batterR= [[KSBatteryView alloc]initWithFrame:CGRectMake(0,  7, 12, 7) num:10 isFemale:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         batterR.x = CGRectGetMaxX(self.leftL.frame) + 10 ;
    });
   
    //    battery.transform = CGAffineTransformMakeRotation(-M_PI_2);
        batterR.transform = CGAffineTransformRotate(batterR.transform, -M_PI_2);
        [batteryV addSubview:batterR];
    self.batteryRightV = batterR;
    
    UIImageView *rightImg = [[UIImageView alloc]init];
    rightImg.image = [UIImage imageNamed:@"R"];
    [batteryV addSubview:rightImg];
    self.rightImageV = rightImg;
    
    UILabel *rightL = [[UILabel alloc]init];
    rightL.textAlignment = NSTextAlignmentLeft;
    rightL.textColor = [UIColor colorFromHexStr:@"#333333"];
    rightL.font = [UIFont systemFontOfSize:10];
    [batteryV addSubview:rightL];
    rightL.text = [[NSString stringWithFormat:@"%d",10] stringByAppendingString:@"%"];
    [rightL sizeToFit];
    self.rightL = rightL;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];

    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(30);
        make.width.mas_equalTo(self.width* 0.85);
        make.height.mas_equalTo(self.width * 0.75);
    }];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImage.mas_top).offset(-44);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [_headerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgImage.mas_left).offset(10);
        make.top.equalTo(_bgImage.mas_top).offset(50);
    }];
    [self.batteryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerName.mas_bottom).offset(9);
        make.left.equalTo(_headerName.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.width * 0.9 -15*2, 20) );
    }];
    [self.leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageV.mas_centerY);
        make.left.equalTo(self.leftImageV.mas_right).offset(2.5);
    }];
    
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageV.mas_centerY);
        make.left.equalTo(self.batteryRightV.mas_right).offset(2.5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.rightL  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImageV.mas_centerY);
        make.left.equalTo(self.rightImageV.mas_right).offset(2.5);
    }];
}
-(void)setBatteryM:(KSBatteryModel *)batteryM{
    _batteryM = batteryM;
    _headerImg.image = [UIImage imageNamed:batteryM.headerImgName];
    _headerName.text = batteryM.headerImgName;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(cellDidClick:)]) {
        [self.delegate cellDidClick:self];
    }
    NSLog(@"touchesEnded");
}

@end
