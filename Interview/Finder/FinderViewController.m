
//
//  FinderViewController.m
//  Interview
//
//  Created by cl on 2019/7/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import "FinderViewController.h"
#import "SwitchViewController.h"
@interface FinderViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"Block测试" class:@"BlockViewController"];
    [self addCell:@"TEVI" class:@"TEVIViewController"];
    [self addCell:@"测试Switch" class:@"SwitchViewController"];
    [self.tableView reloadData];
}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CL"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if ([class isEqual:[SwitchViewController class]]) {
        SwitchViewController *switch1 = [[SwitchViewController alloc]init];
        switch1.vocieTipBlock = ^(BOOL isOpen) {
            if (isOpen) {
                NSLog(@"isOpne");
            }else{
                NSLog(@"close");
            }
        };
        [self.navigationController pushViewController:switch1 animated:YES];
        return;
    }
    
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        if ([ctrl.title isEqualToString:@"测试Switch"]) {
            
        }
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
