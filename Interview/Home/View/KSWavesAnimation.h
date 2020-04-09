//
//  KSWavesAnimation.h
//  FastPair
//
//  Created by cl on 2019/7/24.
//  Copyright © 2019 KSB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSWavesAnimation : UIView
//进度值0-1.0之间
@property (nonatomic,assign)CGFloat progressValue;
-(void)stop;
@end

NS_ASSUME_NONNULL_END
