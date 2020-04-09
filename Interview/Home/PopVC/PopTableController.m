//
//  PopTableController.m
//  Interview
//
//  Created by kiss on 2019/9/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import "PopTableController.h"

@interface PopTableController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation PopTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"失败弹窗" class:@"Pop1ViewController"];
    [self addCell:@"成功弹窗" class:@"Pop2ViewController"];
    [self addCell:@"进度条" class:@"Pop3ViewController"];
    [self addCell:@"圆形进度条" class:@"Pop4ViewController"];
    [self addCell:@"带背景图的成功弹窗" class:@"Pop5ViewController"];
    [self addCell:@"gif" class:@"GifViewController"];
    [self addCell:@"按键弹窗" class:@"KeyPopViewController"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLPOP"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CLPOP"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
