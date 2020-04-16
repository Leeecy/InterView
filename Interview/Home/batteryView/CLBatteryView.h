//
//  CLBatteryView.h
//  Interview
//
//  Created by kiss on 2020/4/15.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BatteryState) {
    BatteryStateNormal = 0,     //  正常状态
    BatteryStateCharging = 1,   //  充电状态
};

typedef NS_ENUM(NSInteger,TextStyle) {
    TextStyleHide = 0,     //  正常状态
    TextStyleTop = 1,     //  正常状态
    TextStyleBottom = 2,   //  充电状态
};
NS_ASSUME_NONNULL_BEGIN

@interface CLBatteryView : UIView
@property (nonatomic ,assign) BatteryState batteryState;
@property (nonatomic ,assign) TextStyle textStyle;
@end

NS_ASSUME_NONNULL_END
