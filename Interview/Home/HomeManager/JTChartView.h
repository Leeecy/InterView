//
//  JTChartView.h
//  JTChartView
//
//  Created by Jakub Truhlar on 01.07.15.
//  Copyright (c) 2015 Jakub Truhlar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sliderProtocol <NSObject>


-(void)sendValue:(UISlider *)slider;


@end


@interface JTChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame values:(NSArray *)values curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding;

- (void)drawGraphWithValues:(NSArray *)values minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor;

@property(nonatomic,strong)UIView *subView;

@property(nonatomic,weak)id<sliderProtocol>delegate;

@end
