//
//  CSRBusyViewController.m
//  Interview
//
//  Created by kiss on 2019/8/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CSRBusyViewController.h"
#import "GaiaLibrary.h"

NSString * const CancelPressedNotification = @"CancelPressedNotification";
static CSRBusyViewController *shared = nil;
@interface CSRBusyViewController ()

@end

@implementation CSRBusyViewController
-(instancetype)init{
    if (self = [super init]) {
        shared = self;
        
        self.activityIndicator.color = [UIColor colorFromHex:@"FF9B00"];
        self.statusLabel.text = @"";
    }
    
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showBusy];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

+ (CSRBusyViewController *)sharedInstance {
    return shared;
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [super viewDidDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"Rebooting your device";
    label.font = [UIFont systemFontOfSize:48];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(260, 240));
        make.top.equalTo(self.view.mas_top).offset(160);
    }];
    
    self.cancelButton = [[UIButton alloc]init];
    self.cancelButton.backgroundColor = [UIColor colorFromHex:@"FF9B00"];
    [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.view addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
}
- (IBAction)cancelPressed:(UIButton*)sender {
    [self hideBusy];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CancelPressedNotification
     object:self
     userInfo:nil];
}

- (void)showBusy {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.activityIndicator startAnimating];
}

- (void)setStatus:(NSString *)value {
    [self.statusLabel setText:value];
}

- (void)hideBusy {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityIndicator stopAnimating];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
