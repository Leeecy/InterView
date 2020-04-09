//
//  KSSegmentEqView.h
//  Interview
//
//  Created by kiss on 2019/10/23.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSSegmentEqView : UIView

@property(nonatomic,copy)void (^segmentClickBlock)(NSInteger index);

-(instancetype)initWithSegmentedTitles:(NSArray *)titles;

-(void)sliderToCurrentSelectedIndex:(NSInteger )index;

@end

NS_ASSUME_NONNULL_END
