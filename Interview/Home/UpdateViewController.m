//
//  UpdateViewController.m
//  Interview
//
//  Created by kiss on 2019/8/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "UpdateViewController.h"
#import "GaiaLibrary.h"
#import "CSRBusyViewController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#define RWCP_MAX_SEQUENCE 63
#define DEFAULT_SIZE 23
//#define GaiaServiceUUID             @"00001100-D102-11E1-9B23-00025B00A5A5"

@interface UpdateViewController ()<CSRConnectionManagerDelegate,CSRUpdateManagerDelegate>
@property(nonatomic,strong)UIButton *startButton;
@property(nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,assign) BOOL hideBusyView;

@property (nonatomic) CSRPeripheral *chosenPeripheral;
@property (nonatomic) NSMutableArray *devices;
@property (nonatomic) NSMutableArray *services;

@property (nonatomic) BOOL dataEndPointResponse;
@property (nonatomic) BOOL isDataEndPointAvailabile;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation UpdateViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CSRConnectionManager sharedInstance] addDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hideBusyView = NO;
    
    self.devices = [NSMutableArray array];
    self.services = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isDataEndpointAvailable = YES;
    self.rwcpSwitch = YES;//默认打开
    self.dleSwitch = YES;
    
    self.updateProgressView = [ [ UIProgressView alloc ]init];
    self.updateProgressView.progress= 0.5;
    [self.view addSubview:self.updateProgressView];
    
    [self.updateProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 2));
        make.top.mas_equalTo(self.view.mas_top).offset(500);
    }];
    
    self.cancelButton = [[UIButton alloc]init];
    self.cancelButton.backgroundColor = [UIColor colorFromHex:@"FF9B00"];
    [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.view addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(cancelTouched:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    self.startButton = [[UIButton alloc]init];
    self.startButton.backgroundColor = [UIColor colorFromHex:@"FF9B00"];
    [self.startButton setTitle:@"开始" forState:(UIControlStateNormal)];
    [self.view addSubview:self.startButton];
    [self.startButton addTarget:self action:@selector(startTouched:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    self.fileNameLabel = [[UILabel alloc]init];
    self.fileNameLabel.textColor = [UIColor blackColor];
    self.fileNameLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.fileNameLabel];
    [self.fileNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.updateProgressView.mas_top).offset(-70);
    }];
    
    self.timeLeftLabel = [[UILabel alloc]init];
    self.timeLeftLabel.textColor = [UIColor blackColor];
    self.timeLeftLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.timeLeftLabel];
    [self.timeLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.bottom.equalTo(self.updateProgressView.mas_top).offset(-30);
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self.devices removeAllObjects];
    
     [CSRGaiaManager sharedInstance].delegate = self;
    
    /***
    CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
    NSArray *array = @[deviceInfoUUID];
    [[CSRConnectionManager sharedInstance] startScan:array];
    */
    
//    [CSRGaiaManager sharedInstance].delegate = self;
    
    if (!self.hideBusyView) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(cancelTouched:)
         name:CancelPressedNotification
         object:nil];
        
        self.updateProgressView.progress = 0.0f;
        self.cancelButton.userInteractionEnabled = false;

        if (self.isDataEndpointAvailable) {
            [self enableRWCP:true];
            self.icwsTextField = @"3";
            self.mcwsTextField = @"4";
        } else {
            [self enableRWCP:false];
        }

        NSUInteger maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteLength;

        if (self.rwcpSwitch) {
            maxValue = [CSRConnectionManager sharedInstance].connectedPeripheral.maximumWriteWithoutResponseLength;
        }

        self.dleSizeTextField = @"64";

        if ([CSRConnectionManager sharedInstance].connectedPeripheral.isDataLengthExtensionSupported) {
            [self enableMTU:true];
        } else {
            [self enableMTU:false];
        }
    } else {
        self.cancelButton.userInteractionEnabled = true;
        self.startButton.userInteractionEnabled = false;
    }
    
    self.hideBusyView = NO;
}
- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:CancelPressedNotification
     object:nil];
//    [[CSRConnectionManager sharedInstance] stopScan];
    
    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    [super viewDidDisappear:animated];
}

