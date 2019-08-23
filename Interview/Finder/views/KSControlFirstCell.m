//
//  KSControlFirstCell.m
//  Interview
//
//  Created by kiss on 2019/8/22.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSControlFirstCell.h"
@interface KSControlFirstCell()
@property(nonatomic,strong)UIImageView *topLine;
@property(nonatomic,strong)UIImageView *bottomLine;
@property(nonatomic,strong)UIImageView *headImg;
@property(nonatomic,strong)UIImageView *leftImg;
@property(nonatomic,strong)UIImageView *rightImg;
@end

@implementation KSControlFirstCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        if (!_topLine) {
            _topLine = [[UIImageView alloc]init];
            _topLine.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_topLine];
        }
        if (!_bottomLine) {
            _bottomLine = [[UIImageView alloc]init];
            _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_bottomLine];
        }
        if (!_headImg) {
            _headImg = [[UIImageView alloc]init];
            _headImg.backgroundColor = [UIColor colorWithHexString:@"#BFBFBF"];
            [self.contentView addSubview:_headImg];
        }
        
        if (!_leftImg) {
            _leftImg = [[UIImageView alloc]init];
            _leftImg.image = [UIImage imageNamed:@"ic_lettle"];
            [self.contentView addSubview:_leftImg];
        }
        if (!_rightImg) {
            _rightImg = [[UIImageView alloc]init];
            _rightImg.image = [UIImage imageNamed:@"ic_right_selected"];
            [self.contentView addSubview:_rightImg];
        }
        
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(27);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(1);
            make.top.equalTo(self.contentView.mas_top).offset(0);
        }];
        
        
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(33);
            make.right.mas_equalTo(self).offset(-33);
            make.size.mas_equalTo(CGSizeMake(304, 218));
            make.top.equalTo(self.contentView.mas_top).offset(162);
        }];
        
        [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(72);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.top.equalTo(self.headImg.mas_bottom).offset(30);
        }];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).offset(-72);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            make.top.equalTo(self.leftImg);
        }];
        
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(27);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(1);
            make.top.equalTo(self.rightImg.mas_bottom).offset(13);
        }];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)cellHeight{
    return ScreenHeight - 60*4 -SafeAreaTopHeight;
}

@end
