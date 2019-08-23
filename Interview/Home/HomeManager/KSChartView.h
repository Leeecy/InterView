//
//  KSChartView.h
//  TestCircle
//
//  Created by cl on 2019/7/29.
//  Copyright © 2019 KSB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KSChartViewDelegate <NSObject>

-(void)sendValue:(CGFloat)value andTag:(NSInteger)tag;

@end

@interface KSChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame values:(NSArray *)values curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding;

- (void)drawGraphWithValues:(NSArray *)values minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor;

@property(nonatomic,strong)UIView *subView;


@property (nonatomic , assign)id <KSChartViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
