//
//  FirmTableController.m
//  Interview
//
//  Created by kiss on 2019/9/3.
//  Copyright © 2019 cl. All rights reserved.
//

#import "FirmTableController.h"
#import "CLUpdateAlert.h"
#import "BTLibrary.h"
#import "GaiaLibrary.h"
#import "MBProgressHUD+Extension.h"
#import "AppDelegate.h"
#import "CSRBusyViewController.h"
#import "LLGifImageView.h"
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define GaiaServiceUUID                 @"00001100-D102-11E1-9B23-00025B00A5A5"
#define GifCircleWidth 120

#define RWCP_MAX_SEQUENCE 63
#define DEFAULT_SIZE 23
#define DleSizeTextStr @"188"
@interface FirmTableController ()<CSRConnectionManagerDelegate,CSRUpdateManagerDelegate>
@property (nonatomic,strong) CSRPeripheral *chosenPeripheral;
@property (nonatomic,strong) NSDictionary *supportedServices;
@property (nonatomic,assign) BOOL dataEndPointResponse;
@property (nonatomic,assign) BOOL isDataEndPointAvailabile;
@property(nonatomic,strong)CLUpdateAlert * updateView;

@property (nonatomic,assign) BOOL hideBusyView;
@property (nonatomic, strong) LLGifImageView *gifImageView;
@property(nonatomic,strong)UILabel *progressL;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)UIButton *startButton;
@property(nonatomic,strong)UIButton *cancelButton;

@property(nonatomic,strong)NSMutableArray *otherChosen;//更新第二个耳机
@property (nonatomic) NSMutableArray *devices;
@property(nonatomic,strong)UILabel *statusLabel;

@property(nonatomic,strong)NSMutableArray *macStr;
@property(nonatomic,strong)NSMutableArray *macArray;
@property(nonatomic,strong)NSString *firstMac;
@property(nonatomic,assign)BOOL isReconnectSecond;
@property(nonatomic,strong)CSRPeripheral *secondPeripheral;

@end

@implementation FirmTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.devices = [NSMutableArray array];
    self.otherChosen = [NSMutableArray array];
    self.supportedServices = @{ GaiaServiceUUID:
                                    @[@"Update Service", @"This service can update the software on the connected device."]};
    [self injected];
}
- (void)viewWillDisappear:(BOOL)animated {
    [[CSRConnectionManager sharedInstance] stopScan];
    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    [super viewWillDisappear:animated];
}
#pragma mark CSRConnectionManager delegate methods

- (void)didDisconnectFromPeripheral:(CBPeripheral *)peripheral {

    if (self.isReconnectSecond) {
        
        
//        if (![self.secondPeripheral isConnected]) {
//            NSLog(@"第一个耳机断了连上第二个didDisconnectFromPeripheral");
//            [[CSRConnectionManager sharedInstance] connectPeripheral:self.secondPeripheral];
//        }
        
    }else{
        NSLog(@"The device disconnected ==%@",peripheral);
    }
    
}

- (void)didDiscoverPeripheral:(CSRPeripheral *)peripheral {
    
    if (self.isReconnectSecond) {
        if (self.isUpdateScanSecond) {
            return;
        }
        NSString *secondMac = [self hexadecimalString:peripheral.advertisementData[@"kCBAdvDataManufacturerData"]];
        NSLog(@"secondMac==%@",secondMac);
        if (! [secondMac isEqualToString:self.firstMac]){
            NSLog(@"secondPeripheral==%@",peripheral.peripheral);
            self.secondPeripheral = peripheral;
            
            if (![self.secondPeripheral isConnected]) {
                
                [[CSRConnectionManager sharedInstance] connectPeripheral:peripheral];
                
                
            } else {
                [self discoveredPripheralDetails];
            }
            self.isUpdateScanSecond = YES;
            [[CSRConnectionManager sharedInstance]stopScan];
            
        }
    }else{
        if (self.isUpdateScanFirst) {
            return;
        }
        self.chosenPeripheral = peripheral;
        NSLog(@"Firstperi==%@",peripheral);
        if ([peripheral.peripheral isEqual:[CSRConnectionManager sharedInstance].connectedPeripheral.peripheral]) {
            NSLog(@"green");
            [self discoveredPripheralDetails];
        } else {
            NSLog(@"white");
            if (![self.chosenPeripheral isConnected]) {
                [[CSRConnectionManager sharedInstance] connectPeripheral:self.chosenPeripheral];
                //            self.noServicesMessage = NO;
            } else {
                
                [self discoveredPripheralDetails];
            }
        }
        self.isUpdateScanFirst = YES;
        [self.devices addObject:peripheral];
        NSLog(@"devices==%@",self.devices);
        [[CSRConnectionManager sharedInstance] stopScan];
        
    }
    
    
}

