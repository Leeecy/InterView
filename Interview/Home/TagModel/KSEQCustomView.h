//
//  KSEQCustomView.h
//  Interview
//
//  Created by kiss on 2019/10/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSEQCustomView : UIView
@property(nonatomic,strong)NSArray * btnArr;
-(instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnArr;
@property (nonatomic, copy) void(^onButtonTouchUpFail)(KSEQCustomView *alertView, NSInteger buttonIndex,NSString *name);
- (void)close;
@property(nonatomic,strong)UITextField *nameField;
@end

NS_ASSUME_NONNULL_END
