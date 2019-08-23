//
//  HoverViewFlowLayout.h
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoverViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat      topHeight;

- (instancetype)initWithTopHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
