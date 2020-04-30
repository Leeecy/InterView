//
//  CLBLEManager.m
//  Interview
//
//  Created by kiss on 2020/4/29.
//  Copyright © 2020 cl. All rights reserved.
//

#import "CLBLEManager.h"

@interface CLBLEManager()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic)  CBPeripheral  *connectedPerpheral;    
@property (strong, nonatomic)   NSArray<CBUUID *>           *serviceUUIDs;          /**< 要查找服务的UUIDs */
@property (strong, nonatomic)   NSArray<CBUUID *>           *characteristicUUIDs;   /**< 要查找特性的UUIDs */

@property (assign, nonatomic)   BOOL             stopScanAfterConnected;  /**< 是否连接成功后停止扫描蓝牙设备 */

@end

static CLBLEManager *instance = nil;

@implementation CLBLEManager
+ (instancetype)sharedInstance{
    return [[self alloc] init];
}
- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super init];
        //蓝牙没打开时alert提示框
        NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@(YES)};
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:options];
//        _limitLength = kLimitLength;
    });
    
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

- (void)scanForPeripheralsWithServiceUUIDs:(NSArray<CBUUID *> *)uuids options:(NSDictionary<NSString *, id> *)options{
    [_centralManager scanForPeripheralsWithServices:uuids options:options];
}
- (void)discoverIncludedServices:(NSArray<CBUUID *> *)includedServiceUUIDs forService:(CBService *)service{
    [_connectedPerpheral discoverIncludedServices:includedServiceUUIDs forService:service];
}


- (void)stopScan{
    [_centralManager stopScan];
//    _discoverPeripheralBlcok = nil;
}

- (void)cancelPeripheralConnection{
    if (_connectedPerpheral) {
        [_centralManager cancelPeripheralConnection:_connectedPerpheral];
    }
}
- (void)readValueForCharacteristic:(CBCharacteristic *)characteristic{
    [_connectedPerpheral readValueForCharacteristic:characteristic];
}
- (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type{
    NSLog(@"writeValue");
}
#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCentralManagerStateUpdateNoticiation object:@{@"central":central}];
    NSLog(@"centralManagerDidUpdateState");
    if (_stateUpdateBlock) {
        _stateUpdateBlock(central);
    }
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI{
    _connectedPerpheral = peripheral;
}
#pragma mark ---------------- 连接外设成功和失败的代理 ---------------
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    
}
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    _connectedPerpheral = nil;
    NSLog(@"断开连接了，断开连接了 %@",error);
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    
    CBService * __nullable findService = nil;
    for (CBService *service in peripheral.services) {
        if ([[service UUID] isEqual:[CBUUID UUIDWithString:@"0e80"]]){
            findService = service;
        }
    }
    if (findService) {
        [peripheral discoverCharacteristics:nil forService:findService];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error{
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}
// 读取特性中的值
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSData *data = characteristic.value;
    NSLog(@"data==%@",data);
}
#pragma mark ---------------- 写入数据的回调 --------------------
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}
@end
