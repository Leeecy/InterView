//
//  BLEViewController.m
//  Interview
//
//  Created by kiss on 2019/9/24.
//  Copyright © 2019 cl. All rights reserved.
//

#import "BLEViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BLEViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,strong)NSMutableArray *discoverPeripherals;
@property (strong,nonatomic) CBCentralManager *centralManager; //中心设备
@property (strong, nonatomic)   NSArray<CBUUID *>  *serviceUUIDs;          /**< 要查找服务的UUIDs */
@property (nonatomic,strong) CBPeripheral *  myPeripheral;
@property (nonatomic,strong) CBPeripheral *  secondPeripheral;
@property (nonatomic,strong) NSMutableArray *  macArray;
@property(nonatomic,assign)BOOL isSecondHeader;
@property(nonatomic,strong)NSString *lastName;
@property(nonatomic,strong)NSMutableArray *otherPeripherals;
@end

@implementation BLEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.macArray = [NSMutableArray arrayWithObjects:@"00025b01ff82",@"00025b01ff83", nil];
    self.otherPeripherals = [[NSMutableArray alloc]init];
    self.discoverPeripherals = [[NSMutableArray alloc]init];

    // Do any additional setup after loading the view.
//    self.centralManager = [[CBCentralManager alloc]
//                           initWithDelegate:self
//                           queue:nil];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    cancel.backgroundColor = [UIColor redColor];
    [cancel addTarget:self action:@selector(change) forControlEvents:(UIControlEventTouchUpInside)];
    [cancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel setTitle:@"切换" forState:(UIControlStateNormal)];
    [cancel setTitleColor:[UIColor colorFromHexStr:@"#888888"] forState:(UIControlStateNormal)];
    [self.view addSubview:cancel];
    
    
}
//切换蓝牙设备重新扫描
-(void)change{
    
//    [self.centralManager cancelPeripheralConnection:self.myPeripheral];
    NSLog(@"name===%@ pheral=%@",self.myPeripheral.name,self.discoverPeripherals);
    self.lastName = self.myPeripheral.name;
    
    for (CBPeripheral * secondPeri in self.discoverPeripherals) {
        if (![secondPeri.name isEqualToString:self.myPeripheral.name]) {
            [self.otherPeripherals addObject:secondPeri];
        }
    }
    
    NSLog(@"second==%@",self.otherPeripherals.firstObject);
    
    
    self.secondPeripheral = self.otherPeripherals.firstObject;
    
    if (@available(iOS 9.0, *)) {
        if (self.secondPeripheral.state == CBPeripheralStateDisconnecting && self.centralManager && self.secondPeripheral) {
            [self.centralManager connectPeripheral:self.secondPeripheral options:nil];
        }
    } else {
        // Fallback on earlier versions
    }
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStatePoweredOn:{
            CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
            NSArray *array = @[deviceInfoUUID];
            [self.centralManager scanForPeripheralsWithServices:array options:nil];
            // @{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }
            
        }
            break;
        case CBManagerStatePoweredOff:{
            NSLog(@"Bluetooth is turned off");
            
        }break;
        case CBManagerStateResetting:
            NSLog(@"System service resetting");
            break;
        case CBManagerStateUnknown:
            
            break;
        case CBManagerStateUnsupported:
            
            break;
        case CBManagerStateUnauthorized:
            
            break;
    }
    
}
//扫描到耳机数据
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral.name.length <= 0) {
        return ;
    }
    
    NSLog(@"lastName==%@ name==%@",self.lastName,peripheral.name);
    
    NSLog(@"当扫描到设备:%@ advertisementData ----%@ RSSI=%@",peripheral,advertisementData,RSSI);
    
    //    self.chosenPeripheral = [CSRPeripheral new];
    
    if ([RSSI integerValue] >= -45) {
        self.myPeripheral = peripheral;
        self.myPeripheral.delegate = self;
        [self.discoverPeripherals addObject:peripheral];
        [central connectPeripheral:self.myPeripheral options:nil];
    }
    
}

//连接耳机
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [self.centralManager stopScan];
    [self.myPeripheral discoverServices:nil];
    
}


@end
