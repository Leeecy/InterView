//
//  TransViewCell.m
//  Interview
//
//  Created by kiss on 2020/4/22.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TransViewCell.h"
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_WHITE [UIColor whiteColor]
#define FONT_B(x)   [UIFont boldSystemFontOfSize:x]
#define FONT_PF(x)      [UIFont fontWithName:@"PingFangSC-Light" size:x]
@implementation TransViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = COLOR_CLEAR;
        self.contentView.backgroundColor = COLOR_CLEAR;
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.bgimageView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.contentLabel];
        
    }
    return self;
}
- (UIImageView *)bgimageView {
    if (_bgimageView == nil) {
        _bgimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-40, (ScreenWidth-40)*1.3)];
        _bgimageView.layer.cornerRadius = 15;
        _bgimageView.layer.masksToBounds = YES;
        
    }
    return _bgimageView;
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-40, (ScreenWidth-40)*1.3+25)];
        
        _bgView.backgroundColor = COLOR_CLEAR;
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 30)];
        _titleLabel.textColor = COLOR_WHITE;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = FONT_B(25);
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, (ScreenWidth-40)*1.3-30, ScreenWidth-44, 15)];
        _contentLabel.font = FONT_PF(15);
        _contentLabel.alpha = 0.5;
        _contentLabel.textColor = COLOR_WHITE;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLabel;
}

@end
