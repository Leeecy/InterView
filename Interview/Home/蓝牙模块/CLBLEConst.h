//
//  CLBLEConst.h
//  Interview
//
//  Created by kiss on 2020/4/29.
//  Copyright © 2020 cl. All rights reserved.
//

#ifndef CLBLEConst_h
#define CLBLEConst_h
typedef NS_ENUM(NSInteger, CLOptionStage) {
    CLOptionStageConnection,            //蓝牙连接阶段
    CLOptionStageSeekServices,          //搜索服务阶段
    CLOptionStageSeekCharacteristics,   //搜索特性阶段
    CLOptionStageSeekdescriptors,        //搜索描述信息阶段
};

#pragma mark ------------------- 通知的定义 --------------------------
/** 蓝牙状态改变的通知 */
#define kCentralManagerStateUpdateNoticiation @"kCentralManagerStateUpdateNoticiation"
#pragma mark ------------------- block的定义 --------------------------
/** 蓝牙状态改变的block */
typedef void(^CLStateUpdateBlock)(CBCentralManager *central);
/** 发现一个蓝牙外设的block */
typedef void(^CLDiscoverPeripheralBlock)(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI);
/** 统一返回使用的block */
typedef void(^CLBLECompletionBlock)(CLOptionStage stage, CBPeripheral *peripheral,CBService *service, CBCharacteristic *character, NSError *error);
/** 获取描述中的值 */
typedef void(^CLValueForDescriptorBlock)(CBDescriptor *descriptor,NSData *data,NSError *error);
/** 获取特性中的值 */
typedef void(^CLValueForCharacteristicBlock)(CBCharacteristic *characteristic, NSData *value, NSError *error);
/** 往特性中写入数据的回调 */
typedef void(^CLWriteToCharacteristicBlock)(CBCharacteristic *characteristic, NSError *error);
/** 往描述中写入数据的回调 */
typedef void(^CLWriteToDescriptorBlock)(CBDescriptor *descriptor, NSError *error);
/** 获取蓝牙外设信号的回调 */
typedef void(^CLGetRSSIBlock)(CBPeripheral *peripheral,NSNumber *RSSI, NSError *error);
#endif /* CLBLEConst_h */
