//
//  SliderView.h
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OnTabTapActionDelegate

@required
- (void)onTabTapAction:(NSInteger)index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SliderView : UIView
@property (nonatomic, weak) id <OnTabTapActionDelegate> delegate;

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;
@end

NS_ASSUME_NONNULL_END
