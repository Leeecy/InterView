//
//  MKVerticalSlider.h
//  MKSlider
//
//  Created by Make on 2019/1/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    RightTitleStyle,
    BottomTitleStyle,
    TopTitleStyle
}TitleStyle;

NS_ASSUME_NONNULL_BEGIN

@interface GQYVerticalSlider : UIView


@property (nonatomic,strong)UIImage * minImage;
@property (nonatomic,strong)UIImage * maxImage;
@property (nonatomic,strong)UIImage * thumbImage;


@property(nonatomic) float value;  // default 0.0. this value will be pinned to min/max
@property(nonatomic) float minimumValue;  // default 0.0. the current value may change if outside new min value
@property(nonatomic) float maximumValue;  // default 1.0. the current value may change if outside new max value


@property (nonatomic,copy)void (^touchSliderValueChange)(CGFloat value, BOOL isChangeEnd ,NSInteger tag);



- (void)setValue:(float)value animated:(BOOL)animated;

@property (nonatomic,assign) BOOL isShowTitle;
@property (nonatomic,assign) TitleStyle titleStyle;
@property(nonatomic, strong) UILabel *sliderValueLabel;

@end

NS_ASSUME_NONNULL_END
