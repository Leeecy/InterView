//
//  CLBLETestController.m
//  Interview
//
//  Created by kiss on 2020/5/9.
//  Copyright © 2020 cl. All rights reserved.
//

#import "CLBLETestController.h"

@interface CLBLETestController ()<CBPeripheralDelegate,CBCentralManagerDelegate>

@end

@implementation CLBLETestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.centralManager connectPeripheral:self.myPeripheral options:nil];
    self.myPeripheral.delegate = self;
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"扫描到连接上=====%@",self.myPeripheral);
}
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接失败=====%@",self.myPeripheral);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
