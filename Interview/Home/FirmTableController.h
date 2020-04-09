//
//  FirmTableController.h
//  Interview
//
//  Created by kiss on 2019/9/3.
//  Copyright © 2019 cl. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN



@interface FirmTableController : BaseViewController
@property (nonatomic,assign) BOOL isDataEndpointAvailable;
@property (nonatomic,strong) NSString *fileName;
@property (strong, nonatomic) UILabel *fileNameLabel;
@property (strong, nonatomic) UILabel * timeLeftLabel;
@property (strong, nonatomic)  UIProgressView *updateProgressView;
@property(nonatomic,copy)NSString *icwsTextField;
@property(nonatomic,copy)NSString *mcwsTextField;
@property(nonatomic,copy)NSString *dleSizeTextField;
@property (nonatomic,assign) BOOL rwcpSwitch;
@property (assign, nonatomic)BOOL dleSwitch;

@property(nonatomic,assign)BOOL isUpdateScanFirst;//更新第一次扫描,扫到就停止
@property(nonatomic,assign)BOOL isUpdateScanSecond;//更新第2次扫描,扫到就停止

@end

NS_ASSUME_NONNULL_END
