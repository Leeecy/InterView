//
//  KSBatteryVertical.h
//  Interview
//
//  Created by kiss on 2020/5/15.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSBatteryVertical : UIView
-(instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num;
/** 线宽 */
@property (nonatomic, assign) CGFloat lineW;
@end

NS_ASSUME_NONNULL_END
