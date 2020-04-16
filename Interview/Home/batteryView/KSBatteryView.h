//
//  KSBatteryView.h
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSBatteryView : UIView
-(instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num isFemale:(BOOL)isFemale;
/** 线宽 */
@property (nonatomic, assign) CGFloat lineW;


@end

NS_ASSUME_NONNULL_END
