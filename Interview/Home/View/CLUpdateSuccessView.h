//
//  CLUpdateSuccessView.h
//  Interview
//
//  Created by kiss on 2019/11/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLUpdateSuccessView : UIView
-(instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnArr;
- (void)close;
@property (nonatomic, copy) void(^onButtonSuccess)(CLUpdateSuccessView *alertView, NSInteger buttonIndex);
@end

NS_ASSUME_NONNULL_END
