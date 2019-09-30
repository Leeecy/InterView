//
//  OTAAlertView.h
//  Interview
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTAAlertView : UIView

/**
弹出框
 */
@property (nonatomic, strong) UIView* dialogView;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSArray* buttonTitles;
/**
 触摸Alert以外的区域是否关闭alert;默认为YES
 */
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;

@property (nonatomic, copy) void(^onButtonTouchUpInside)(OTAAlertView *alertView, NSInteger buttonIndex);
// 显示Alert
- (void)show;
// 关闭Alert
- (void)close;
@end

NS_ASSUME_NONNULL_END
