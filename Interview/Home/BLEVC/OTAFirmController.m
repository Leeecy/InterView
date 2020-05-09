//
//  OTAFirmController.m
//  Interview
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "OTAFirmController.h"
#import "OTAAlertView.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothCell.h"
#import "CLBLETestController.h"
@interface OTAFirmController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate>{
    //这里保存这个可以写的特性，便于后面往这个特性中写数据
    CBCharacteristic *_chatacter;//--------------外设的可写特性，全局保存，方便使用
    
    NSDictionary *_currentPeripheral;//----------当前连接的外设
    
    UIActivityIndicatorView *_aciv;//------------连接外设时的加载控件
    
    //设置定时器，扫描一分钟后停止扫描，节省性能。
    NSInteger _timeNum;
    NSTimer *_timer;
}
@property(strong,nonatomic) CBCentralManager *centerManager;//--------中心设备管理器

@property(strong,nonatomic) NSMutableArray *peripherals;//------------所有蓝牙外设
@property (nonatomic ,strong)NSArray *dataSource;
@property (nonatomic ,strong)UITableView *tableView;
@end

@implementation OTAFirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    _dataSource = @[@"",@"已连接设备",@"其他设备"];
   //初始化蓝牙manager
   [self initCBCentralManager];
    
//    //下拉刷新，搜索蓝牙外设
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//
//        [self scan:nil];
//    }];
}
#pragma mark ===== lazyLoad  =====
-(UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        _tableView.showsVerticalScrollIndicator = NO;
        if (@available (iOS 11,*)) {
            _tableView.estimatedRowHeight = 0;
        }
    }
    return _tableView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //
    [self stopTimer];
}
-(void)initCBCentralManager
{
    self.centerManager = [[CBCentralManager alloc] init];
    self.centerManager = [self.centerManager initWithDelegate:self queue:nil];
    self.peripherals = [NSMutableArray array]; //存放所有扫描到的蓝牙外设
    NSLog(@"self.centerManager ===== %@",self.centerManager);
}
//第二步：扫描蓝牙外设
- (void)scan:(id)sender
{
    if (_timer)
    {
        [self stopTimer];
    }
    _timeNum = 120;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCount:) userInfo:nil repeats:YES];
    [_timer fire];
    
    [self startScanPeripheral];
}
-(void)startScanPeripheral{
    if (self.centerManager.state != CBCentralManagerStatePoweredOn)
    {
        
        return;
    }
    //扫描蓝牙设备
    [self.centerManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(NO)}];
    //key值是NSNumber,默认值为NO表示不会重复扫描已经发现的设备,如需要不断获取最新的信号强度RSSI所以一般设为YES了
