//
//  KSControlViewCell.m
//  Interview
//
//  Created by kiss on 2019/8/22.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSControlViewCell.h"

@interface KSControlViewCell()
@property(nonatomic,strong)UIImageView *lineImg;
@property(nonatomic,strong)UIImageView *midImg;
@property(nonatomic,strong)UILabel *headName;
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UIImageView *rightImg;
@end

@implementation KSControlViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        if (!_lineImg) {
            _lineImg = [[UIImageView alloc]init];
            _lineImg.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_lineImg];
        }
        if (!_midImg) {
            _midImg = [[UIImageView alloc]init];
            _midImg.image = [UIImage imageNamed:@"ic_little_dot_selected"];
            [self.contentView addSubview:_midImg];
        }
        if (!_headName) {
            _headName = [[UILabel alloc]init];
            _headName.text = @"SINGLECLICK";
            _headName.textAlignment = NSTextAlignmentLeft;
            _headName.font = CHINESE_SYSTEM(15);
            _headName.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_headName];
        }
        
        
        
        [_lineImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(27);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        
        [_midImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(13, 13));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-13);
        }];
        
        
        [_headName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.bottom.equalTo(self.midImg.mas_top).offset(-8);
        }];
        
        
    }
    return self;
}


@end