- (void)discoveredPripheralDetails{
    
    if (self.isReconnectSecond) {
        
        for (CBService *service in self.secondPeripheral.peripheral.services) {
            if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
                NSLog(@"%@更新第二个耳机\n%@\nsecondService==%@",self.chosenPeripheral.peripheral, self.secondPeripheral.peripheral,self.secondPeripheral.peripheral.services);
                
                [self setSecondDelegate];
            }
        }
    }else{
        for (CBService *service in self.chosenPeripheral.peripheral.services) {
            NSLog(@"services==%@",service);
            if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
                self.firstMac = [self hexadecimalString:self.chosenPeripheral.advertisementData[@"kCBAdvDataManufacturerData"]] ; NSLog(@"开始更新第一个耳机==%@",self.chosenPeripheral.peripheral.name);
                
                [self setDelegate];
            }
        }
    }
    
    
}
-(void)setSecondDelegate{
    [CSRGaiaManager sharedInstance].delegate = self;
    [[CSRGaiaManager sharedInstance] connect];
    [[CSRGaia sharedInstance]
     connectPeripheral:self.secondPeripheral];
    
    [[CSRGaiaManager sharedInstance] setDataEndPointMode:true];
}
-(void)setDelegate{
    [CSRGaiaManager sharedInstance].delegate = self;
    [[CSRGaiaManager sharedInstance] connect];
    [[CSRGaia sharedInstance]
     connectPeripheral:[CSRConnectionManager sharedInstance].connectedPeripheral];
    
    [[CSRGaiaManager sharedInstance] setDataEndPointMode:true];
}
-(void)injected{
    [self setBackgroundColor:[UIColor blackColor]];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(150, 200, 80, 50);
    [closeButton addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitle:@"固件更新" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor colorFromHexStr:@"#999999"] forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    closeButton.titleLabel.numberOfLines = 0;
    closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
   
    [self.view addSubview:closeButton];
}
-(IBAction)touchUpInside:(UIButton*)sender{
    NSLog(@"touchUpInside");
    [[CSRConnectionManager sharedInstance] addDelegate:self];
    CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
    NSArray *array = @[deviceInfoUUID];
    [self.devices removeAllObjects];
    [[CSRConnectionManager sharedInstance] startScan:array];
    
    NSLog(@"%d",self.dataEndPointResponse);
    
    
}

-(void)setupOTAU{
    self.hideBusyView = NO;
    self.isDataEndpointAvailable = YES;
    self.rwcpSwitch = YES;//默认打开
    self.dleSwitch = YES;
    /*****update*******/
    [CSRGaiaManager sharedInstance].delegate = self;
    if (!self.hideBusyView) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(cancelTouched)
         name:CancelPressedNotification
         object:nil];
        
        self.updateProgressView.progress = 0.0f;
        self.cancelButton.userInteractionEnabled = false;
        
        if (self.isDataEndpointAvailable) {
            self.icwsTextField = @"3";
            self.mcwsTextField = @"4";
        } else {

        }
        
        NSUInteger maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteLength;
        
        if (self.rwcpSwitch) {
            maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteWithoutResponseLength;
        }
        
        self.dleSizeTextField = DleSizeTextStr;
        
        if ([CSRConnectionManager sharedInstance].connectedPeripheral.isDataLengthExtensionSupported) {
//            [self enableMTU:true];
        } else {
//            [self enableMTU:false];
        }
    } else {
        self.cancelButton.userInteractionEnabled = true;
        self.startButton.userInteractionEnabled = false;
    }
    self.hideBusyView = NO;
    
}

-(void)popView{
    [self setupOTAU];
    
    NSArray *arr1 = @[@"取消",@"立即更新"];
    //boundingRectWithSize: 方法只是取得字符串的size, 如果字符串中包含\n\r 这样的字符，也只会把它当成字符来计算
    NSString *content = @"1、修复了些已知问题 \n2、改善连接配对不稳定问题 \n3、添加协议 \n4、请将耳机处于此设备的接受范围<50m";
    
    CLUpdateAlert * updateView = [[CLUpdateAlert alloc]initWithFrame:kKeyWindow.frame content:content btnArray:arr1];
    hq_weak(updateView)
    hq_weak(self)
    updateView.onButtonTouchUpInside = ^(CLUpdateAlert * _Nonnull alertView, NSInteger buttonIndex) {
        hq_strong(updateView)
        hq_strong(self)
        if (buttonIndex == 0) {
            [updateView close];
            [self cancelTouched];
            //            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"立即更新");
            
            [updateView close];
            [self update];
            //正在更新动画
            [self loadingAnimate];
            
        }
    };
    
    self.updateView = updateView;
    [kKeyWindow addSubview:updateView];
}

