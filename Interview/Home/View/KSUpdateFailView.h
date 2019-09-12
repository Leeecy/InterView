//
//  KSUpdateFailView.h
//  Interview
//
//  Created by kiss on 2019/9/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSUpdateFailView : UIView
@property(nonatomic,strong)NSArray * btnArr;
-(instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnArr;
@property (nonatomic, copy) void(^onButtonTouchUpFail)(KSUpdateFailView *alertView, NSInteger buttonIndex);
- (void)close;

@end

NS_ASSUME_NONNULL_END
