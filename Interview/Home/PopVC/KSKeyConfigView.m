//
//  KSKeyConfigView.m
//  Interview
//
//  Created by kiss on 2020/1/2.
//  Copyright © 2020 cl. All rights reserved.
//

#import "KSKeyConfigView.h"

@interface KSKeyConfigView()
@property(nonatomic,strong) UIView * contentView;
@end

@implementation KSKeyConfigView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + SafeAreaTopHeight, ScreenWidth, ScreenHeight)];
       contentView.backgroundColor = [UIColor whiteColor];
       [self addSubview:contentView];
       self.contentView = contentView;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
       maskLayer.frame = contentView.bounds;
       maskLayer.path = maskPath.CGPath;
       contentView.layer.mask = maskLayer;
    }
    return self;
}

@end