-(void)loadingAnimate{
    [self removeGif];
    self.view.backgroundColor = [UIColor colorFromHexStr:@"#0E0E0E"];

    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"32" ofType:@"gif"]];
    _gifImageView = [[LLGifImageView alloc] initWithFrame:CGRectMake((ScreenWidth -GifCircleWidth)*0.5, 200, GifCircleWidth, GifCircleWidth)];
    _gifImageView.contentMode = UIViewContentModeScaleAspectFit;
    _gifImageView.gifData = localData;
    [self.view addSubview:_gifImageView];
    [_gifImageView startGif];
    UILabel * label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:26];
    label.text = @"0%";
    self.progressL = label;
    [self.view addSubview:self.progressL];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.gifImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:29];
    label1.text = @"正在升级";
    [self.view addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.gifImageView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(210, 30));
    }];
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.textColor = [UIColor colorFromHexStr:@"#888888"];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"请将2个耳机处于此设备的接收范围<50cm";
    [self.view addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(label1.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(280, 30));
    }];
    
    UIButton *cancel = [[UIButton alloc]init];
    [cancel addTarget:self action:@selector(cancelTouched) forControlEvents:(UIControlEventTouchUpInside)];
    [cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancel setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.view addSubview:cancel];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
}
- (void)removeGif {
    if (_gifImageView.superview) {
        [_gifImageView removeFromSuperview];
        _gifImageView = nil;
    }
}

- (void)didReceiveGaiaGattResponse:(CSRGaiaGattCommand *)command {
    GaiaCommandType cmdType = [command getCommandId];
    NSData *requestPayload = [command getPayload];
    uint8_t success = 0;
    
    [requestPayload getBytes:&success range:NSMakeRange(0, sizeof(uint8_t))];
    if (cmdType == GaiaCommand_SetDataEndPointMode && requestPayload.length > 0) {
        uint8_t value = 0;
        [requestPayload getBytes:&value range:NSMakeRange(0, sizeof(uint8_t))];
        
        if (value == GaiaStatus_Success) {
            self.isDataEndPointAvailabile = true;
        } else {
            self.isDataEndPointAvailabile = false;
        }
        
        self.dataEndPointResponse = true;
       
//        [MBProgressHUD showAutoMessage:@"能更新" toView:kKeyWindow];
        if (self.isReconnectSecond) {
             NSLog(@"secondDataEndPoint");
            [self.updateView close];
            [self setupOTAU];
            [self update];
        }else{
             NSLog(@"dataEndPoint");
            if (!self.updateView) {
                [self popView];
            }
            //        [self.tableView reloadData];
        }
        
       
        
    }
}

-(void)cancelTouched{
   
    NSLog(@"++++++cancel");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.updateInProgress = NO;
    self.updateProgressView.progress = 0;
    self.hideBusyView = YES;
    
    [[CSRBusyViewController sharedInstance] hideBusy];
     [self hideBusy];
    [[CSRGaiaManager sharedInstance] abort];
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)update{
   
//    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//    self.hud.label.text = NSLocalizedString(@"正在更新...", @"HUD loading title");
    
    NSLog(@"++++++start");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"KB522_3020_6.3.2_2002_20191202"ofType:@"bin"];
    if (self.dleSwitch && [CSRConnectionManager sharedInstance].connectedPeripheral.isDataLengthExtensionSupported){
        NSUInteger value = self.dleSizeTextField.integerValue;
        NSUInteger maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteLength;
        if (self.rwcpSwitch) {
            maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteWithoutResponseLength;
        }
        if (value > 512 || value < DEFAULT_SIZE) {
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"Invalid Value"
                                        message:[NSString stringWithFormat:@"The value of MTU is invalid.\nGreater than 22 and less than %lu.", maxValue]
                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:nil];
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        [CSRGaiaManager sharedInstance].useDLEifAvailable = true;
        if (self.rwcpSwitch) {
            [CSRGaiaManager sharedInstance].maximumMessageSize = value;
        } else {
            [CSRGaiaManager sharedInstance].maximumMessageSize = DEFAULT_SIZE;
        }
    }else{
        [CSRGaiaManager sharedInstance].maximumMessageSize = DEFAULT_SIZE;
    }
    
    if (self.rwcpSwitch && self.isDataEndpointAvailable) {
        int icws = self.icwsTextField.intValue;
        int mcws = self.mcwsTextField.intValue;
        
        if ((icws >= mcws) || (icws > RWCP_MAX_SEQUENCE) || (mcws > RWCP_MAX_SEQUENCE)) {
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"Invalid Value"
                                        message:@"The value for the Congestion Window is invalid.\nValues must be less than 63 and initial Window must be less than the maximum."
                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okButton = [UIAlertAction
                                       actionWithTitle:@"OK"
                                       style:UIAlertActionStyleDefault
                                       handler:nil];
            
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
        appDelegate.updateFileName = self.fileName;
        appDelegate.updateInProgress = YES;
        self.fileNameLabel.text = self.fileName;
        self.updateProgressView.progress = 0;
        [QTIRWCP sharedInstance].initialCongestionWindowSize = icws;
        [QTIRWCP sharedInstance].maximumCongestionWindowSize = mcws;
        [[CSRGaiaManager sharedInstance]start:dataPath useDataEndpoint:true];
    }else {
        appDelegate.updateFileName = self.fileName;
        appDelegate.updateInProgress = YES;
        self.fileNameLabel.text = self.fileName;
        self.updateProgressView.progress = 0;
        
        [[CSRGaiaManager sharedInstance]start:dataPath
                              useDataEndpoint:false];
    }
    
//    self.startButton.userInteractionEnabled = false;
//    self.cancelButton.userInteractionEnabled = true;
    
}


