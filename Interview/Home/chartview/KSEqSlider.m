//
//  KSEqSlider.m
//  FastPair
//
//  Created by kiss on 2019/10/25.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSEqSlider.h"
#import "KSColorBgButton.h"
#define sliderThumbBound_x 10
#define sliderThumbBound_y 20

@interface KSEqSlider()
@property(nonatomic, assign) CGRect lastBounds;

@end

@implementation KSEqSlider

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self setup];
        // 创建自控制器
        [self setupSubViews];
        // 布局子控件
//        [self _makeSubViewsConstraints];
    }
    return self;
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    if (begin) {
        self.sliderValueLabel.hidden = NO;
        self.btn.hidden = NO;
        if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
            [self.delegate currentValueOfSlider:self];
        }
        if ([self.delegate respondsToSelector:@selector(beginSwip)]) {
            [self.delegate beginSwip];
        }
    }
    return begin;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    BOOL continueTrack = [super continueTrackingWithTouch:touch withEvent:event];
    if (continueTrack) {
        if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
            [self.delegate currentValueOfSlider:self];
        }
    }
    return continueTrack;
}
- (void)cancelTrackingWithEvent:(UIEvent *)event{
    [super cancelTrackingWithEvent:event];
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    if ([self.delegate respondsToSelector:@selector(currentValueOfSlider:)]) {
        [self.delegate currentValueOfSlider:self];
    }
    if ([self.delegate respondsToSelector:@selector(endSwipValue:Tag:)]) {
        [self.delegate endSwipValue:self.value Tag:self.tag];
    }
    self.sliderValueLabel.hidden = YES;
    self.btn.hidden = YES;
}

-(void)setIsShowTitle:(BOOL)isShowTitle{
    _isShowTitle = isShowTitle;
    
    if (_isShowTitle == YES) {
        //滑块的响应事件
        [self addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        self.continuous = YES;// 设置可连续变化
        
        self.btn = [KSColorBgButton buttonWithType:UIButtonTypeCustom];
        self.btn.hidden = YES;
        self.btn.titleLabel.font = [UIFont systemFontOfSize:11];
        NSString *title = [NSString stringWithFormat:@"%.fdb", self.value];
        self.btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.btn setTitle:title forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor colorFromHexStr:@"#9D9D9D"] forState:(UIControlStateNormal)];
        self.btn.transform = CGAffineTransformMakeRotation(1.57079633);
        [self addSubview:self.btn];
        self.btn.directionType = HVGradientDirectionHor;
        
//     UIControlStateNormal 状态渐变背景，渐变背景优先级大于纯色背景，所以，UIControlStateNormal 下会显示渐变色背景，而不是纯色背景
       
        self.btn.cornerRadius = 3;
        self.btn.borderWidth = 4;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *slideImage = (UIImageView *)[self.subviews lastObject];
//                        NSLog(@"subviews=%@",self.subviews);
            for (UIView *sub in self.subviews) {
                if ([sub isKindOfClass:[UIButton class]]) {
               
                    [self insertSubview:sub aboveSubview:self.subviews.lastObject];
                }
            }

            [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.titleStyle == KSEqTopTitleStyle) {
                               make.bottom.mas_equalTo(slideImage.mas_top).offset(15);
                               
                           }else{
                               make.top.mas_equalTo(slideImage.mas_bottom).offset(5);
                           }
                           make.height.mas_equalTo(18);
                           make.width.mas_equalTo(36);
//                           make.centerX.equalTo(self).offset(EQSliderHeight*0.5 +25);
                            
                        make.centerX.equalTo(slideImage).offset(35);
                           
                       }];
            
            [self.btn setGradientColor:[KSGradientColor gradientColorWithColors:@[[UIColor colorWithHexString:@"#393939"],[UIColor colorWithHexString:@"#393939"]]]
                                forState:UIControlStateNormal];
      
        });
        
    }
}
- (void)sliderAction:(UISlider*)slider{
    //    //滑块的值
    self.sliderValueLabel.text = [NSString stringWithFormat:@"%.fdb", self.value];
    NSString *title = [NSString stringWithFormat:@"%.fdb", self.value];
          
    [self.btn setTitle:title forState:UIControlStateNormal];
//     CGPoint  point=CGPointMake(slider.frame.size.width*slider.value*0.025, 10);
//    UIColor* color= [self colorOfPoint:point];
//    if (slider.value < 12) {
//        [self.btn setGradientColor:[KSGradientColor gradientColorWithColors:@[color,[UIColor colorWithHexString:@"#EE3A07"]]]
//        forState:UIControlStateNormal];
//    }
}
-(void)setSliderValue:(int )sliderValue{
    _sliderValue = sliderValue;
     NSString *title = [NSString stringWithFormat:@"%ddb", sliderValue];
     [self.btn setTitle:title forState:UIControlStateNormal];
}

- (void)setup{
    self.minimumValue = -7;
    self.maximumValue = 7;
    self.maximumTrackTintColor = [UIColor colorWithHexString:@"#2E2E2E"];
    self.minimumTrackTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
}
-(void)setupSubViews{
         UIImage *norImage = [UIImage imageNamed:@"圆形 (1)"];
        [self setThumbImage:[self OriginImage:norImage scaleToSize:CGSizeMake(15, 15)] forState:UIControlStateNormal];
}
//改变slider粗细的
- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect minimumValueImageRect = [self minimumValueImageRectForBounds:bounds];
    CGRect maximumValueImageRect = [self maximumValueImageRectForBounds:bounds];
    CGFloat margin = 2;
    CGFloat H = 1;
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat X = CGRectGetMaxX(minimumValueImageRect) + margin;
    CGFloat W = CGRectGetMinX(maximumValueImageRect) - X - margin;
//     NSLog(@"bounds==%@",NSStringFromCGRect(bounds));
    return CGRectMake(0, 0, EQSliderHeight, H);
}

-(CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    //y轴方向改变手势范围
    rect.origin.x = rect.origin.x - 10;
    rect.size.width = rect.size.width +20;

    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
    _lastBounds = result;
    return result;
}
////解决滑块不灵敏
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width){

        return result;

    }
    if ((point.y >= -sliderThumbBound_y) && (point.y < _lastBounds.size.height + sliderThumbBound_y)) {
        float value = 0.0;
        value = point.x - self.bounds.origin.x;
        value = value/self.bounds.size.width;

        value = value < 0? 0 : value;
        value = value > 1? 1: value;

        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self setValue:value animated:YES];
    }
    return result;

}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _lastBounds.origin.x - sliderThumbBound_x) && (point.x <= (_lastBounds.origin.x + _lastBounds.size.width + sliderThumbBound_x)) && (point.y < (_lastBounds.size.height + sliderThumbBound_y))) {
            result = YES;
        }

    }
    return result;
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
