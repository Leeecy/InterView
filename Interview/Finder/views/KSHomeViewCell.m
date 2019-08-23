//
//  KSHomeViewCell.m
//  Interview
//
//  Created by kiss on 2019/8/22.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSHomeViewCell.h"

@interface KSHomeViewCell()

@property(nonatomic,strong)UIImageView *lineImage;
@property(nonatomic,strong)UIImageView *sliceImage;
@end

@implementation KSHomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor colorFromHex:@"#191919"];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        if (!_titleL) {
            _titleL = [[UILabel alloc]init];
            _titleL.textAlignment = NSTextAlignmentLeft;
            _titleL.font = CHINESE_SYSTEM(19);
    
            _titleL.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_titleL];
        }
        
        if (!_lineImage) {
            _lineImage = [[UIImageView alloc]init];
            _lineImage.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
             [self.contentView addSubview:_lineImage];
        }
        
        if (!_sliceImage) {
            _sliceImage = [[UIImageView alloc]init];
            _sliceImage.image = [UIImage imageNamed:@"ic_right_arrow"];
            [self.contentView addSubview:_sliceImage];
        }
        
        
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(27);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(100);
        }];
        [_lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(27);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        }];
        [_sliceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(self).offset(-33);
            make.size.mas_equalTo(CGSizeMake(5, 12));
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleL:(UILabel *)titleL{
    _titleL = titleL;
}

@end
