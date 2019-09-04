//
//  CLUpdateAlert.h
//  TeviPair
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLUpdateAlert : UIView
@property(nonatomic,strong)NSArray * btnArr;
-(instancetype)initWithFrame:(CGRect)frame content:(NSString*)content btnArray:(NSArray *)btnArr;
@property (nonatomic, copy) void(^onButtonTouchUpInside)(CLUpdateAlert *alertView, NSInteger buttonIndex);
- (void)close;
@end

NS_ASSUME_NONNULL_END
