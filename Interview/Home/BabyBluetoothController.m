//
//  BabyBluetoothController.m
//  Interview
//
//  Created by kiss on 2019/9/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import "BabyBluetoothController.h"
#import "BTLibrary.h"
#import "GaiaLibrary.h"

#define FastPairService                 @"0E80"
#define GaiaServiceUUID                 @"00001100-D102-11E1-9B23-00025B00A5A5"

@interface BabyBluetoothController()<CSRConnectionManagerDelegate,CSRUpdateManagerDelegate>
@property (nonatomic,strong) NSMutableArray *devices;
@property (nonatomic,strong) CSRPeripheral *chosenPeripheral;
@property (nonatomic,strong) NSMutableArray *services;
@end

@implementation BabyBluetoothController
-(void)viewDidLoad {
    [super viewDidLoad];
    self.devices = [NSMutableArray array];
    self.services = [NSMutableArray array];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.devices removeAllObjects];
    
    [[CSRConnectionManager sharedInstance] addDelegate:self];
    CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
    NSArray *array = @[deviceInfoUUID];
    [[CSRConnectionManager sharedInstance] startScan:array];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[CSRConnectionManager sharedInstance] stopScan];
    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    [super viewWillDisappear:animated];
}
#pragma mark CSRConnectionManager delegate methods

- (void)didDisconnectFromPeripheral:(CBPeripheral *)peripheral {
    [MBProgressHUD showAutoMessage:@"The device disconnected" toView:kKeyWindow];
}
- (void)didDiscoverPeripheral:(CSRPeripheral *)peripheral {
    NSLog(@"peripheral===%@",peripheral.peripheral.name);
    if (![self foundDevice:peripheral.peripheral.identifier]) {
        self.chosenPeripheral = peripheral;
        [self.devices addObject:peripheral];
        if (![peripheral isConnected]) {
             [self.services removeAllObjects];
            [[CSRConnectionManager sharedInstance] connectPeripheral:peripheral];
            
        }else {
            [self.services removeAllObjects];
            [self discoveredPripheralDetails];
        }
    }
    [[CSRConnectionManager sharedInstance] stopScan];
    
}

- (void)discoveredPripheralDetails {
    for (CBService *service in self.chosenPeripheral.peripheral.services){
        if ([service.UUID.UUIDString isEqualToString:FastPairService]){
            NSLog(@"%@",service);
            [[CSRGaiaManager sharedInstance] getFastBattery];
            
        }
    }
}
#pragma mark private methods

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
@end
