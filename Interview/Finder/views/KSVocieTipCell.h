//
//  KSVocieTipCell.h
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSBaseViewCell.h"

#define kCellIdentifier_KSVocieTipCell @"KSVocieTipCell"

NS_ASSUME_NONNULL_BEGIN

@interface KSVocieTipCell : KSBaseViewCell
-(void)setTitle:(NSString*)title andDetail:(NSString*)detail;
@property (nonatomic,copy) void (^switchValueChanged)(BOOL isOn);
@property(strong,nonatomic)UISwitch *aswitch;
+ (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
