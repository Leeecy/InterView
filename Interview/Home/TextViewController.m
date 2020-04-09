//
//  TextViewController.m
//  suanfa
//
//  Created by cl on 2019/7/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "TextViewController.h"
#import "CLTextView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "BTLibrary.h"
#import "GaiaLibrary.h"
#import "KSWavesAnimation.h"
#define GaiaServiceUUID             @"00001100-D102-11E1-9B23-00025B00A5A5"
@interface TextViewController ()<UITextViewDelegate,CSRConnectionManagerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,strong)NSMutableArray *discoverPeripherals;
@property (strong,nonatomic) CBCentralManager *centralManager; //中心设备
@property (strong, nonatomic)   NSArray<CBUUID *>  *serviceUUIDs;          /**< 要查找服务的UUIDs */
@property (nonatomic,strong) CBPeripheral *  myPeripheral;

@property (nonatomic,strong) NSMutableArray *devices;
@property (nonatomic) CSRPeripheral *chosenPeripheral;

@property(nonatomic,strong)NSMutableArray *otherPeripherals;
@property(nonatomic,strong)NSMutableArray *secondPeripherals;

@property(strong,nonatomic)KSWavesAnimation *progressV;
@end

@implementation TextViewController
-(IBAction)change1:(UIButton*)sender{
    [self.progressV stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = (ScreenWidth - 83)*0.5;
    CGFloat height = (ScreenHeight - 83)*0.5;
    self.progressV = [[KSWavesAnimation alloc]initWithFrame:CGRectMake(width, height, 83, 83)];
//    _rippleView = [[RippleView alloc] initWithFrame:CGRectMake(width, height, 83, 83)];
    
//    [self.view addSubview:_rippleView];
    [self.view addSubview:self.progressV];
//    [_rippleView startRipplrWithShowAnimation];
    
    UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(30, ScreenHeight-49 -14, ScreenWidth -30*2, 14)];
    textL.text = @"请确保您的产品已打开且处于此设备的接收范围内<50cm";
    textL.textColor = [UIColor colorWithHexString:@"#46464E"];
    textL.font = [UIFont systemFontOfSize:12];
    textL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textL];
    
    
    UIButton *cancel1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 130, 80, 50)];
    cancel1.backgroundColor = [UIColor redColor];
    [cancel1 addTarget:self action:@selector(change1:) forControlEvents:(UIControlEventTouchUpInside)];
    [cancel1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    cancel1.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel1 setTitle:@"取消转圈" forState:(UIControlStateNormal)];
    [cancel1 setTitleColor:[UIColor colorFromHexStr:@"#888888"] forState:(UIControlStateNormal)];
    [self.view addSubview:cancel1];
    
    
    
     self.devices = [NSMutableArray array];
    self.otherPeripherals = [NSMutableArray array];
    self.discoverPeripherals = [NSMutableArray array];
    self.secondPeripherals =[NSMutableArray array];
    self.view.backgroundColor =  [UIColor whiteColor];
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 80, 50)];
    cancel.backgroundColor = [UIColor redColor];
    [cancel addTarget:self action:@selector(change) forControlEvents:(UIControlEventTouchUpInside)];
    [cancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel setTitle:@"切换" forState:(UIControlStateNormal)];
    [cancel setTitleColor:[UIColor colorFromHexStr:@"#888888"] forState:(UIControlStateNormal)];
    [self.view addSubview:cancel];
    
    UIButton *second = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 80, 50)];
    second.backgroundColor = [UIColor orangeColor];
    [second addTarget:self action:@selector(secondClick) forControlEvents:(UIControlEventTouchUpInside)];
    [second setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    second.titleLabel.font = [UIFont systemFontOfSize:14];
    [second setTitle:@"继续更新" forState:(UIControlStateNormal)];
    [second setTitleColor:[UIColor colorFromHexStr:@"#888888"] forState:(UIControlStateNormal)];
    [self.view addSubview:second];
//    [self getTextView];
    self.centralManager = [[CBCentralManager alloc]
                           initWithDelegate:self
                           queue:nil];
   
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [[CSRConnectionManager sharedInstance] stopScan];
    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    [super viewWillDisappear:animated];
    [self.progressV stop];
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
    

    if ([RSSI integerValue] >= -45) {
        self.myPeripheral = peripheral;
        self.myPeripheral.delegate = self;
        [self.discoverPeripherals addObject:peripheral];
        [central connectPeripheral:self.myPeripheral options:nil];
    }
    NSLog(@"当扫描到设备:%@ advertisementData ----%@ RSSI=%@  discoverPeripherals =%@",peripheral,advertisementData,RSSI,self.discoverPeripherals);
    
    
}