#pragma mark CSRUpdateManager delegate methods

- (void)confirmRequired {
    if (self.isReconnectSecond) {
        self.hideBusyView = YES;
        [[CSRBusyViewController sharedInstance] hideBusy];
         [self hideBusy];
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Finalise Update"
                                    message:@"Would you like to complete the upgrade?"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [[CSRGaiaManager sharedInstance] commitConfirm:YES];
                                   }];
        UIAlertAction *cancelActionButton = [UIAlertAction
                                             actionWithTitle:@"Cancel"
                                             style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * action) {
                                                 [[CSRGaiaManager sharedInstance] commitConfirm:NO];
                                             }];
        
        [alert addAction:okButton];
        [alert addAction:cancelActionButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    self.hideBusyView = YES;
    [[CSRBusyViewController sharedInstance] hideBusy];
     [self hideBusy];
    [[CSRGaiaManager sharedInstance] commitConfirm:YES];
    NSLog(@"confirmRequired");
    
}
- (void)confirmForceUpgrade {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Synchronisation Failed"
                                message:@"Another update has already been started. Would you like to force the upgrade?"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [[CSRGaiaManager sharedInstance] abortAndRestart];
                                   
                               }];
    UIAlertAction *cancelActionButton = [UIAlertAction
                                         actionWithTitle:@"Cancel"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             [self tidyUp];
                                         }];
    
    [alert addAction:okButton];
    [alert addAction:cancelActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)okayRequired {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"SQIF Erase"
                                message:@"About to erase SQIF partition"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [[CSRGaiaManager sharedInstance] eraseSqifConfirm];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didAbortWithError:(NSError *)error {
    NSString *errorMessage = [error.userInfo objectForKey:CSRGaiaErrorParam];
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:error.code <= 128 ? @"Update failed" : @"Warning"
                                message:errorMessage
                                preferredStyle:UIAlertControllerStyleAlert];
    
    if (error.code <= 128) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        appDelegate.updateInProgress = NO;
        appDelegate.updateFileName = nil;
        self.updateProgressView.progress = 0;
        self.title = @"Update";
        self.timeLeftLabel.text = @"";
        self.cancelButton.userInteractionEnabled = NO;
        self.cancelButton.hidden = YES;
        [[CSRGaiaManager sharedInstance] confirmError];
        self.hideBusyView = YES;
        [[CSRBusyViewController sharedInstance] hideBusy];
         [self hideBusy];
    }
    
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   if (error.code <= 128) {
                                       [self tidyUp];
                                       
                                   }
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didMakeProgress:(double)value eta:(NSString *)eta {
    [self.hud hideAnimated:YES];
    self.updateProgressView.progress = value / 100;
    self.title = [NSString stringWithFormat:@"%.2f%% Complete", value];
    self.timeLeftLabel.text = eta;
//    self.progressL.text = [NSString stringWithFormat:@"%.0f%%", value];
    if (self.isReconnectSecond) {
        
        NSLog(@"value=====%f",value*0.5);
        self.progressL.text = [NSString stringWithFormat:@"%.0f%%", value * 0.5 + 50];
    }else{
        self.progressL.text = [NSString stringWithFormat:@"%.0f%%", value * 0.5];
    }
    NSLog(@"progressL==%@", self.progressL.text);
    
}

