//
//  CLBLETestController.h
//  Interview
//
//  Created by kiss on 2020/5/9.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface CLBLETestController : UIViewController
@property (strong,nonatomic) CBCentralManager *centralManager;
@property (nonatomic,strong) CBPeripheral *  myPeripheral;
@end

NS_ASSUME_NONNULL_END
