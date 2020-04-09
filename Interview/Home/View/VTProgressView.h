//
//  VTProgressView.h
//  VTUpdate
//
//  Created by kiss on 2019/11/21.
//  Copyright © 2019 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTProgressView : UIView
-(instancetype)initWithFrame:(CGRect)frame ;
- (void)setProgress:(float)progress animated:(BOOL)animated;
- (void)close;

@end

NS_ASSUME_NONNULL_END
