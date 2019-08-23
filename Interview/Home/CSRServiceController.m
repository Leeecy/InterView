//
//  CSRServiceController.m
//  Interview
//
//  Created by kiss on 2019/8/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CSRServiceController.h"
#import "AppDelegate.h"
#import "UpdateViewController.h"
#import "CSRBusyViewController.h"
#define GaiaServiceUUID                 @"00001100-D102-11E1-9B23-00025B00A5A5"

@interface CSRServiceController ()
@property (nonatomic,strong) NSDictionary *supportedServices;
@property (nonatomic,strong) NSMutableArray *services;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
@property (assign, nonatomic) BOOL isVisible;
@property (nonatomic) BOOL dataEndPointResponse;
@property (nonatomic) BOOL isDataEndPointAvailabile;
@end

static NSString * const reuseIdentifier = @"Cell";
@implementation CSRServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.services = [NSMutableArray array];
    
    self.supportedServices = @{ GaiaServiceUUID:
                                    @[@"Update Service", @"This service can update the software on the connected device."]};
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.tableView addSubview:self.refreshControl];
    self.activityIndicatorView = [[UIActivityIndicatorView alloc]
                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicatorView.center = self.view.center;
    [self.navigationController.visibleViewController.view addSubview:self.activityIndicatorView];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@" "
                                             style:UIBarButtonItemStylePlain
                                             target:nil
                                             action:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.isVisible = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHex:@"#2b5791"]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.isDataEndPointAvailabile = false;
    self.dataEndPointResponse = false;

    [[CSRConnectionManager sharedInstance] addDelegate:self];
    
    if (self.chosenPeripheral) {
        self.title = self.chosenPeripheral.peripheral.name;
        
        if (![self.chosenPeripheral isConnected]) {
            [self.services removeAllObjects];
            [self.tableView reloadData];
            [self.activityIndicatorView startAnimating];
            [[CSRConnectionManager sharedInstance] connectPeripheral:self.chosenPeripheral];
//            self.noServicesMessage = NO;
        } else {
            [self.services removeAllObjects];
            [self.tableView reloadData];
            [self discoveredPripheralDetails];
        }
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [[CSRConnectionManager sharedInstance] removeDelegate:self];
    self.isVisible = NO;
    [super viewWillDisappear:animated];
}
#pragma mark CSRConnectionManagerDelegate methods

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
- (void)discoveredPripheralDetails{
    for (CBService *service in self.chosenPeripheral.peripheral.services) {
        if ([self.supportedServices objectForKey:service.UUID.UUIDString]) {
            [self.services addObject:service];
            
            [CSRGaiaManager sharedInstance].delegate = self;
            [[CSRGaiaManager sharedInstance] connect];
            [[CSRGaia sharedInstance]
             connectPeripheral:[CSRConnectionManager sharedInstance].connectedPeripheral];
        }
    }
    
    [self.activityIndicatorView stopAnimating];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.services.count;
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj = [self.services objectAtIndex:indexPath.row];
    NSLog(@"services===%@",self.services);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    if ([obj isKindOfClass:[CBService class]]){
        CBService *service = obj;
        NSArray *info = [self.supportedServices objectForKey:service.UUID.UUIDString];
        if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
            [CSRGaiaManager sharedInstance].delegate = self;
            [[CSRGaiaManager sharedInstance] connect];
            [[CSRGaiaManager sharedInstance] setDataEndPointMode:true];
             cell.backgroundColor = [UIColor colorFromHex:@"#7e57c2"];
            cell.textLabel.text = [info objectAtIndex:0];
            cell.detailTextLabel.text = [info objectAtIndex:1];
        }
    }
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = [self.services objectAtIndex:indexPath.row];
    
    if ([obj isKindOfClass:[CBService class]]){
        CBService *service = obj;
        if ([service.UUID.UUIDString isEqualToString:GaiaServiceUUID]) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

            if (!appDelegate.updateInProgress) {
                
                if (self.dataEndPointResponse) {
                    UpdateViewController *update = [UpdateViewController new];
                    update.isDataEndpointAvailable = self.isDataEndPointAvailabile;
                    [self.navigationController pushViewController:update animated:YES];
                }else{
                    UIAlertController *alert = [UIAlertController
                                                alertControllerWithTitle:@"Waiting for response"
                                                message:@"Waiting for capabilities response from device."
                                        preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [CSRGaiaManager sharedInstance].delegate = self;
                                                   [[CSRGaiaManager sharedInstance] abort];
                                               }];

                    [alert addAction:okButton];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
            } else {
                NSLog(@"跳到更新页面");
                UpdateViewController *update = [UpdateViewController new];
                [self.navigationController pushViewController:update animated:YES];
            }
        }
    }
}
- (CBDescriptor *)findDescriptor:(NSArray *)array matching:(NSString *)matching {
    for (CBDescriptor *descriptor in array) {
        if ([descriptor.UUID.UUIDString isEqualToString:matching]) {
            return descriptor;
        }
    }
    
    return nil;
}
//- (void)didAbortWithError:(NSError *)error {
//    UIAlertController *alert = [UIAlertController
//                                alertControllerWithTitle:@"Setting Alert Failed"
//                                message:error.localizedDescription
//                                preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okButton = [UIAlertAction
//                               actionWithTitle:@"OK"
//                               style:UIAlertActionStyleDefault
//                               handler:nil];
//    
//    [alert addAction:okButton];
//    [self presentViewController:alert animated:YES completion:nil];
//}

- (void)didReceiveGaiaGattResponse:(CSRGaiaGattCommand *)command {
    GaiaCommandType cmdType = [command getCommandId];
    NSData *requestPayload = [command getPayload];
    uint8_t success = 0;
    
    [requestPayload getBytes:&success range:NSMakeRange(0, sizeof(uint8_t))];
    if (cmdType == GaiaCommand_SetDataEndPointMode && requestPayload.length > 0) {
        uint8_t value = 0;
        [requestPayload getBytes:&value range:NSMakeRange(0, sizeof(uint8_t))];
        
        if (value == GaiaStatus_Success) {
            self.isDataEndPointAvailabile = true;
        } else {
            self.isDataEndPointAvailabile = false;
        }

        self.dataEndPointResponse = true;
//        [self.tableView reloadData];
        
    }
    
    
}
-(void)didUpdateStatus:(NSString *)value{
    [[CSRBusyViewController sharedInstance] setStatus:value];
}

- (void)didAbortUpgrade {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.updateInProgress = NO;
    appDelegate.updateFileName = nil;
    
    [CSRGaiaManager sharedInstance].updateInProgress = NO;
//    [self performSegueWithIdentifier:@"updateFileSegue" sender:nil];
}
-(void)didAbortWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Update Aborted"
                                message:error.localizedDescription
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   [CSRGaiaManager sharedInstance].delegate = self;
                                   [[CSRGaiaManager sharedInstance] abort];
                               }];
    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