- (void)didCompleteUpgrade {
    if (self.isReconnectSecond) {
        self.hideBusyView = YES;
        [[CSRBusyViewController sharedInstance] hideBusy];
         [self hideBusy];
        NSString *message = [NSString stringWithFormat:@"Update with: %@", self.fileName];
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Update successful"
                                    message:message
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [self tidyUp];
                                       
                                   }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];
       
    }else{
        self.hideBusyView = YES;
        [[CSRConnectionManager sharedInstance] disconnectPeripheral];
        [[CSRBusyViewController sharedInstance] hideBusy];
         [self hideBusy];
        self.isReconnectSecond = YES;
        NSLog(@"第一个耳机更新完了");
        [[CSRConnectionManager sharedInstance] addDelegate:self];
        CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
        NSArray *array = @[deviceInfoUUID];
        [[CSRConnectionManager sharedInstance] startScan:array];
        
    }
    
}

- (void)didAbortUpgrade {
    
    NSString *message = [NSString stringWithFormat:@"Update with: %@", self.fileName];
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Update aborted"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [self abortTidyUp];
                                   //更新完动画停止
                                   
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

- (void)confirmTransferRequired {
     [[CSRGaiaManager sharedInstance] updateTransferComplete];
    
//    UIAlertController *alert = [UIAlertController
//                                alertControllerWithTitle:@"File transfer complete"
//                                message:@"Would you like to proceed?"
//                                preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okButton = [UIAlertAction
//                               actionWithTitle:@"OK"
//                               style:UIAlertActionStyleDefault
//                               handler:^(UIAlertAction * action) {
//                                   [[CSRGaiaManager sharedInstance] updateTransferComplete];
//
//                               }];
//    UIAlertAction *cancelActionButton = [UIAlertAction
//                                         actionWithTitle:@"Cancel"
//                                         style:UIAlertActionStyleDefault
//                                         handler:^(UIAlertAction * action) {
//                                             [[CSRGaiaManager sharedInstance] updateTransferAborted];
//                                         }];
//
//    [alert addAction:okButton];
//    [alert addAction:cancelActionButton];
//
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)confirmBatteryOkay {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Battery Low"
                                message:@"The battery is low on your audio device. Please connect it to a charger"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [[CSRGaiaManager sharedInstance] syncRequest];
                                   
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tidyUp {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.hideBusyView = YES;
    [[CSRBusyViewController sharedInstance] hideBusy];
     [self hideBusy];
    self.title = @"Update";
    self.fileNameLabel.text = @"";
    self.timeLeftLabel.text = @"";
    self.updateProgressView.progress = 0;
    self.cancelButton.userInteractionEnabled = false;
    self.startButton.userInteractionEnabled = true;
    appDelegate.updateInProgress = NO;
    appDelegate.updateFileName = self.fileName;
    
    [[CSRGaiaManager sharedInstance] disconnect];
    [CSRGaiaManager sharedInstance].delegate = nil;
    [CSRGaiaManager sharedInstance].updateInProgress = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)abortTidyUp {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.hideBusyView = YES;
    [[CSRBusyViewController sharedInstance] hideBusy];
    [self hideBusy];
    self.title = @"Update";
    self.fileNameLabel.text = @"";
    self.timeLeftLabel.text = @"";
    self.updateProgressView.progress = 0;
    self.cancelButton.userInteractionEnabled = false;
    self.startButton.userInteractionEnabled = true;
    appDelegate.updateInProgress = NO;
    appDelegate.updateFileName = self.fileName;
    
    [CSRGaiaManager sharedInstance].updateInProgress = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didUpdateStatus:(NSString *)value {
    if (self.isReconnectSecond) {
        [[CSRBusyViewController sharedInstance] setStatus:value];
    }else{
        [self.statusLabel setText:value];
        NSLog(@"status==%@",self.statusLabel.text);
    }

}

- (void)didWarmBoot {
    if (self.isReconnectSecond) {
        CSRBusyViewController *busy = [[CSRBusyViewController alloc]init];
        [self.navigationController pushViewController:busy animated:YES];

    }else{
        
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:CancelPressedNotification
         object:nil];
        [[CSRConnectionManager sharedInstance] removeDelegate:self];
        
        [self showBusy];
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        self.statusLabel = [[UILabel alloc]init];
        self.statusLabel.text = @"";
        [self.view addSubview:self.statusLabel];
       
    }
}
- (void)showBusy {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}
- (void)hideBusy {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
}
//将Data类型转为String类型并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}
@end
