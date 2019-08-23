//
//  UIButton+CLRePeat.h
//  suanfa
//
//  Created by cl on 2019/7/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CLRePeat)
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) BOOL isIgnoreEvent; //YES 不允许点击



@end

NS_ASSUME_NONNULL_END
