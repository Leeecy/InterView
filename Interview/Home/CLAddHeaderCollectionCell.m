//
//  CLAddHeaderCollectionCell.m
//  Interview
//
//  Created by cl on 2020/3/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import "CLAddHeaderCollectionCell.h"

@interface CLAddHeaderCollectionCell()
@property (strong , nonatomic)UIImageView *bgImage;
@property(strong,nonatomic)UIImageView *headerImg;
@property(strong,nonatomic)UILabel *headerName;
@property(strong,nonatomic)UIView *batteryView;
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
    _bgImage.contentMode = UIViewContentModeScaleToFill;
    _bgImage.image = [UIImage imageNamed:@"圆角矩形 4 拷贝 6"];
    [self addSubview:_bgImage];
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.contentMode = UIViewContentModeScaleToFill;
    _headerImg.image = [UIImage imageNamed:@"图层 2530 拷贝"];
    [self addSubview:_headerImg];
    
    _headerName = [[UILabel alloc]init];
    _headerName.text = @"TE-D01G";
    _headerName.textColor = [UIColor blackColor];
    [self addSubview:_headerName];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];

    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(30);
        make.width.mas_equalTo(self).multipliedBy(0.7);
        make.height.mas_equalTo(self.width * 0.7);
    }];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImage.mas_top).offset(-22);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 44));
    }];
    [_headerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgImage.mas_left).offset(10);
        make.top.equalTo(_bgImage.mas_top).offset(50);
    }];
}
@end