//连接耳机
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [self.centralManager stopScan];
    [self.myPeripheral discoverServices:nil];
    
}
-(void)change{
    NSLog(@"当前连接要断开的设备===%@",self.myPeripheral.name);
    
    [self.centralManager cancelPeripheralConnection:self.myPeripheral];
    
    for (CBPeripheral * secondPeri in self.discoverPeripherals) {
        if (![secondPeri.name isEqualToString:self.myPeripheral.name]) {
            [self.otherPeripherals addObject:secondPeri];
        }
    }
    
    CBPeripheral *second = self.otherPeripherals.firstObject;
//    NSLog(@"second ==%@",second);
    [self.centralManager cancelPeripheralConnection:second];
    [self.devices removeAllObjects];
    [[CSRConnectionManager sharedInstance] addDelegate:self];
    CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
    NSArray *array = @[deviceInfoUUID];
    [[CSRConnectionManager sharedInstance] startScan:array];
}
- (void)didDiscoverPeripheral:(CSRPeripheral *)peripheral {
    if (![self foundDevice:peripheral.peripheral.identifier]) {
        [self.devices addObject:peripheral];
        self.chosenPeripheral = peripheral;
        
        if (![self.chosenPeripheral isConnected]) {
            NSLog(@"isNotConnected");
             [[CSRConnectionManager sharedInstance] connectPeripheral:self.chosenPeripheral];
            
        }else{
           NSLog(@"isConnected");
        }
    }
     NSLog(@"devices==%@ chosenPeripheralName== %@ \n mac=%@ ",self.devices,self.chosenPeripheral.peripheral.name,[peripheral.advertisementData objectForKey:@"kCBAdvDataManufacturerData"]);
    
    if (self.devices.count == 2) {
        [[CSRConnectionManager sharedInstance] stopScan];//新加的
    }
}
- (void)discoveredPripheralDetails {
    CSRPeripheral *second = self.secondPeripherals.firstObject;
    NSLog(@"secondName ==%@\nchosenName==%@",second.peripheral.name,self.chosenPeripheral.peripheral.name);
    if (self.secondPeripherals.count > 0) {
        for (CBService *service in second.peripheral.services) {
           
            if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
                
                NSLog(@"%@更新第二个耳机\n%@",self.chosenPeripheral.peripheral, second.peripheral);
            }
        }
        
        return;
    }
    for (CBService *service in self.chosenPeripheral.peripheral.services) {
        NSLog(@"services==%@",service);
        if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
            
            NSLog(@"发现了服务\n%@",self.chosenPeripheral.peripheral);
        }
    }
}
-(void)secondClick{
    NSLog(@"%@%@\nother==%@\ndevice=%@\nchosen=%@",self.myPeripheral.name,self.myPeripheral,self.otherPeripherals.firstObject,self.devices,self.chosenPeripheral.peripheral.name);
    
    for (CSRPeripheral * secondPeri in self.devices) {
        if (![secondPeri.peripheral.name isEqualToString:self.chosenPeripheral.peripheral.name]) {
            [self.secondPeripherals addObject:secondPeri];
        }
    }
    
    CSRPeripheral *second = self.secondPeripherals.firstObject;
    NSLog(@"second ==%@",second);
    
    if (![second isConnected]) {
        NSLog(@"secondIsNotConnected");
        [[CSRConnectionManager sharedInstance] connectPeripheral:second];
        
    }else{
        NSLog(@"secondisConnected");
    }
    
}


-(void)getTextView{
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    [self setupTextView];
}
- (void)setupTextView{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
                                                                        
}

-(void)setTextView{
    CLTextView *textView = [[CLTextView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width, 30)];
    textView.backgroundColor = [UIColor redColor];
    //    textView.placeholder = @"ws1111111111111";
    textView.delegate = self;
    [self.view addSubview:textView];
    // textView.text = @"试试会不会调用文本改变的代理方法"; // 不会调用文本改变的代理方法
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:@"富文本"];
    
    // self.textView = textView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(CLTextView *)textView // 此处取巧，把代理方法参数类型直接改成自定义的WSTextView类型，为了可以使用自定义的placeholder属性，省去了通过给控制器WSTextView类型属性这样一步。
{
    if (textView.hasText) { // textView.text.length
        textView.placeholder = @"";
        
    } else {
        textView.placeholder = @"请输入内容";
        
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
