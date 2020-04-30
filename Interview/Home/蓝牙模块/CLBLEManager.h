//
//  CLBLEManager.h
//  Interview
//
//  Created by kiss on 2020/4/29.
//  Copyright © 2020 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CLBLEConst.h"
NS_ASSUME_NONNULL_BEGIN

@interface CLBLEManager : NSObject
/** 蓝牙模块状态改变的回调 */
@property (copy, nonatomic) CLStateUpdateBlock   stateUpdateBlock;
@property (strong, nonatomic,readonly)CBPeripheral  *connectedPerpheral;  /**< 当前连接的外设 */
#pragma mark - method
+ (instancetype)sharedInstance;
- (void)scanForPeripheralsWithServiceUUIDs:(NSArray<CBUUID *> *)uuids options:(NSDictionary<NSString *, id> *)options;

- (void)scanForPeripheralsWithServiceUUIDs:(NSArray<CBUUID *> *)uuids options:(NSDictionary<NSString *, id> *)options didDiscoverPeripheral:(CLDiscoverPeripheralBlock)discoverBlock;

/**
*  连接某个蓝牙外设，并查询服务，特性，特性描述
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral
        connectOptions:(NSDictionary<NSString *,id> *)connectOptions
stopScanAfterConnected:(BOOL)stop
       servicesOptions:(NSArray<CBUUID *> *)serviceUUIDs
characteristicsOptions:(NSArray<CBUUID *> *)characteristicUUIDs
         completeBlock:(CLBLECompletionBlock)completionBlock;
//查找某个服务的子服务
- (void)discoverIncludedServices:(NSArray<CBUUID *> *)includedServiceUUIDs forService:(CBService *)service;
//读取某个特性的值
- (void)readValueForCharacteristic:(CBCharacteristic *)characteristic;
// 读取某个特性的值
- (void)readValueForCharacteristic:(CBCharacteristic *)characteristic completionBlock:(CLValueForCharacteristicBlock)completionBlock;
// 往某个特性中写入数据
- (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type;
- (void)writeValue:(NSData *)data forCharacteristic:(CBCharacteristic *)characteristic type:(CBCharacteristicWriteType)type completionBlock:(CLWriteToCharacteristicBlock)completionBlock;

//读取某特性的描述信息
- (void)readValueForDescriptor:(CBDescriptor *)descriptor;

- (void)readValueForDescriptor:(CBDescriptor *)descriptor completionBlock:(CLValueForDescriptorBlock)completionBlock;

- (void)stopScan;

- (void)cancelPeripheralConnection;
@end

NS_ASSUME_NONNULL_END
