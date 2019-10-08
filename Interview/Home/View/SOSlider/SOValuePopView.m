//
//  SOValuePopView.m
//  SOSlider
//
//  Created by wangli on 2017/3/30.
//  Copyright © 2017年 wangli. All rights reserved.
//

#import "SOValuePopView.h"

@implementation SOValuePopView{
    UILabel *valueLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        valueLabel = [[UILabel alloc] initWithFrame:frame];
        valueLabel.textColor = [UIColor redColor];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.text = @"0.5";
        valueLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:valueLabel];
    }
    return self;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    valueLabel.font = font;
}
- (void)setText:(NSString *)text{
    _text = text;
    valueLabel.text = text;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    valueLabel.textColor = textColor;
}

@end
