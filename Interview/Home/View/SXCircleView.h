//
//  SXCircleView.h
//  TestCircle
//
//  Created by cl on 2019/7/25.
//  Copyright © 2019 KSB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXCircleView : UIControl
////返回Yes表示要继续跟踪触摸事件
//- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
////解决滑动改变的问题
//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event;
-(id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth circleAngle:(CGFloat)circleAngle productModel:(NSString *)model imageWidth:(CGFloat)imgWidth;

@property (nonatomic,setter=changeAngle:) int angle;

@property (nonatomic,copy) void (^angleChange)(int angle);


@end

NS_ASSUME_NONNULL_END
