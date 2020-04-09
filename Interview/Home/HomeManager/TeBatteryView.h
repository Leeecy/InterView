//
//  TeBatteryView.h
//  TeviPair
//
//  Created by kiss on 2019/10/23.
//  Copyright © 2019 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeBatteryView : UIView
-(instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num;
/** 线宽 */
@property (nonatomic, assign) CGFloat lineW;

@end

NS_ASSUME_NONNULL_END
