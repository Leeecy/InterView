//
//  DeviceTableController.m
//  Interview
//
//  Created by kiss on 2019/8/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "DeviceTableController.h"
#import "AppDelegate.h"
#import "CSRDeviceTableViewCell.h"

#import "CSRServiceController.h"

@interface DeviceTableController ()
@property (nonatomic) NSMutableArray *devices;
@property (nonatomic) CSRPeripheral *chosenPeripheral;
@end

@implementation DeviceTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshDevices:) forControlEvents:UIControlEventValueChanged];
    
    self.devices = [NSMutableArray array];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSRDeviceTableViewCell" bundle:nil] forCellReuseIdentifier:DeviceCellIdentifier];
    self.refreshControl = refreshControl;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHex:@"#2b5791"]];
    [self.devices removeAllObjects];
    [self.tableView reloadData];
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

- (void)refreshDevices:(UIRefreshControl*)sender {
    [self.devices removeAllObjects];
    CBUUID *deviceInfoUUID = [CBUUID UUIDWithString:@"AE86"];
    NSArray *array = @[deviceInfoUUID];
    [[CSRConnectionManager sharedInstance] stopScan];
    [[CSRConnectionManager sharedInstance] startScan:array];
    
    CSRPeripheral *peripheral = [CSRConnectionManager sharedInstance].connectedPeripheral;
    
    if (peripheral && peripheral.peripheral && peripheral.peripheral.state == CBPeripheralStateConnected) {
        if (![self foundDevice:peripheral.peripheral.identifier]) {
            [self.devices addObject:peripheral];
        }
    }   
    [self.refreshControl endRefreshing];
//    [self.tableView reloadData];
}

#pragma mark CSRConnectionManager delegate methods

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
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)didDiscoverPeripheral:(CSRPeripheral *)peripheral {
    NSLog(@"来了一次%@",peripheral.peripheral.name);
    if (![self foundDevice:peripheral.peripheral.identifier]) {
        [self.devices addObject:peripheral];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devices.count;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CSRPeripheral *peripheral = [self.devices objectAtIndex:indexPath.row];
    
    self.chosenPeripheral = peripheral;
    
    return indexPath;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     CSRPeripheral *peripheral = (CSRPeripheral *)[self.devices objectAtIndex:indexPath.row];
    CSRDeviceTableViewCell *cell = [tableView
                                    dequeueReusableCellWithIdentifier:DeviceCellIdentifier];
    if ([peripheral.peripheral isEqual:[CSRConnectionManager sharedInstance].connectedPeripheral.peripheral]) {
        cell.backgroundColor = [UIColor colorFromHex:@"#8bc34a"]; // Green
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    NSArray *array = [peripheral.advertisementData objectForKey:@"kCBAdvDataServiceUUIDs"];
    NSInteger servicesCount = array ? array.count : peripheral.peripheral.services.count;
    NSString *deviceName = [peripheral.advertisementData objectForKey:@"kCBAdvDataLocalName"];
    cell.deviceNameLabel.text = deviceName ? deviceName : peripheral.peripheral.name;
    
    if (servicesCount > 1) {
        cell.serviceCountLabel.text = [NSString stringWithFormat:@"%lu Services available",
                                       (unsigned long)servicesCount];
    } else {
        cell.serviceCountLabel.text = [NSString stringWithFormat:@"%lu Service available",
                                       (unsigned long)servicesCount];
    }
    
    cell.rssiLevelLabel.text = [NSString stringWithFormat:@"%@ db",
                                [peripheral.signalStrength stringValue]];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSRPeripheral *peripheral = [self.devices objectAtIndex:indexPath.row];
    
    self.chosenPeripheral = peripheral;
    if ([peripheral.peripheral
         isEqual:[CSRConnectionManager sharedInstance].connectedPeripheral.peripheral]) {
        
        CSRServiceController *service =  [[CSRServiceController alloc]init];
        service.chosenPeripheral =  [CSRConnectionManager sharedInstance].connectedPeripheral;;
        [self.navigationController pushViewController:service animated:YES];
        
    } else {
        CSRServiceController *service =  [[CSRServiceController alloc]init];
        service.chosenPeripheral = peripheral;
        [self.navigationController pushViewController:service animated:YES];
    }
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
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
