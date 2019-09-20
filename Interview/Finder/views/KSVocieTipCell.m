//
//  KSVocieTipCell.m
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSVocieTipCell.h"

@interface KSVocieTipCell()

@property (strong, nonatomic) UILabel *nameL;

@property(nonatomic,strong)UIImageView *tipImg;
@property (strong, nonatomic) UILabel *tipL;
@end

@implementation KSVocieTipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!_nameL) {
        _nameL  = [[UILabel alloc]init];
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.font = [UIFont systemFontOfSize:16];
        _nameL.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.contentView addSubview:_nameL];
    }
    if (!_tipImg) {
        _tipImg = [[UIImageView alloc]init];
        _tipImg.image = [UIImage imageNamed:@"ic_tips"];
        [self.contentView addSubview:_tipImg];
    }
    
    
    if (!_tipL) {
        _tipL  = [[UILabel alloc]init];
        _tipL.textAlignment = NSTextAlignmentLeft;
        _tipL.font = [UIFont systemFontOfSize:9];
        _tipL.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_tipL];
    }
    
    if (!_aswitch) {
        _aswitch = [[UISwitch alloc]init];
        _aswitch.centerY = 31;
//        NSLog(@"%f",self.height);
        _aswitch.x = ScreenWidth - _aswitch.width - 15;
        _aswitch.onTintColor = [UIColor orangeColor];
        [_aswitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_aswitch];
    }
   
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(17);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(140);
    }];
    
    [_tipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameL);
        make.top.equalTo(self.nameL.mas_bottom).offset(6);
        make.height.mas_equalTo(9);
        make.width.mas_equalTo(9);
    }];
    
    [_tipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipImg.mas_right).offset(2);
        make.centerY.equalTo(self.tipImg.mas_centerY);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(210);
    }];
    
    
   
    return self;
}

-(void)setTitle:(NSString*)title andDetail:(NSString*)detail{
    _nameL.text = title;
    _tipL.text = detail;
}

- (void)switchTouched:(UISwitch *)sw{
    self.aswitch.userInteractionEnabled = NO;
    //    __weak typeof(self) weakSelf = self;
    if (self.switchValueChanged) {
        self.switchValueChanged(sw.isOn);
    }
    
}

+ (CGFloat)cellHeight{
    return 62.0;
}
@end
