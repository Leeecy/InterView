//
//  DetailPopViewController.m
//  Interview
//
//  Created by kiss on 2020/5/5.
//  Copyright © 2020 cl. All rights reserved.
//

#import "DetailPopViewController.h"
#import "KSTitleButton.h"
#import "SliderViewController.h"
#import "SXCircleView.h"
@interface DetailPopViewController ()<KSTitleButtonDelegate>
@property(nonatomic,strong)UIImageView *bottomImg;
@property (strong, nonatomic) UIView *bottomView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)SXCircleView *circleView;
@property (strong, nonatomic) UIImageView *earImage;
@property(nonatomic,strong)UIView *midView;
@end

@implementation DetailPopViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat TOPMagin = iPhoneX ? 120 :60 ;//
    self.titleArray = @[NSLocalizedString(@"按键设置", nil),NSLocalizedString(@"通用设置", nil),NSLocalizedString(@"EQ", nil),NSLocalizedString(@"固件更新", nil)] ;
    self.midView = [[UIView alloc]init];
        
        CGRect beginFrame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
    self.midView.frame = beginFrame;
    [self.view addSubview:self.midView];
    
    [self.midView addSubview:self.imageView];
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.midView);
//    }];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self.view addGestureRecognizer:tap];
    
    CGFloat volumeCircleWidth = 275;
    CGFloat circleYTop = iPhoneX ? 140 : 100;
       
       CGFloat circleX = (ScreenWidth - volumeCircleWidth -20*2)*0.5;
    [UIView animateWithDuration:1 animations:^{
        self.circleView = [[SXCircleView alloc]initWithFrame:CGRectMake(circleX,circleYTop, volumeCircleWidth, volumeCircleWidth) lineWidth:2 circleAngle:240 productModel:@"0003" imageWidth:4 ];
        [self.midView addSubview:self.circleView];
    }];
    
    

       self.earImage = [[UIImageView alloc]init];
       self.earImage.image = [UIImage imageNamed:self.headerName];
       self.earImage.contentMode = UIViewContentModeScaleAspectFit;
       [self.midView addSubview:self.earImage];
        CGFloat headTop = iPhoneX ? 180 : 140;
       [self.earImage mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.equalTo(self.midView.mas_centerX);
           make.size.mas_equalTo(CGSizeMake(126, 192));
           make.top.equalTo(self.midView.mas_top).offset(headTop);
       }];
   
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
        [self.view addSubview:bottomV];
        UIImageView *img = [[UIImageView alloc]initWithFrame:bottomV.bounds];
        self.bottomImg = img;
        img.image = [UIImage imageNamed:@"bottom_bg"];
        [bottomV addSubview:self.bottomImg];
        self.bottomView = bottomV;
        
        [UIView animateWithDuration:0.2  animations:^{
           bottomV.frame = CGRectMake(0, ScreenHeight-260, ScreenWidth, 260);
       } completion:^(BOOL finished) {
           
       }];
    
    //右上角删除按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"失败"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(tapAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    
    [UIView animateWithDuration:1  animations:^{
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).offset(-34);
            make.top.equalTo(self.view.mas_top).offset(50);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    } completion:nil];
    
        KSTitleButton *titleV = [[KSTitleButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, 200) TitleArr:self.titleArray LineNumber:2 ColumnsNumber:2 EdgeInsetsStyle:LZHEdgeInsetsStyleTop ImageTitleSpace:5 isUpdate:NO isFemale:NO];
        titleV.delegate = self;
    //    self.titleV = titleV;
        [self.bottomView addSubview:titleV];
}
-(void)tapAction {
    [UIView animateWithDuration:0.2 animations:^{
        [self.earImage removeFromSuperview];
        [self.circleView removeFromSuperview];
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)clickBTnIndex:(KSTitleViewStyle)style Title:(NSString *)title{
    [self.navigationController pushViewController:[SliderViewController new] animated:YES];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.center = self.view.center;
        CGFloat TOPMagin = iPhoneX ? 120 :60 ;
        _imageView.frame = CGRectMake(0, 0, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
//        _imageView.userInteractionEnabled = NO;
        _imageView.layer.cornerRadius  = 20;
        _imageView.layer.masksToBounds = YES;
        
        _imageView.image = [UIImage imageNamed:@"WechatIMG14"];//WechatIMG14
    }
    return _imageView;
}

@end
