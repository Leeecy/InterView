//
//  SOTrackingSlider.m
//  SOSlider
//
//  Created by wangli on 2017/3/30.
//  Copyright © 2017年 wangli. All rights reserved.
//

#import "SOTrackingSlider.h"

@interface SOTrackingSlider ()

/*! @brief slider的thumbView */
@property (nonatomic, strong) UIView *thumbView;
@property(nonatomic, strong) UILabel *sliderValueLabel;//滑块下面的值
@end

@implementation SOTrackingSlider

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        

    }
    return self;
}

#pragma mark - subclassed
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    if (begin) {
        if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
            [self.delegate currentValueOfSlider:self];
        }
        if ([self.delegate respondsToSelector:@selector(beginSwipSlider:)]) {
            [self.delegate beginSwipSlider:self];
        }
    }
    return begin;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL continueTrack = [super continueTrackingWithTouch:touch withEvent:event];
    if (continueTrack) {
        if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
            [self.delegate currentValueOfSlider:self];
        }
    }
    return continueTrack;
}
- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
        [self.delegate currentValueOfSlider:self];
    }
    if ([self.delegate respondsToSelector:@selector(endSwipSlider:)]) {
        [self.delegate endSwipSlider:self];
    }
}

-(void)setIsShowTitle:(BOOL)isShowTitle{
    _isShowTitle = isShowTitle;
    
    if (_isShowTitle == YES) {
        //滑块的响应事件
        [self addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        self.continuous = YES;// 设置可连续变化
        
        // 当前值label
        self.sliderValueLabel = [[UILabel alloc] init];
        self.sliderValueLabel.textAlignment = NSTextAlignmentCenter;
        self.sliderValueLabel.backgroundColor = [UIColor redColor];
        self.sliderValueLabel.font = [UIFont systemFontOfSize:14];
        self.sliderValueLabel.textColor = [UIColor orangeColor];
        self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f", self.value];
         self.sliderValueLabel.transform = CGAffineTransformMakeRotation(1.57079633);
        [self addSubview:self.sliderValueLabel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *slideImage = (UIImageView *)[self.subviews lastObject];
            NSLog(@"subviews=%@",self.subviews);
            
            //滑块的值
            [self.sliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.titleStyle == TopTitleStyle) {
                    make.bottom.mas_equalTo(slideImage.mas_top).offset(15);
                    
                }else{
                    make.top.mas_equalTo(slideImage.mas_bottom).offset(5);
                }
                make.width.mas_equalTo(45);
                make.centerX.equalTo(slideImage).offset(30);
                
            }];
        });
    }
}
- (void)sliderAction:(UISlider*)slider{
    //    //滑块的值
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.f%%", self.value];
    NSLog(@"sliderValueLabel==%@",self.sliderValueLabel.text);
}




@end
