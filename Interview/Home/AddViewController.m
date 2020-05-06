//
//  AddViewController.m
//  Interview
//
//  Created by cl on 2020/3/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import "AddViewController.h"
#import "CLAddHeaderCollectionCell.h"
#import "KSBatteryModel.h"
#import "InterScaleViewController.h"
#import "UIViewController+HHTransition.h"
@interface AddViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning,CLAddHeaderCellDelegate>
@property(strong,nonatomic)UILabel *myHead;

@property(assign,nonatomic)NSInteger ItemCount;
@property(nonatomic,copy)NSArray *arr;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)CLAddHeaderCollectionCell *addCell;
@end

@implementation AddViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.ItemCount = 3;
    self.view.backgroundColor = [UIColor blackColor];
    self.arr = @[@"图层 2530 拷贝",@"图层 2565",@"图层 2566"];
//    self.navigationController.delegate = self;
    [self setupUI];
    [self setupColl];
    [self setupBottomBtn];
}
-(void)setupUI{
    self.myHead = [[UILabel alloc]initWithFrame:CGRectMake(18, 100, 100, 20)];
    self.myHead.textColor = [UIColor whiteColor];
    self.myHead.font = [UIFont systemFontOfSize:18];
    self.myHead.text = NSLocalizedString(@"我的耳机", nil);
    [self.view addSubview:self.myHead];
}

-(void)setupColl{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    CGFloat topHeight;
    topHeight =  iPhoneX ? 200:140;
    _collectionView.frame = CGRectMake(0, topHeight, ScreenWidth, ScreenHeight - topHeight -100 );
    _collectionView.showsVerticalScrollIndicator = NO;        //注册
    self.collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CLAddHeaderCollectionCell class] forCellWithReuseIdentifier:identifier_CLAddHeaderCollectionCell];
    [self.view addSubview:_collectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)setupBottomBtn{
    UIButton *cancelButton = [[UIButton alloc] init];
    [self.view addSubview:cancelButton];
    [cancelButton setTitle:NSLocalizedString(@"+添加新耳机", nil)  forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 16 拷贝 2"] forState:(UIControlStateNormal)];
    [cancelButton setTitleColor:[UIColor colorFromHexStr:@"#FFFFFF"] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    cancelButton.layer.cornerRadius = 3;
//    cancelButton.layer.maskedCorners = YES;
    [cancelButton addTarget:self action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat bottomHeight;
    bottomHeight =  iPhoneX ? 100:60;
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-bottomHeight);
      make.size.mas_equalTo(CGSizeMake(236, 31));
    }];
}
-(IBAction)addClicked:(UIButton*)sender{
    self.ItemCount = self.ItemCount+1;
    [self.collectionView reloadData];
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.ItemCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     CLAddHeaderCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_CLAddHeaderCollectionCell forIndexPath:indexPath];
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.headerName.text = self.arr[indexPath.item];
    cell.headerImg.image = [UIImage imageNamed:self.arr[indexPath.item]];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth )/2, (ScreenWidth )/2);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"item==%ld",indexPath.item);

//    CLAddHeaderCollectionCell *cell = (CLAddHeaderCollectionCell*)[self.collectionView cellForItemAtIndexPath:self.indexPath];
//    NSLog(@"cell===%@===",cell.headerName.text);
//    [self.navigationController pushViewController:interScale animated:YES];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 3) ? 0 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

#pragma mark - UIViewControllerAnimatedTransitioning
// MARK: 设置代理
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSLog(@"----from==%@ ---tovc==%@",fromVC,toVC);
    return self;
}

//// MARK: 设置动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
-(void)cellDidClick:(CLAddHeaderCollectionCell *)cell{
    self.addCell = cell;
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];
    
      CLAddHeaderCollectionCell *cell1 =  (CLAddHeaderCollectionCell*)[self.collectionView cellForItemAtIndexPath:index];
    NSLog(@"进去的cell---%@",cell1.headerName.text);
    
    cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
    InterScaleViewController *interScale = [InterScaleViewController new];
    interScale.bgImage = [self imageFromView];
    interScale.addCell = cell;
    interScale.selectIndexPath = index;
    interScale.headerName = self.arr[index.item];
    interScale.imageName = @"WechatIMG14";
    interScale.bottomName = @"bottom_bg";
    [self.navigationController pushViewController:interScale animated:YES];
    NSLog(@"点击进去的cell===%@",self.addCell.headerName.text);
}
- (UIImage *)imageFromView {
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"cell===%@",self.addCell.headerName.text);
     NSIndexPath *index = [self.collectionView indexPathForCell:self.addCell];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC valueForKeyPath:@"headerImageView"];
    UIView *fromView = self.addCell.bgImage;
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapShotView = [[UIImageView alloc]initWithImage:self.addCell.bgImage.image];
    
     snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    
    fromView.hidden = YES;
    
    //跳转过程切圆角
    snapShotView.layer.cornerRadius  = 10;
    snapShotView.layer.masksToBounds = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toView.hidden = YES;
    
    
//耳机图片
    UIImageView * earImage = [[UIImageView alloc]init];
    earImage.image = [UIImage imageNamed:self.arr[index.item]];
    earImage.contentMode = UIViewContentModeScaleAspectFit;
    [snapShotView addSubview:earImage];
        CGFloat headTop = iPhoneX ? 180 : 140;
    [earImage mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(snapShotView.mas_centerX);
       make.size.mas_equalTo(CGSizeMake(126, 192));
       make.top.equalTo(snapShotView.mas_top).offset(headTop);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"frame==%@  %@ %@",NSStringFromCGRect(earImage.frame),NSStringFromCGRect(snapShotView.frame),NSStringFromCGRect(containerView.frame));
    });
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
//           [containerView layoutIfNeeded];
//           toVC.view.alpha = 1.0f;
//           snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
//
//       } completion:^(BOOL finished) {
//           toView.hidden = NO;
//           fromView.hidden = NO;
//           [snapShotView removeFromSuperview];
//           [self.collectionView reloadData];
//           [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//       }];
    
    [UIView animateWithDuration:1 animations:^{
        [containerView layoutIfNeeded];
                 toVC.view.alpha = 1.0f;
                 snapShotView.frame = [containerView convertRect:toView.frame fromView:toView.superview];
//         [earImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(snapShotView.mas_centerX);
//            make.size.mas_equalTo(CGSizeMake(126, 192));
//            make.top.equalTo(snapShotView.mas_top).offset(headTop);
//         }];
        
    } completion:^(BOOL finished) {
        toView.hidden = NO;
        fromView.hidden = NO;
        [snapShotView removeFromSuperview];
        [self.collectionView reloadData];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
