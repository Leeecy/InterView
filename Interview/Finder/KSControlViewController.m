//
//  KSControlViewController.m
//  Interview
//
//  Created by kiss on 2019/8/22.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSControlViewController.h"

#import "KSControlFirstCell.h"
#import "KSControlViewCell.h"

@interface KSControlViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation KSControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor colorWithHexString:@"#191919"];
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.myTableView registerClass:[KSControlFirstCell class] forCellReuseIdentifier:kCellIdentifier_KSControlFirstCell];
     [self.myTableView registerClass:[KSControlViewCell class] forCellReuseIdentifier:kCellIdentifier_KSControlViewCell];
    self.myTableView.backgroundColor =[UIColor colorWithHexString:@"#191919"];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;

//    self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.myTableView.tableHeaderView = [self setHeaderView];
    [self.view addSubview:self.myTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_KSControlFirstCell forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;// cell点击变灰
        return cell;
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_KSControlViewCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;// cell点击变灰
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
       
    }else {
       
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? [KSControlFirstCell cellHeight]:60;
}



@end
