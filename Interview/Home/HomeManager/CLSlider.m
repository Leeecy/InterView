//
//  CLSlider.m
//  Interview
//
//  Created by kiss on 2019/10/25.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLSlider.h"

@implementation CLSlider
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化
        [self _setup];
        
        // 创建自控制器
        [self _setupSubViews];
        
        // 布局子控件
//        [self _makeSubViewsConstraints];
    }
    return self;
}
- (void)_setup{
    self.minimumValue = -12;
    self.maximumValue = 30;
}
- (void)_setupSubViews{
//     UIImage *norImage = [UIImage imageNamed:@"slider_bg"];
//    [self setThumbImage:norImage forState:UIControlStateNormal];
}
- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect minimumValueImageRect = [self minimumValueImageRectForBounds:bounds];
    CGRect maximumValueImageRect = [self maximumValueImageRectForBounds:bounds];
    CGFloat margin = 2;
    CGFloat H = 1;
    CGFloat Y =( bounds.size.height - H ) *.5f;
    CGFloat X = CGRectGetMaxX(minimumValueImageRect) + margin;
    CGFloat W = CGRectGetMinX(maximumValueImageRect) - X - margin;
//     NSLog(@"bounds==%@",NSStringFromCGRect(bounds));
    return CGRectMake(0, 0, 300, H);
}

/// 设置thumb（滑块）尺寸
//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
//
//    
//    rect.origin.x = rect.origin.x - 10 ;
//    rect.size.width = rect.size.width +20;
//
//    CGRect result = [super thumbRectForBounds:bounds trackRect:rect value:value];
//
//    return CGRectInset (result, 1 ,0);
//    
//}

@end