//    [self stopLoad];
}
-(void)stopScanPeripheral
{
    if (@available(iOS 9.0, *))
    {
        if ([self.centerManager isScanning])
        {
            [self.centerManager stopScan];
            
            NSLog(@"扫描结束");
        }
    } else {
        // Fallback on earlier versions
    }
}
-(void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}
-(void)timerCount:(id)sender
{
    if (_timeNum <= 0)
    {
        //关闭定时器
        [self stopTimer];
        
        //关闭扫描
        [self stopScanPeripheral];
        
        return;
    }
    --_timeNum;
//    NSLog(@"%ld",_timeNum);
}
-(void)contentPeripheral:(CBPeripheral *)peripheral withIndexPath:(NSIndexPath *)indexPath//点击cell，连接外设
{
    
//    //点击cell数据已替换，刷新列表
    [self changeCurrentPeripheralState];
}
-(void)changeCurrentPeripheralState//修改“已连接外设”的连接状态
{
     CBPeripheral *peripheral = _currentPeripheral[@"peripheral"];
    if (peripheral.state == CBPeripheralStateConnected)
    {
        
    }
}
#pragma mark -- table view delegate/datasource method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == _dataSource.count - 1){
        return self.peripherals.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString * str = @"PrintVC0_cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
   
        }
        
        return cell;
    }
    else
    {
        static NSString * str = @"PrintVC1_cell";
        BluetoothCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell)
        {
            cell = [[BluetoothCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            
        }
        
        //    NSDictionary *dict = @{@"peripheral":peripheral,@"locolName":locolName,@"peripheralName":peripheralName,@"advertisementData":advertisementData,@"RSSI":RSSI};
        if (self.peripherals.count > 0)
        {
            CBPeripheral *peripheral = nil;
            NSString *peripheralStr = nil;
            if (indexPath.section == 1)//已连接设备
            {
                peripheral = _currentPeripheral[@"peripheral"];
                peripheralStr = _currentPeripheral[@"locolName"];
                peripheralStr = peripheralStr.length <= 0 ? _currentPeripheral[@"peripheralName"] : peripheralStr;
                peripheralStr = peripheralStr.length <= 0 ? [peripheral.identifier UUIDString] : peripheralStr;
                
                cell.cancel_Block = ^(UITableViewCell *cell) {
                  
//                    [self cancelPeripheral:peripheral];
                };
            }
            else//其他设备
            {
                peripheral = self.peripherals[indexPath.row][@"peripheral"];
                peripheralStr = self.peripherals[indexPath.row][@"locolName"];
                peripheralStr = peripheralStr.length <= 0 ? self.peripherals[indexPath.row][@"peripheralName"] : peripheralStr;
                peripheralStr = peripheralStr.length <= 0 ? [peripheral.identifier UUIDString] : peripheralStr;
            }
            
            cell.deviceNameL.text = peripheralStr;
            
            //
            if (peripheral.state == CBPeripheralStateConnected && indexPath.section == 1)
            {
                cell.stateL.text = @"已连接";
                cell.cancelBtn.hidden = NO;
            }
            else
            {
                cell.stateL.text = @"未连接";
                cell.cancelBtn.hidden = YES;
            }
        }
        //reframe
        if (indexPath.section == 2)
             cell.stateL.hidden = YES;
        else
            cell.stateL.hidden = NO;
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0)
        return;
    else if (indexPath.section == 1)
    {
        if (_currentPeripheral != nil)//点击"已连接设备"连接时，不需要替换数据源
        {
            CBPeripheral *peripheral = _currentPeripheral[@"peripheral"];
            
            [self contentPeripheral:peripheral withIndexPath:indexPath];
        }
    }
    else
    {
        NSDictionary *dict = [self.peripherals objectAtIndex:indexPath.row];
        CBPeripheral *peripheral = dict[@"peripheral"];
       
        // 连接某个蓝牙外设
        if (dict){
            CLBLETestController *test = [[CLBLETestController alloc]init];
            test.centralManager = self.centerManager;
            test.myPeripheral = peripheral;
            [self.navigationController pushViewController:test animated:YES];
        }
    }
    
    //滑动到顶部
    [tableView setContentOffset:CGPointMake(0,0) animated:YES];
    tableView.scrollsToTop = YES;
}
#pragma mark
#pragma mark  =====  CBCentralManagerDelegate  =====
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI//RSSI信号强度
{
    
    NSString *locolName = [advertisementData objectForKey:@"kCBAdvDataLocalName"];//广播的名称（准确）
    NSString *peripheralName = peripheral.name;//设备名称 (修改过的名称获取不到)
    
    NSLog(@"locolName%@\n Discovered name:%@\n identifier:%@\n advertisementData:%@\n RSSI:%@\n state:%ld\n",locolName,peripheral.name, peripheral.identifier,advertisementData,RSSI,(long)peripheral.state);
    
    locolName = locolName == nil ? @"" : locolName;
    peripheralName = peripheralName == nil ? @"" : peripheralName;
    if (self.peripherals.count == 0)
    {
        NSDictionary *dict = @{@"peripheral":peripheral,@"locolName":locolName,@"peripheralName":peripheralName,@"advertisementData":advertisementData,@"RSSI":RSSI};
        [self.peripherals addObject:dict];
        
        //将已连接外设，置为当前外设
        if(peripheral.state == CBPeripheralStateConnected)
        {
            [self.peripherals removeObject:dict];
            _currentPeripheral = dict;
        }
    }else{
        BOOL isExist = NO;
        for (int i = 0; i < self.peripherals.count; i++)
        {
            NSDictionary *dict = [self.peripherals objectAtIndex:i];
            CBPeripheral *per = dict[@"peripheral"];
            if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString])//扫描到的外设已有，替换
            {
                isExist = YES;
                NSDictionary *dict = @{@"peripheral":peripheral,@"locolName":locolName,@"peripheralName":peripheralName,@"advertisementData":advertisementData,@"RSSI":RSSI};
                [self.peripherals replaceObjectAtIndex:i withObject:dict];
            }
            
            //去除已连接的外设
            if (_currentPeripheral)
            {
                CBPeripheral *currentPer = _currentPeripheral[@"peripheral"];
                if ([per.identifier.UUIDString isEqualToString:currentPer.identifier.UUIDString]) {
                    
                    [self.peripherals removeObjectAtIndex:i];
                }
            }
        }
        if (!isExist)
               {
                   NSDictionary *dict = @{@"peripheral":peripheral,@"locolName":locolName,@"peripheralName":peripheralName,@"advertisementData":advertisementData,@"RSSI":RSSI};
                   [self.peripherals addObject:dict];
               }
               
               //将已连接外设，置为当前外设
               if(peripheral.state == CBPeripheralStateConnected)
               {
                   NSDictionary *dict = @{@"peripheral":peripheral,@"locolName":locolName,@"peripheralName":peripheralName,@"advertisementData":advertisementData,@"RSSI":RSSI};
                   [self.peripherals removeObject:dict];
                   _currentPeripheral = dict;
               }
    }
}

- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    // 蓝牙状态可用
    if (central.state == CBCentralManagerStatePoweredOn) {
        
        // 如果蓝牙支持后台模式，一定要指定服务，否则在后台断开连接不上，如果不支持，可设为nil, option里的CBCentralManagerScanOptionAllowDuplicatesKey默认为NO, 如果设置为YES,允许搜索到重名，会很耗电
        //扫描外设
        [self scan:nil];
    }
    else {
        NSLog(@"蓝牙状态异常， 请检查后重试");
    }
}









@end
