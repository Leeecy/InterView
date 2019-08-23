//
//  UpdateViewController.h
//  Interview
//
//  Created by kiss on 2019/8/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateViewController : UIViewController
@property (nonatomic) NSString *fileName;

@property (strong, nonatomic) UILabel *fileNameLabel;
@property (strong, nonatomic) UILabel * timeLeftLabel;
@property (nonatomic,assign) BOOL isDataEndpointAvailable;
@property (strong, nonatomic)  UIProgressView *updateProgressView;
@property(nonatomic,strong)NSString *icwsTextField;
@property(nonatomic,strong)NSString *mcwsTextField;
@property(nonatomic,strong)NSString *dleSizeTextField;
@property (nonatomic,assign) BOOL rwcpSwitch;
@property (assign, nonatomic)BOOL dleSwitch;
@end

NS_ASSUME_NONNULL_END
