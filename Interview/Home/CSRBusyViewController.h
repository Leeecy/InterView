//
//  CSRBusyViewController.h
//  Interview
//
//  Created by kiss on 2019/8/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "BaseViewController.h"

extern NSString * _Nonnull const CancelPressedNotification;
NS_ASSUME_NONNULL_BEGIN

@interface CSRBusyViewController : BaseViewController
@property (strong, nonatomic)  UIImageView *backgroundImageView;
@property (strong, nonatomic)  UIButton *cancelButton;
@property (strong, nonatomic)  CSRBusyViewController *busyView;
@property (strong, nonatomic)  UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic)  UILabel *statusLabel;
+ (CSRBusyViewController *)sharedInstance;
- (void)showBusy;
- (void)hideBusy;
- (IBAction)cancelPressed:(UIButton*)sender;
- (void)setStatus:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
