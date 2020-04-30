//
//  BLETestViewController.m
//  Interview
//
//  Created by kiss on 2020/4/30.
//  Copyright © 2020 cl. All rights reserved.
//

#import "BLETestViewController.h"
#import "CLBLEManager.h"
#import "MBProgressHUD+Extension.h"
@interface BLETestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic)   NSMutableArray  *deviceArray;  /**< 蓝牙设备个数 */
@property(nonatomic,strong)CLBLEManager *manager;
@end

@implementation BLETestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙列表";
     _deviceArray = [[NSMutableArray alloc] init];
    
    CLBLEManager *manager = [CLBLEManager sharedInstance];
    __weak CLBLEManager *weakManager = manager;
    manager.stateUpdateBlock = ^(CBCentralManager *central) {
        NSString *info = nil;
        switch (central.state){
            case CBCentralManagerStatePoweredOn:{
                info = @"蓝牙已打开，并且可用";
                
            }break;
            case CBManagerStateUnknown: {
                info = @"CBCentralManagerStateUnknown";
               
            } break;
            case CBManagerStateResetting: {
                 info = @"CBCentralManagerStateResetting";
               
            } break;
            case CBManagerStateUnsupported: {
                info = @"SDK不支持";
                
            }break;
            case CBManagerStateUnauthorized: {
               info = @"程序未授权";
               
            } break;
            case CBManagerStatePoweredOff: {
                info = @"蓝牙可用，未打开";
            }break;
        }
        
        [MBProgressHUD showAutoMessage:info toView:self.view];
    };
    
     self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBHOMECELLID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WBHOMECELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = COLOR_WHITE;
        cell.contentView.backgroundColor = COLOR_WHITE;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
@end
