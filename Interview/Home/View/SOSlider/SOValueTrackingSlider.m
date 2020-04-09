//
//  SOValueTrackingSlider.m
//  SOSlider
//
//  Created by wangli on 2017/3/30.
//  Copyright © 2017年 wangli. All rights reserved.
//

#import "SOValueTrackingSlider.h"
#import "SOValuePopView.h"
#import "SOTrackingSlider.h"
@interface SOValueTrackingSlider()<SOTrackingSliderDelegate>

@property (nonatomic, strong) SOValuePopView *valuePopView;
@property (nonatomic, strong) SOTrackingSlider *uiSlider;
@end

@implementation SOValueTrackingSlider

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpWithFrame:frame];
    }
    return self;
}
- (void)setUpWithFrame:(CGRect)frame{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    _numberFormatter = formatter;
    self.valuePopView = [[SOValuePopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.valuePopView.textColor = [UIColor redColor];
//    self.valuePopView.backgroundColor = [UIColor redColor];
    [self addSubview:self.valuePopView];
    _uiSlider = [[SOTrackingSlider alloc] initWithFrame:CGRectMake(20, 0, frame.size.width - 20, 10)];
    _uiSlider.delegate = self;
     UIImage *norImage = [UIImage imageNamed:@"滑块"];
    [_uiSlider setThumbImage:[self OriginImage:norImage scaleToSize:CGSizeMake(43, 17)] forState:UIControlStateNormal];
    
 
    _uiSlider.isShowTitle = YES;
    _uiSlider.titleStyle = TopTitleStyle;
    _uiSlider.minimumValue = 0;
    _uiSlider.maximumValue = 100;
    _uiSlider.value = 0;
    [self addSubview:_uiSlider];
}

- (void)currentValueOfSlider:(SOTrackingSlider *)slider{
    [self.valuePopView setText:[_numberFormatter stringFromNumber:@(slider.value)]];
}
- (void)beginSwipSlider:(SOTrackingSlider *)slider{
    if ([self.delegate respondsToSelector:@selector(beginSwip)]) {
        [self.delegate beginSwip];
    }
}
- (void)endSwipSlider:(SOTrackingSlider *)slider{
    if ([self.delegate respondsToSelector:@selector(endSwip)]) {
        [self.delegate endSwip];
    }
}
- (void)setIsVertical:(BOOL)isVertical{
    _isVertical = isVertical;
    if (_isVertical == YES) {
        self.uiSlider.transform = CGAffineTransformMakeRotation(-1.57079633);
        self.valuePopView.center = CGPointMake(self.uiSlider.center.x, self.uiSlider.center.y - self.uiSlider.frame.size.height/2 - self.valuePopView.frame.size.height/2 );
    }else{
        
    }
}
- (void)setNumberFormatter:(NSNumberFormatter *)numberFormatter
{
    _numberFormatter = numberFormatter;
}
- (void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    _uiSlider.minimumValue = minValue;
}
- (void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    _uiSlider.maximumValue = maxValue;
}
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor{
    _minimumTrackTintColor = minimumTrackTintColor;
    _uiSlider.minimumTrackTintColor = minimumTrackTintColor;
}
- (void)setMaxmumTrackTintColor:(UIColor *)maxmumTrackTintColor{
    _maxmumTrackTintColor = maxmumTrackTintColor;
    _uiSlider.maximumTrackTintColor = maxmumTrackTintColor;
}
- (void)setFont:(UIFont *)font{
    _font = font;
    [_valuePopView setFont:font];
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_valuePopView setTextColor:textColor];
}
// 解决在UIScrollView中滑动冲突的问题
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return CGRectContainsPoint(self.uiSlider.frame, point);
}

-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size{
      if([[UIScreen mainScreen] scale] == 2.0) {
             UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
         } else {
             UIGraphicsBeginImageContext(size);
         }
       UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}
@end
