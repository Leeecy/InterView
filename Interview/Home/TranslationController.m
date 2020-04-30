//
//  TranslationController.m
//  Interview
//
//  Created by kiss on 2020/4/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TranslationController.h"
#import "TransViewCell.h"
#import "TransDetailViewController.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds
#define SCREEN_RATIO(x) (x*(SCREEN_WIDTH/375.0))
#define COLOR_CLEAR [UIColor clearColor]
#define FONT_B(x)   [UIFont boldSystemFontOfSize:x]
@interface TranslationController ()<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImageView *bottomImg;
@property (strong, nonatomic) NSMutableArray *dataSource;       // 图片数组
@property (strong, nonatomic) NSMutableArray *titles;           // 主标题数组
@property (strong, nonatomic) NSMutableArray *titleTwos;        // 副标题数组
@property (strong, nonatomic) NSMutableArray *contents;         // 内容数组
@property (strong, nonatomic) UIView *headerView;               // 头部
@property (strong, nonatomic) UILabel *timeLabel;               // 时间
@property (strong, nonatomic) UILabel *titleLabel;              // Today
@property (strong, nonatomic) UIButton *userButton;             //
@end

@implementation TranslationController{
    NSIndexPath *selectIndexPath;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 设置navigaitonControllerDelegate
    self.navigationController.delegate = self;
    // 隐藏状态栏
    [UIView animateWithDuration:0.2 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
       
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
//    [self test];
    [self initData];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self buildHeaderView];
    
    
    [self getCell];
}
- (void)userButtonClick {
    
}
- (UIImage *)imageFromView {
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
- (void)initData {
    [self.dataSource addObjectsFromArray:@[@"Home_demo_01",@"Home_demo_02",@"Home_demo_03"]];
    [self.titles addObject:@"哈弗H6Coupe震撼上市"];
    [self.titles addObject:@"黑天鹅蛋糕 "];
    [self.titles addObject:@"高端入驻园区"];
    [self.titleTwos addObject:@"体验“中国芯”动力新 Coupe"];
    [self.titleTwos addObject:@"“我的一生，为美而存在”"];
    [self.titleTwos addObject:@"让运动助生活"];
    [self.contents addObject:@"技及尊享兼备的体验。"];
    [self.contents addObject:@"一兆韦德健身管，拥有超所。更多力量。"];
    [self.contents addObject:@"黑天鹅隶属于北京黑天鹅耳目一新。"];

}
- (UIView *)buildHeaderView {
    
    // header
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 115);
    // 日期
    self.timeLabel.frame  = CGRectMake(SCREEN_RATIO(22), 30, SCREEN_WIDTH/2, 14);
//    self.timeLabel.text = [self getWeekDay];
    // 标题
    self.titleLabel.frame = CGRectMake(SCREEN_RATIO(22),55 , (SCREEN_WIDTH/3)*2, 30);
    
    // 登录按钮
    self.userButton.frame = CGRectMake(SCREEN_WIDTH-44-SCREEN_RATIO(22), 38, 44, 44);
    self.userButton.layer.masksToBounds = YES;
    self.userButton.layer.cornerRadius = 22;
    [self.userButton addTarget:self action:@selector(userButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.userButton setImage:[UIImage imageNamed:@"Mine_photo_define"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.timeLabel];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.userButton];
    
    return self.headerView;
}

-(void)getCell{
     TransViewCell *cell = (TransViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    NSLog(@"cell===%@",cell);
}
-(void)test{
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
    [self.view addSubview:bottomV];

    UIImageView *img = [[UIImageView alloc]initWithFrame:bottomV.bounds];
    self.bottomImg = img;
    img.image = [UIImage imageNamed:@"bottom_bg"];
    [bottomV addSubview:self.bottomImg];

    [UIView animateWithDuration:0.5 animations:^{
        bottomV.frame = CGRectMake(0, ScreenHeight-260, ScreenWidth, 260);
    } completion:^(BOOL finished) {

    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (SCREEN_WIDTH-40)*1.3+25;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOMECELLID"];
    if (cell == nil) {
        cell = [[TransViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HOMECELLID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldGroupAccessibilityChildren = YES;
    }
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.contentLabel.text = self.titleTwos[indexPath.row];
    cell.bgimageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.transform = CGAffineTransformMakeScale(1, 1);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TransViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    TransDetailViewController *detail = [[TransDetailViewController alloc]init];
    detail.selectIndexPath = indexPath;
    detail.bgImage = [self imageFromView];
    detail.titles = self.titles[indexPath.row];
    detail.titleTwo = self.titleTwos[indexPath.row];
    detail.content = self.contents[indexPath.row];
    detail.imageName = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
// MARK: 设置代理
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self;
}
//// MARK: 设置动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    TransViewCell *cell = (TransViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
    NSLog(@"cell==%@",cell);
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC valueForKeyPath:@"headerImageView"];
    UIView *fromView = cell.bgView;
    UIView *containerView = [transitionContext containerView];
    UIView *snapShotView = [[UIImageView alloc]initWithImage:cell.bgimageView.image];
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    fromView.hidden = YES;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0f;
        snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self.tableView reloadData];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_CLEAR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = COLOR_CLEAR;
        
    }
    return _headerView;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
//        _timeLabel.font = FONT_14;
//        _timeLabel.textColor = COLOR_6;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = FONT_B(30);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"Today";
    }
    return _titleLabel;
}

- (UIButton *)userButton {
    if (_userButton == nil) {
        _userButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _userButton.backgroundColor = COLOR_CLEAR;
    }
    return _userButton;
}

- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

- (NSMutableArray *)titleTwos {
    if (_titleTwos == nil) {
        _titleTwos = [[NSMutableArray alloc]init];
    }
    return _titleTwos;
}

- (NSMutableArray *)contents {
    if (_contents == nil) {
        _contents = [[NSMutableArray alloc]init];
    }
    return _contents;
}
@end