- (IBAction)cancelTouched:(UIButton*)sender {
    NSLog(@"++++++cancel");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    appDelegate.updateInProgress = NO;
    self.updateProgressView.progress = 0;
    self.hideBusyView = YES;
    
    [[CSRBusyViewController sharedInstance] hideBusy];
    [[CSRGaiaManager sharedInstance] abort];
}
-(IBAction)startTouched:(UIButton*)sender{
    NSLog(@"++++++start");
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.hud.label.text = NSLocalizedString(@"正在更新...", @"HUD loading title");
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"ota_cc"ofType:@"bin"];
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
    
    self.startButton.userInteractionEnabled = false;
    self.cancelButton.userInteractionEnabled = true;
    [self.hud hideAnimated:YES];
}
- (void)enableRWCP:(Boolean)value {
//    self.rwcpLabel.alpha = (value ? 1.0 : 0.5);
//    self.rwcpLabel.enabled = value;
//    self.rwcpSwitch.alpha = (value ? 1.0 : 0.5);
//    self.rwcpSwitch.enabled = value;
//    self.icwsLabel.alpha = (value ? 1.0 : 0.5);
//    self.icwsLabel.enabled = value;
//    self.icwsTextField.alpha = (value ? 1.0 : 0.5);
//    self.icwsTextField.enabled = value;
//    self.mcwsLabel.alpha = (value ? 1.0 : 0.5);
//    self.mcwsLabel.enabled = value;
//    self.mcwsTextField.alpha = (value ? 1.0 : 0.5);
//    self.mcwsTextField.enabled = value;
}
- (void)enableMTU:(Boolean)value {
//    self.dleLabel.alpha = (value ? 1.0 : 0.5);
//    self.dleLabel.enabled = value;
//    self.dleSwitch.alpha = (value ? 1.0 : 0.5);
//    self.dleSwitch.enabled = value;
//    self.dleSizeLabel.alpha = (value ? 1.0 : 0.5);
//    self.dleSizeLabel.enabled = value;
//    self.dleSizeTextField.alpha = (value ? 1.0 : 0.5);
//    self.dleSizeTextField.enabled = value;
}
#pragma mark CSRUpdateManager delegate methods
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
        
    }
}

- (void)confirmRequired {
    self.hideBusyView = YES;
    [[CSRBusyViewController sharedInstance] hideBusy];
    
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
    self.updateProgressView.progress = value / 100;
    self.title = [NSString stringWithFormat:@"%.2f%% Complete", value];
    self.timeLeftLabel.text = eta;
}

- (void)didCompleteUpgrade {
    self.hideBusyView = YES;
    [[CSRBusyViewController sharedInstance] hideBusy];
    
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
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

- (void)confirmTransferRequired {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"File transfer complete"
                                message:@"Would you like to proceed?"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [[CSRGaiaManager sharedInstance] updateTransferComplete];
                               }];
    UIAlertAction *cancelActionButton = [UIAlertAction
                                         actionWithTitle:@"Cancel"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             [[CSRGaiaManager sharedInstance] updateTransferAborted];
                                         }];
    
    [alert addAction:okButton];
    [alert addAction:cancelActionButton];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    [[CSRBusyViewController sharedInstance] setStatus:value];
}

- (void)didWarmBoot {
    CSRBusyViewController *busy = [[CSRBusyViewController alloc]init];
    [self.navigationController pushViewController:busy animated:YES];
//    [[NSNotificationCenter defaultCenter]
//     removeObserver:self
//     name:CancelPressedNotification
//     object:nil];
//
//    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    
 
}
#pragma mark CSRConnectionManager delegate methods
/**
- (void)didDiscoverPeripheral:(CSRPeripheral *)peripheral {
    if (![self foundDevice:peripheral.peripheral.identifier]) {
        [self.devices addObject:peripheral];
        
    }
    [[CSRConnectionManager sharedInstance] connectPeripheral:peripheral];
   
   
    if (![peripheral isConnected]) {
         [self.services removeAllObjects];
         [[CSRConnectionManager sharedInstance] connectPeripheral:peripheral];
        
    }
   
    [self.devices enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CSRPeripheral *peripheral = (CSRPeripheral*)obj;
        
        [CSRConnectionManager sharedInstance].connectedPeripheral = peripheral;
        
        
        if ([peripheral.peripheral isEqual:[CSRConnectionManager sharedInstance].connectedPeripheral.peripheral]) {
//            [CSRGaiaManager sharedInstance].delegate = self;
//            [[CSRConnectionManager sharedInstance] addDelegate:self];
           
            for (CBService *service in peripheral.peripheral.services) {
                if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]){
                    NSLog(@"成功");
                    [self.services addObject:service];
                     NSLog(@"service==%@",peripheral.peripheral.services);
                    self.isDataEndPointAvailabile = false;
                    self.dataEndPointResponse = false;
                    [CSRGaiaManager sharedInstance].delegate = self;
                    [[CSRGaiaManager sharedInstance] connect];
                    [[CSRGaiaManager sharedInstance] setDataEndPointMode:true];
                }
            }
            
        }else{
            NSLog(@"不成功");
        }
    }];
    
    
    

    
    NSArray *array = [peripheral.advertisementData objectForKey:@"kCBAdvDataServiceUUIDs"];
    NSInteger servicesCount = array ? array.count : peripheral.peripheral.services.count;
    NSString *deviceName = [peripheral.advertisementData objectForKey:@"kCBAdvDataLocalName"];
}

- (void)didDisconnectFromPeripheral:(CBPeripheral *)peripheral {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Device disconnected"
                                message:@"The device disconnected"
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
   
}
- (BOOL)foundDevice:(NSUUID *)uuid {
    for (id value in self.devices) {
        if ([value isKindOfClass:[CSRPeripheral class]]) {
            CSRPeripheral *peripheral = value;
            if ([peripheral.peripheral.identifier.UUIDString isEqualToString:uuid.UUIDString]) {
                return YES;
            }
        }
    }
    
    return NO;
}
**/
@end
