//
//  CLChartView.h
//  Interview
//
//  Created by kiss on 2019/12/26.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CLChartViewDelegate <NSObject>

-(void)sendValue:(CGFloat)value andTag:(NSInteger)tag;
//滑动结束才设置EQ的值
-(void)moveEnd:(CGFloat)value tag:(NSInteger)tag;

@end
@interface CLChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame values:(NSArray *)values curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding;

- (void)drawGraphWithValues:(NSArray *)values minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor;

@property(nonatomic,strong)UIView *subView;


@property (nonatomic , assign)id <CLChartViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
