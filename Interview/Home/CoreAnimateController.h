//
//  CoreAnimateController.h
//  suanfa
//
//  Created by cl on 2019/7/18.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreAnimateController : UIViewController

@end

NS_ASSUME_NONNULL_END

@interface GKLineLoadingView : UIView

+ (void)showLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight;

+ (void)hideLoadingInView:(UIView *)view;

@end

@interface CircleView : UIView
@property(assign,nonatomic)CGFloat startValue;
@property(assign,nonatomic)CGFloat lineWidth;
@property(assign,nonatomic)CGFloat value;
@property(strong,nonatomic)UIColor *lineColr;
//进度 [0...1]
@property(nonatomic,assign) CGFloat progress;

@end

