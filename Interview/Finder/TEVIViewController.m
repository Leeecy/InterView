//
//  TEVIViewController.m
//  Interview
//
//  Created by kiss on 2019/8/22.
//  Copyright © 2019 cl. All rights reserved.
//

#import "TEVIViewController.h"

#import "KSHomeViewCell.h"
#import "KSSettingsViewController.h"
#import "SXCircleView.h"

#import "KSAreaButton.h"
#import "KSControlViewController.h"
#define TOPMagin 100 //
#define VolumeNum (240/15) //16音量0-f

@interface TEVIViewController ()<UITableViewDataSource,UITableViewDelegate>{
    int _currentAngle;
    int _originVolume;
}
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property(strong,nonatomic)SXCircleView *circleView;

@property(nonatomic,strong)NSArray *volumeArr;
@end

@implementation TEVIViewController

#pragma mark -
#pragma mark life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]initWithObjects:@"SOUND",@"CONTROL",@"SETTINGS", nil];
    self.volumeArr = @[@(-210), @(-194), @(-178),@(-162),@(-146),@(-130), @(-114), @(-98),@(-82),@(-66),@(-50), @(-34), @(-18),@(-2),@(14),@(30)];
    
    self.view.backgroundColor =  [UIColor colorWithHexString:@"#191919"];
     [self setupTable];
}

#pragma mark -
#pragma mark init UI
-(void)setupTable{
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.myTableView registerClass:[KSHomeViewCell class] forCellReuseIdentifier:kCellIdentifier_KSHomeViewCell];
    self.myTableView.backgroundColor =[UIColor colorWithHexString:@"#191919"];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
//    self.myTableView.backgroundView = [UIColor clearColor];
//    self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, HSTitilesViewY, 0);
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.tableHeaderView = [self setHeaderView];
    [self.view addSubview:self.myTableView];
}

-(UIView*)setHeaderView{
    UIView * headerView;
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, ScreenHeight - 74 -44*3 -40)];
//    headerView.backgroundColor = [UIColor lightGrayColor];
    UIImageView *logoV = [[UIImageView alloc]init];
    logoV.image = [UIImage imageNamed:@"pc_logo"];
    [headerView addSubview:logoV];
    [logoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(45);
        make.right.mas_equalTo(headerView).offset(-23);
        make.size.mas_equalTo(CGSizeMake(51, 29));
    }];
    
    self.circleView = [[SXCircleView alloc]initWithFrame:CGRectMake(23,100, ScreenWidth -23*2, ScreenWidth -23*2) lineWidth:2 circleAngle:240 imageName:@"qian"];
    [headerView addSubview:self.circleView];
    
    self.circleView.angle = -210 + _originVolume * VolumeNum;
    
    _currentAngle = self.circleView.angle;
    [self.circleView addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
    [self.circleView addTarget:self action:@selector(touchValue:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //耳机图片
    UIImageView *headImg = [[UIImageView alloc]init];
    headImg.image = [UIImage imageNamed:@"pc_img"];
    headImg.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(195, 177));
        make.top.equalTo(headerView.mas_top).offset(150);
    }];
    
    //+ - 按钮
    KSAreaButton *subBtn = [[KSAreaButton alloc]init];
    [subBtn setImage:[UIImage imageNamed:@"ic_-"] forState:(UIControlStateNormal)];
    [subBtn addTarget:self action:@selector(subClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:subBtn];
    //    subBtn.backgroundColor = [UIColor redColor];
    [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(headerView.mas_top).offset(368);
    }];
    
    KSAreaButton *addBtn = [[KSAreaButton alloc]init];
    [addBtn setImage:[UIImage imageNamed:@"ic_+"] forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).offset(-50);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.top.equalTo(subBtn.mas_top);
    }];
    
    UILabel *headL = [[UILabel alloc]init];
    headL.text = @"TEVI";
    headL.textAlignment = NSTextAlignmentCenter;
    headL.font = [UIFont fontWithName:@"ArialMT" size:62];
    headL.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [headerView addSubview:headL];
    
    [headL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(406);
        make.right.equalTo(headerView.mas_right).offset(-24);
        make.size.mas_equalTo(CGSizeMake(140, 48));
    }];
    
    return headerView;
}
- (void) newValue:(SXCircleView*)slider{
    _currentAngle = slider.angle;
    _currentAngle = (int)[self getMinValueShowLevel:self.volumeArr mapZoomLevel:_currentAngle];
    [self.circleView changeAngle:_currentAngle];
    [self.circleView setNeedsDisplay];
    NSLog(@"newValue:%d",_currentAngle);
    //    [self writeDataWtihAngle:_currentAngle];
}
-(void)touchValue:(SXCircleView*)slider{
    _currentAngle = slider.angle;
    _currentAngle = (int)[self getMinValueShowLevel:self.volumeArr mapZoomLevel:_currentAngle];
    NSLog(@"touchValue:%d",_currentAngle);
    [self.circleView changeAngle:_currentAngle];
//    [self writeDataWtihAngle:_currentAngle];
    [self.circleView setNeedsDisplay];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_KSHomeViewCell forIndexPath:indexPath];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;// cell点击变灰
    cell.titleL.text = self.dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        KSSettingsViewController *set = [[KSSettingsViewController alloc]init];
        [self.navigationController pushViewController:set animated:YES];
    }else if (indexPath.row == 1){
        KSControlViewController *control = [[KSControlViewController alloc]init];
        [self.navigationController pushViewController:control animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
#pragma mark -
#pragma mark response methods
-(IBAction)addClick:(UIButton*)sender{
    _currentAngle = _currentAngle + VolumeNum;
    [self.circleView changeAngle:_currentAngle];
    if (_currentAngle > 30) {
        _currentAngle = 30;
        return;
    }
    NSLog(@"addcurrentAngle:%d",_currentAngle);
    //写入蓝牙数据
//    [self writeDataWtihAngle:_currentAngle];
}

-(IBAction)subClick:(UIButton*)sender{
    _currentAngle = _currentAngle - VolumeNum;
    [self.circleView changeAngle:_currentAngle]; //--_currentAngle
    if (_currentAngle < -210) {
        _currentAngle = -210;
        return;
    }
    NSLog(@"subcurrentAngle:%d",_currentAngle);
//    [self writeDataWtihAngle:_currentAngle];
}

- (NSInteger)getMinValueShowLevel:(NSArray *)showLevels mapZoomLevel:(CGFloat)mapZoomLevel{
    NSInteger suitValue = (int)mapZoomLevel;
    NSInteger diffLevel = 9999;
    for (NSNumber *showLevel in showLevels) {
        NSInteger diffLevelTmp = fabs(mapZoomLevel - [showLevel intValue]);
        if (diffLevelTmp < diffLevel) {
            diffLevel = diffLevelTmp;
            suitValue = [showLevel intValue];
        }
    }
    return suitValue;
}
@end
