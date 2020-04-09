//
//  KSEQSliderViewController.m
//  FastPair
//
//  Created by kiss on 2019/10/8.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSEQSliderViewController.h"

#import "KSEQCustomView.h"
#import "MBProgressHUD+Extension.h"

/****/
@interface KSEQSliderViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)NSMutableArray *values;
@property(strong,nonatomic)NSMutableArray *xArray;
@property(nonatomic,strong)NSMutableArray *array;//自定义EQ数组
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)NSMutableArray *colorArr;
@property(nonatomic,strong)NSMutableArray *titleColor;
@property(nonatomic,strong)NSString *arrPath;
@property(nonatomic,strong)UIButton *customBtn;
@property(nonatomic,assign)BOOL isCustom;
@property(nonatomic,strong)NSArray *customEqFirst;
@property(nonatomic,strong)NSArray *customEqTwo;
@property(nonatomic,strong)NSArray *customEqThree;
@property(nonatomic,strong)NSArray *customEqFour;
@property(nonatomic,strong)NSArray *customEqFive;
@property(nonatomic,assign)int currentCustom;//当前自定义的是第几个
@property (strong, nonatomic) UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong) UIColor *selectTitleColor;
@property(nonatomic,strong)NSMutableArray *selectColorArr;

@property(nonatomic,assign)BOOL isAddEqValue;//判断是否拖动了新的eq

@property(nonatomic,assign)int currentSelect;//记录保存之后选中颜色的是哪一个
@property(nonatomic,strong)UIButton *currentSelectBtn;
@property(nonatomic,strong)UIButton *resetBtn;
@property(nonatomic,assign)NSInteger quitTag;//记录退出之前的tag
@property(nonatomic,strong)UIView  *coverView;
@property(nonatomic,assign)BOOL isCover;//把slider遮住
@property(nonatomic,assign)BOOL isclickOther;//不把slider遮住
@property(nonatomic,strong)UIView  *bypassView;//点击bypass时候的cover遮住slider
@property(nonatomic,assign)int beforeSaveBtn;//保存前是第几个 去掉保存之前的颜色
@property(nonatomic,assign)BOOL isSave;//第一个改变颜色

@end

@implementation KSEQSliderViewController
- (void)viewDidLoad{
    
}
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    self.paraM =[[KSEQParamModel alloc]init];
////    self.paraM.isEnterEqClick = NO;
//    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
//        imgV.image = [UIImage imageNamed:@"set_bg"];
//    [self.view insertSubview:imgV atIndex:0];
//    self.beforeSaveBtn = -8;
//    self.selectTitleColor = [UIColor whiteColor];
//    self.isCustom = NO;
//    self.isCover = NO;
//    self.isclickOther = NO;
//    self.isAddEqValue = NO;
//    self.currentSelect = 0;
//    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"eqslider.plist"];
//    NSArray *arrMain = [NSArray arrayWithContentsOfFile:filePath];
//    self.arrPath = filePath;
//    if (arrMain.count > 0) {
//        self.array = [NSMutableArray arrayWithArray:arrMain];
//    }else{
//        self.array = [NSMutableArray arrayWithObjects:NSLocalizedString(@"Bypass",nil),NSLocalizedString(@"添加新EQ",nil), nil];
//    }
//
//    self.selectColorArr = [NSMutableArray arrayWithObjects:@"default",@"圆角矩形 8 拷贝 8",@"圆角矩形10",@"圆角矩形9",@"圆角矩形 8 拷贝 9",@"圆角矩形拷贝11", nil];
//
//    self.colorArr = [NSMutableArray arrayWithObjects:@"圆角矩形 8",@"圆角矩形 8 拷贝 5",@"圆角矩形 8 拷贝 6",@"圆角矩形 8 拷贝",@"圆角矩形 8 拷贝 2",@"圆角矩形 8 拷贝 4", nil];
//    self.titleColor = [NSMutableArray arrayWithObjects:@"#F29011",@"#7254E7",@"#10C8AF",@"#12B56C",@"#EA5C8A",@"#8A8A8A", nil];
//
//    [self show];
//
//    KSGoBackView *backV = [[KSGoBackView alloc]initWithFirstImg:@"map_back" secondImageName:@"back-logo"];
//    backV.delegate = self;
//    [self.view addSubview:backV];
//    backV.frame = CGRectMake(10, 37, 140, 40);
//
//   /***左上角按钮改 中间固定文字*/
//   UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(50, -60, 100, 30)];
//   title.centerX = self.view.centerX;
//   title.centerY = backV.centerY;
//   title.text = NSLocalizedString(@"EQ設定",nil);
//   title.textAlignment = NSTextAlignmentCenter;
//   title.font = [UIFont systemFontOfSize:24];
//   title.textColor = [UIColor colorFromHexStr:@"#333333"];
//   [self.view addSubview:title];
//
//
//    UIButton *reset = [[UIButton alloc]init];
//    [reset setTitle:NSLocalizedString(@"恢复", nil) forState:(UIControlStateNormal)];
//    reset.hidden = YES;
//    reset.titleLabel.font = [UIFont systemFontOfSize:15];
//    [reset setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:(UIControlStateNormal)];
//    [reset addTarget:self action:@selector(resetClick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:reset];
//    self.resetBtn = reset;
//    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(backV.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(60, 15));
//        make.trailing.equalTo(self.view.mas_trailing).offset(-20);
//    }];
//
//    UIButton *saveBtn = [[UIButton alloc]init];
//    [saveBtn setTitle:NSLocalizedString(@"保存", nil) forState:(UIControlStateNormal)];
//    saveBtn.hidden = YES;
//    saveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [saveBtn setTitleColor:[UIColor colorWithHexString:@"#F38629"] forState:(UIControlStateNormal)];
//    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [saveBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 1"] forState:(UIControlStateNormal)];
//    [self.view addSubview:saveBtn];
//    self.saveBtn = saveBtn;
//    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(200, 32));
//        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
//    }];
//
//    [self setupSlider];
//    [self makeX];
//
//
//
//    CGFloat covertopH = iPhoneX ?(SafeAreaTopHeight + 130):189;
//   UIView *coverView = [[UIView alloc]init];
////   coverView.hidden = YES;
//   coverView.backgroundColor = [UIColor clearColor];
//   coverView.frame = CGRectMake(30, covertopH, SCREEN_WIDTH, EQSliderHeight);
//   [self.view addSubview:coverView];
//   self.coverView = coverView;
//
//    if (![KSAPPUserSetting shareInstance].isFirstEnterEq) {
//        coverView.hidden = YES;
//              [self setupScroll];
//          }
//
//    if ([KSAPPUserSetting shareInstance].selectTag > 0) {
//         coverView.hidden = YES;
//    }
//}
//-(void)setupScroll{
//    //添加一层透明引导页 第一次进来
//       self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
////       self.scrollView.backgroundColor = [UIColor blackColor];
////    self.scrollView.alpha = 0.8;
//    self.scrollView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//
//       self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH , SCREEN_HEIGHT);
//       self.scrollView.bounces = YES;
//       //设置委托
//       self.scrollView.delegate = self;
//       self.scrollView.directionalLockEnabled = YES;
//       self.scrollView.scrollEnabled = NO;//禁止滑动
//       [self.view addSubview:self.scrollView];
//
//       UIView *bgView1 = [[UIView alloc]initWithFrame:self.view.frame];
//       bgView1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
////    bgView1.backgroundColor = [UIColor whiteColor];
////    bgView1.alpha = 0.8;
//       bgView1.userInteractionEnabled = YES;
//       [self.scrollView addSubview:bgView1];
//
//       UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNext)];
//       [bgView1 addGestureRecognizer:tapGesture];
//
//       UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(35.67, 105, 89, 64)];
//       img1.image = [UIImage imageNamed:@"圆角矩形 954"];
//       [bgView1 addSubview:img1];
//
//       UILabel *label1 = [[UILabel alloc]init];
//       label1.textColor = [UIColor whiteColor];
//       label1.font = [UIFont systemFontOfSize:10.67];
//       label1.text = NSLocalizedString(@"点击默认,可以恢复出厂EQ模式",nil);
//       [bgView1 addSubview:label1];
//       [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.leading.equalTo(bgView1.mas_leading).offset(29.33);
//           make.top.equalTo(img1.mas_bottom).offset(5);
//           make.size.mas_equalTo(CGSizeMake(300, 11));
//       }];
//
//       UIButton *btn1 = [[UIButton alloc]init];
//       [btn1 setTitle:NSLocalizedString(@"知道了", nil)  forState:(UIControlStateNormal)];
//       [btn1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//       btn1.layer.cornerRadius = 2.0;
//       btn1.layer.borderColor = [UIColor whiteColor].CGColor;
//       btn1.layer.borderWidth = 1.0f;//
//       [btn1 addTarget:self action:@selector(tapNext) forControlEvents:(UIControlEventTouchUpInside)];
//       [bgView1 addSubview:btn1];
//
//       [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerX.equalTo(bgView1);
//           make.centerY.equalTo(bgView1).offset(10);
//           make.size.mas_equalTo(CGSizeMake(125.33, 42.67));
//       }];
//
//       UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//       [btn2 setTitle:NSLocalizedString(@"Bypass",nil) forState:UIControlStateNormal];
//       [btn2 setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//    btn2.alpha = 1;
//       [btn2 setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//       btn2.titleLabel.font = [UIFont systemFontOfSize:11];
//       btn2.layer.cornerRadius = 6;
//       [bgView1 addSubview:btn2];
//
//       [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.left.equalTo(img1.mas_left).offset(7.67);
//           make.right.equalTo(img1.mas_right).offset(-8);
//           make.top.mas_equalTo(img1.mas_top).mas_offset(5.67);
//           make.size.mas_equalTo(CGSizeMake(74, 26));
//       }];
//
//       UIView *bgView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//       bgView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//
//       [self.scrollView addSubview:bgView2];
//
//       UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(139.33, 106, 89, 64)];
//       img2.image = [UIImage imageNamed:@"圆角矩形 954"];
//       [bgView2 addSubview:img2];
//
//       UILabel *label2 = [[UILabel alloc]init];
//       label2.textColor = [UIColor whiteColor];
//       label2.font = [UIFont systemFontOfSize:12];
//       label2.textAlignment = NSTextAlignmentCenter;
//       label2.text = NSLocalizedString(@"点击添加新EQ,可以添加自己设置的EQ",nil);
//       [bgView2 addSubview:label2];
//       [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerX.equalTo(bgView2);
//           make.top.equalTo(img2.mas_bottom).offset(5);
//           make.size.mas_equalTo(CGSizeMake(320, 12));
//       }];
//
//       UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//       [btn3 setTitle:NSLocalizedString(@"添加新EQ",nil) forState:UIControlStateNormal];
//
//       [btn3 setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//       [btn3 setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//       btn3.titleLabel.font = [UIFont systemFontOfSize:10.67];
//    btn3.titleLabel.adjustsFontSizeToFitWidth = YES;
//       btn3.layer.cornerRadius = 6;
//       [bgView2 addSubview:btn3];
//
//       [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.left.equalTo(img2.mas_left).offset(7.67);
//           make.right.equalTo(img2.mas_right).offset(-8);
//           make.top.mas_equalTo(img2.mas_top).mas_offset(5.67);
//           make.size.mas_equalTo(CGSizeMake(74, 26));
//       }];
//
//       UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//       [btn setTitle:NSLocalizedString(@"知道了",nil) forState:UIControlStateNormal];
//
//       [btn setTitleColor:[UIColor colorFromHexStr:@"#FFFFFF"] forState:UIControlStateNormal];
//       btn.titleLabel.font = [UIFont systemFontOfSize:16];
//       [btn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
//       btn.layer.cornerRadius = 2.0;
//       btn.layer.borderColor = [UIColor whiteColor].CGColor;
//       btn.layer.borderWidth = 1.0f;//
//       [bgView2 addSubview:btn];
//       [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.center.equalTo(bgView2);
//           make.size.mas_equalTo(CGSizeMake(125, 43));
//       }];
//}
//-(void)tapNext{
//    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
//}
//-(IBAction)okClick:(UIButton*)sender{
//    [self.scrollView removeFromSuperview];
//    self.coverView.hidden = NO;
//    [[KSAPPUserSetting shareInstance] setIsFirstEnterEq:YES];
//}
////MARK:- custom eq
//-(void)showCurrent:(NSInteger)current{
//
//}
//- (void)show{
//    if ([KSAPPUserSetting shareInstance].selectTag) {
//        self.quitTag = [KSAPPUserSetting shareInstance].selectTag;
//    }
//    NSLog(@"currentCustom=======%d",self.currentCustom);
//    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
//    CGFloat leftSpace = 43 ; //左间距和右间距
//    CGFloat space = 25; //每个item的间距
//    CGFloat btnW = (sw - leftSpace * 2 - space * 2)/3; //每个item的宽
//
//    UIView  * bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 95)];
//    [self.view addSubview:bgV];
//    self.bgView = bgV;
//
//    for (int i=0; i<self.array.count; i++) {
////        NSInteger index = i % 3;
//        NSInteger page = i / 3;
//
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = 100 + i;
//        [btn setTitle:_array[i] forState:UIControlStateNormal];
////        [btn setBackgroundImage:[UIImage imageNamed:self.colorArr[i]] forState:(UIControlStateNormal)];
//
//
//        if (self.currentCustom >=1 && i == self.currentCustom) {
//             [btn setBackgroundImage:[UIImage imageNamed:self.selectColorArr[self.currentCustom]] forState:(UIControlStateNormal)];
//            self.currentSelect = i;
//            self.currentSelectBtn = btn;
////            self.currentSelectBtn.selected = YES;
//        }else{
//            [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//        }
//
////        [btn setTitleColor:[UIColor colorFromHexStr:self.titleColor[i]] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [btn addTarget:self action:@selector(addCustomBtn:) forControlEvents:UIControlEventTouchUpInside];
//        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
////        btn.clipsToBounds = YES;
//        btn.layer.cornerRadius = 6;
//        [bgV addSubview:btn];
//        self.customBtn = btn;
//        btn.frame = CGRectMake( leftSpace + space * (i % 3) + btnW * (i % 3),38 * page  ,btnW , 26);
//        if (i == self.array.count -1) {
////            [btn setBackgroundImage:[UIImage imageNamed:self.colorArr[5]] forState:(UIControlStateNormal)];
//                   [btn setTitleColor:[UIColor colorFromHexStr:self.titleColor[5]] forState:UIControlStateNormal];
//        }
//
//        /**之前默认选中第一个现在改了方法在下面
//        if (i == 0) {
//            self.selectButton = btn;
//            btn.selected = YES;
//            [btn setTitleColor:[UIColor colorFromHexStr:@"#FEFEFF"] forState:(UIControlStateNormal)];
//            [btn setBackgroundImage:[UIImage imageNamed:@"default"] forState:(UIControlStateNormal)];
//        }
//         **/
//        if (i == [KSAPPUserSetting shareInstance].selectTag) {
//            NSLog(@"进来是第%ld个",[KSAPPUserSetting shareInstance].selectTag);
//            self.selectButton = btn;
//            btn.selected = YES;
//             [btn setTitleColor:[UIColor colorFromHexStr:@"#FEFEFF"] forState:(UIControlStateNormal)];
//            [btn setBackgroundImage:[UIImage imageNamed:self.selectColorArr[[KSAPPUserSetting shareInstance].selectTag]] forState:(UIControlStateNormal)];
//        }
//
////        NSLog(@"保存前选中的是第%d个",(self.beforeSaveBtn));
//        if (self.beforeSaveBtn  == (i +100)) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//            [btn setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//        }
//
//
//        if (i == 0 && self.isSave) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//            [btn setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//            self.isSave = NO;
//        }
//
//        if (self.paraM.didClickOther&&self.paraM.isClickSave && self.paraM.isCLickCustomBtn){
//            NSLog(@"进来点击其他 第%ld个应该被清掉颜色",[KSAPPUserSetting shareInstance].selectTag);
//            if (i== [KSAPPUserSetting shareInstance].selectTag) {
//                [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//                [btn setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
////                self.paraM.isCLickCustomBtn = NO;
////                self.paraM.isClickSave = NO;
//            }
//        }
//
//        //当前选中的是新增的那个 其余颜色全部被清空
//        if ((!self.paraM.isCLickOtherBtn) && self.paraM.isClickSave && self.paraM.isCLickCustomBtn) {
//            NSLog(@"第%ld个应该被清掉颜色",[KSAPPUserSetting shareInstance].selectTag);
//            if (i== [KSAPPUserSetting shareInstance].selectTag) {
//                [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//                [btn setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:UIControlStateNormal];
//
////                self.paraM.isCLickCustomBtn = NO;
////                self.paraM.isClickSave = NO;
//            }
//        }
//    }
//
//
//    //如果进来是bypass 那么应该是重置eq
//    if ([KSAPPUserSetting shareInstance].selectTag == 0) {
//        if ([self.delegate respondsToSelector:@selector(bypassReset)]) {
//            [self.delegate bypassReset];
//        }
//    }
//}
//-(IBAction)addCustomBtn:(UIButton*)sender{
//    NSLog(@"109------%@==%ld select第%d %@",sender.titleLabel.text,sender.tag -100,self.currentSelect,self.array);
//    self.quitTag = sender.tag - 100;
//
//    if (self.currentSelect > 0) {
//        [self.currentSelectBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"]forState:(UIControlStateNormal)];
//        self.currentSelect = 0;
//    }
//    if (!sender.selected) {
//        NSLog(@"选中了");
//        self.selectButton.selected = !self.selectButton.selected ;
//        [self.selectButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
//        [self.selectButton setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:(UIControlStateNormal)];
//
//        sender.selected = !sender.selected;
//        [sender setBackgroundImage:[UIImage imageNamed:self.selectColorArr[sender.tag - 100]] forState:(UIControlStateNormal)];
//        [sender setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
//        self.selectButton = sender;
//    }else{
//        NSLog(@"添加了之后再点击其他的");
////        [self.selectButton setBackgroundImage:self.selectColorArr[sender.tag-100] forState:(UIControlStateNormal)];
////        [self.selectButton setTitleColor:[UIColor colorFromHexStr:@"#666666"] forState:(UIControlStateNormal)];
//    }
//    self.customBtn = sender;
//    if (sender.tag == 100) {//默认第一个
//        self.isclickOther = NO;
//        self.coverView.hidden = NO;
//        self.resetBtn.hidden = YES;
//        [sender setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
//        [sender setBackgroundImage:[UIImage imageNamed:@"default"] forState:(UIControlStateNormal)];
//
//        [self defaultClick];
//        self.saveBtn.hidden = YES;
//        self.isCustom = NO;//
//    }else if(sender.tag == 105){//点击了第六个
//        self.isclickOther = YES;
//        self.isCover = NO;
//         self.coverView.hidden = YES;
//        if (![KSAPPUserSetting shareInstance].isAddEq) {
//            self.saveBtn.hidden = NO;
//        }
//        self.isCustom = YES;
//        self.currentCustom = 5;
//        if ([KSAPPUserSetting shareInstance].customEqFive) {
//           [self customEqClickWithArr:[KSAPPUserSetting shareInstance].customEqFive];
//        }
//
//    }else{
//        self.isclickOther = YES;
//        self.isCover = NO;
//        self.coverView.hidden = YES;
//        self.resetBtn.hidden = NO;
//        self.saveBtn.hidden = NO;
//        self.isCustom = YES;
//        //currentCustom 1开始 点击默认没赋值
//        self.currentCustom =(int) sender.tag - 100;
//
//        if (sender.tag - 100 == self.array.count -1) {
//            self.paraM.isCLickCustomBtn = YES;
//            NSLog(@"点击了自定义但不是第六个");
//            [sender setTitleColor:self.selectTitleColor forState:(UIControlStateNormal)];
//            [sender setBackgroundImage:[UIImage imageNamed:@"圆角矩形拷贝11"] forState:(UIControlStateNormal)];
//            if (self.bypassView) {
//                [self.bypassView removeFromSuperview];
//                self.bypassView = nil;
//
//            }
//            if (self.coverView) {
//                self.coverView = nil;
//                [self.coverView removeFromSuperview];
//            }
//            return;
//        }
//        if (sender.tag -100< self.array.count -1){
//            self.saveBtn.hidden = YES;
//            self.paraM.isCLickOtherBtn = YES;
//            self.paraM.didClickOther = YES;
//        }
//
//
//        if (self.currentCustom == 1) {
//             self.customEqFirst = [KSAPPUserSetting shareInstance].customEqFirst;
//            [self customEqClickWithArr:self.customEqFirst];
////        NSLog(@"%@%---ld",self.customBtn.titleLabel.text,self.customBtn.tag);
//        }else if (self.currentCustom == 2){
//            [self customEqClickWithArr:[KSAPPUserSetting shareInstance].customEqTwo];
////        NSLog(@"%@%ld",self.customBtn.titleLabel.text,self.customBtn.tag);
//        }else if (self.currentCustom == 3){
//            [self customEqClickWithArr:[KSAPPUserSetting shareInstance].customEqThree];
////        NSLog(@"%@%ld",self.customBtn.titleLabel.text,self.customBtn.tag);
//        }else if (self.currentCustom == 4){
//            [self customEqClickWithArr:[KSAPPUserSetting shareInstance].customEqFour];
////        NSLog(@"%@%ld",self.customBtn.titleLabel.text,self.customBtn.tag);
//        }else{
//            NSLog(@"currentCustom==5");
//        }
//        }
//
//}
////default
//-(void)setupSliderWith:(NSArray*)arr{
//    if (self.slider) {
//          [self.slider removeFromSuperview];
//      }
//      #if (TARGET_IPHONE_SIMULATOR)
////          self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//        if (self.values) {
//            [self.values removeAllObjects];
//        }
//        self.values = [NSMutableArray arrayWithArray:arr];
//      #else
//      if (self.values) {
//          [self.values removeAllObjects];
//      }
//
//       self.values = [NSMutableArray arrayWithArray:arr];
//      #endif
//
//    [self createSlider];
//}
//-(void)setupSlider{
//
//    if (self.slider) {
//        [self.slider removeFromSuperview];
//    }
//    #if (TARGET_IPHONE_SIMULATOR)
//        self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//    #else
//    if (self.values) {
//        [self.values removeAllObjects];
//    }
//    #endif
//
//    if (![KSAPPUserSetting shareInstance].isFirstEnterEq){
//         self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//
//    }else{
//        if ([KSAPPUserSetting shareInstance].selectTag == 0) {
//            self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//        }else{
//            NSLog(@"当前eq值==%@",[KSAPPUserSetting shareInstance].customEqFirst);
//
//            switch ([KSAPPUserSetting shareInstance].selectTag) {
//                case 1:
//                    self.values = [[NSMutableArray alloc] initWithArray:[KSAPPUserSetting shareInstance].customEqFirst];
//                    break;
//                case 2:
//                    self.values = [[NSMutableArray alloc] initWithArray:[KSAPPUserSetting shareInstance].customEqTwo];
//                    break;
//                case 3:
//                       self.values = [[NSMutableArray alloc] initWithArray:[KSAPPUserSetting shareInstance].customEqThree];
//                    break;
//                case 4:
//                       self.values = [[NSMutableArray alloc] initWithArray:[KSAPPUserSetting shareInstance].customEqFour];
//                    break;
//                case 5:
//                       self.values = [[NSMutableArray alloc] initWithArray:[KSAPPUserSetting shareInstance].customEqFive];
//                    break;
//
//                default:
//                    break;
//            }
//
//            if ([KSAPPUserSetting shareInstance].selectTag == self.array.count -1 && [self.selectButton.titleLabel.text isEqualToString:NSLocalizedString(@"添加新EQ", nil)]) {
//                NSLog(@"是最后一个%@",self.selectButton.titleLabel.text);
//                [self.selectButton setBackgroundImage:[UIImage imageNamed:@"圆角矩形拷贝11"] forState:(UIControlStateNormal)];
//                self.saveBtn.hidden = NO;
//                self.values = [[NSMutableArray alloc]init];
//                NSMutableArray *value1 = [[NSMutableArray alloc]init];
//                                  for (int i = 0; i < self.eqValue.length /2; i++) {
//                                      NSString *str2 =  [self.eqValue substringWithRange:NSMakeRange(i*2, 2)];
//                                      CGFloat value = [self input0x16String:str2];
//                                      [self.values addObject:@(value)];
//                                  }
////                             NSLog(@"当前进来的EQ%@",value1);
//
////                self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//
//            }
//
//        }
//    }
//
//    [self createSlider];
//}
//-(void)createSlider{
//    CGFloat width = (SCREEN_WIDTH - 30*2) /9;
//    //旋转了90度 y轴高度*0.5
//    CGFloat topH = iPhoneX ?(SafeAreaTopHeight + 125):213;
//    for (int i =0; i < self.values.count; i++) {
//        CGFloat sliderH = EQSliderHeight;
//        CGFloat sliderW = 5;
//        CGFloat sliderX = 30 + width *i;
//        CGFloat sliderY = kMaxY(self.bgView.frame)+5;
//        self.slider = [[KSEqSlider alloc] init];
//        self.slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
//        CGFloat value = [self.values[i] intValue];
//        self.slider.isShowTitle = YES;
//        self.slider.titleStyle = KSEqTopTitleStyle;
//        self.slider.value = value;
//        self.slider.tag = i;
//        self.slider.delegate = self;
////        [self.slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
//        [self.view addSubview:self.slider];
//         self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
//    }
//
//        //默认不让点击
//           if ([KSAPPUserSetting shareInstance].selectTag == 0) {
//               self.coverView.hidden = NO;
//           }
//
////    NSLog(@"self.coverView=%@ %@--%d",NSStringFromCGRect(self.coverView.frame),NSStringFromCGRect(self.bypassView.frame),self.isCover);
//
//        if (self.isCover) {
//            UIView *coverView = [[UIView alloc]init];
//            coverView.backgroundColor = [UIColor clearColor];
//            coverView.frame = CGRectMake(30, topH-5, SCREEN_WIDTH, EQSliderHeight + 10);
//            self.bypassView = coverView;
//            [self.view addSubview:coverView];
//        }
//
//    if (self.isclickOther) {
//        NSLog(@"点了other");
//        if (self.bypassView) {
//            [self.bypassView removeFromSuperview];
//            self.bypassView = nil;
//        }
//        if (self.coverView) {
//            [self.coverView removeFromSuperview];
//            self.coverView = nil;
//        }
//    }
//
//}
//
////-(void)_sliderValueDidChanged:(KSEqSlider*)slider{
////    NSLog(@"value==%f",slider.value);
////}
//
//-(void)makeX{
//    CGFloat topH = kMaxY(self.slider.frame);
//    NSLog(@"toph===%f",topH);
////    CGFloat offsetH = iPhoneX ? 60 : 30;
//    UIView *view = [UIView new];
//     self.xArray = [NSMutableArray arrayWithObjects:@"30",@"60",@"125",@"250",@"500", @"1K",@"2K",@"4K",@"8K",@"16K",nil];
//
//    view.backgroundColor = [UIColor lightGrayColor];
//    CGFloat h = (SCREEN_WIDTH - 30*2) / (self.xArray.count -1);
//    for (int i = 0; i < self.xArray.count; i++) {
//        UILabel *label = [UILabel new];
//        label.text = self.xArray[i];
//        [self.view addSubview:label];
//        label.font = [UIFont systemFontOfSize:13];
//        label.textColor = [UIColor colorWithHexString:@"#333333"];
//        label.textAlignment = NSTextAlignmentRight;
//        label.frame = CGRectMake(  i * h , topH + 10, 40, 20);
//
//    }
//}
//-(void)beginSwip{
//    self.saveBtn.hidden = NO;
//}
//
//
//-(void)endSwipValue:(CGFloat)value Tag:(NSInteger)tag{
//
//    [self.values replaceObjectAtIndex:tag withObject:@(floorf(value))];
//    NSArray *arr = [NSArray arrayWithArray:self.values];
//    NSLog(@"endArr==%@",arr);
//    if (self.isCustom) {
//        //自定义好了之后 如果用户手动滑动了 可以再次编辑
//        self.saveBtn.hidden = NO;
//        if (self.currentCustom == 1) {
//            NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr];
////            NSLog(@"custom1 ==%@ ---第%d个",custom1,self.currentCustom);
//            NSArray * array = [custom1 copy];
//            [[KSAPPUserSetting shareInstance] setCustomEqFirst:array];
//        }else if (self.currentCustom == 2){
//            NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr];
////            NSLog(@"custom2 ==%@ ---第%d个",custom1,self.currentCustom);
//            NSArray * array = [custom1 copy];
//            [[KSAPPUserSetting shareInstance] setCustomEqTwo:array];
//
//        }else if (self.currentCustom == 3){
//            NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr];
////            NSLog(@"custom3 ==%@ ---第%d个",custom1,self.currentCustom);
//            NSArray * array = [custom1 copy];
//            [[KSAPPUserSetting shareInstance] setCustomEqThree:array];
//        }else if (self.currentCustom == 4){
//            NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr];
////            NSLog(@"custom4 ==%@ ---第%d个",custom1,self.currentCustom);
//            NSArray * array = [custom1 copy];
//            [[KSAPPUserSetting shareInstance] setCustomEqFour:array];
//        }else if (self.currentCustom == 5){
//            NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr];
////            NSLog(@"custom5 ==%@ ---第%d个",custom1,self.currentCustom);
//            NSArray * array = [custom1 copy];
//            [[KSAPPUserSetting shareInstance] setCustomEqFive:array];
//        }
//    }
//
//    if ([self.delegate respondsToSelector:@selector(sendSliderValue:tag:)]) {
//        [self.delegate sendSliderValue:arr tag:tag];
//    }
//}
////MARK:-custom Delegate
//
//-(void)didClickBackBtn{
//    NSLog(@"---退出currentSelect是第%d个 当前选中的是第%ld个",self.currentSelect,self.paraM.addNewEqTag);
//    NSLog(@"退出是第%ld个 当前选中的是第%ld个",self.quitTag,self.paraM.addNewEqTag);
//    if (!self.paraM.isCLickOtherBtn && self.paraM.isCLickCustomBtn && self.paraM.isClickSave) {
//        self.quitTag = self.paraM.addNewEqTag;
//        [[KSAPPUserSetting shareInstance] setSelectTag:self.quitTag];
//    }else{
//       [[KSAPPUserSetting shareInstance] setSelectTag:self.quitTag];
//    }
//
//}
//
////MARK:-自定义风格点击
//-(void)customEqClickWithArr:(NSArray*)arr{
////    for (UIView *sub in self.view.subviews) {
////               if ([sub isKindOfClass:[SOValueTrackingSlider class]]) {
////                   [sub removeFromSuperview];
////               }
////           }
//
//    for (UIView *sub in self.view.subviews) {
//        if ([sub isKindOfClass:[KSEqSlider class]]) {
//            [sub removeFromSuperview];
//        }
//    }
//
//    [UIView animateWithDuration:0.01 animations:^{
//
//            [self setupSliderWith:arr];
//        }];
//
//        if ([self.delegate respondsToSelector:@selector(sendSliderReset:)]) {
//
//            NSLog(@"values=%@",arr);
//            [self.delegate sendSliderReset:arr];
//        }
//
//}
//-(void)defaultClick{
//
////        for (UIView *sub in self.view.subviews) {
////            if ([sub isKindOfClass:[SOValueTrackingSlider class]]) {
////                [sub removeFromSuperview];
////            }
////        }
//    self.isCover = YES;
//    for (UIView *sub in self.view.subviews) {
//        if ([sub isKindOfClass:[KSEqSlider class]]) {
//            [sub removeFromSuperview];
//        }
//    }
////        NSLog(@"subview==%@",self.view.subviews);
//         NSArray *arr1 = [[NSArray alloc]initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//        [UIView animateWithDuration:0.01 animations:^{
//            [self setupSliderWith:arr1];
//        }];
//        if ([self.delegate respondsToSelector:@selector(bypassReset)]) {
//            self.values = [NSMutableArray arrayWithArray:arr1];
//            NSLog(@"values=%@",self.values);
//            [self.delegate bypassReset];
//        }
//}
//-(IBAction)saveClick:(UIButton*)sender{
//
//    NSLog(@"点击了%@第%d个",self.customBtn.titleLabel.text,self.currentCustom);
//        NSArray *arr1 = @[NSLocalizedString(@"取消", nil) ,NSLocalizedString(@"保存", nil)];
//        KSEQCustomView * fail = [[KSEQCustomView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
//        hq_weak(fail)
//        hq_weak(self)
//        fail.onButtonTouchUpFail = ^(KSEQCustomView * _Nonnull alertView, NSInteger buttonIndex,NSString *name) {
//            hq_strong(fail)
//            hq_strong(self)
//            if (buttonIndex == 0) {
//                [fail close];
//                self.saveBtn.hidden = YES;
//            }else{
//                [fail close];
//                if (name.length<=0) {
//                    [MBProgressHUD showAutoMessage:NSLocalizedString(@"名称不能为空", nil) toView:self.view];
//                    return ;
//                }
//                self.saveBtn.hidden = YES;
//                if (self.customBtn.tag - 100 == 1) {//现在保存的的是第一个 从0算起
//                    self.customEqFirst = [KSAPPUserSetting shareInstance].customEqFirst;
//                    NSLog(@"customEqFirst=%@",self.customEqFirst);
//                    [self popTipsWithArr:self.customEqFirst andView:fail];
//
//                }else if(self.customBtn.tag - 100 == 2){
//                    self.customEqTwo = [KSAPPUserSetting shareInstance].customEqTwo;
//                    NSLog(@"customEqTwo=%@",self.customEqTwo);
//                    [self popTipsWithArr:self.customEqTwo andView:fail];
//                }else if(self.customBtn.tag - 100 == 3){
//                    self.customEqThree = [KSAPPUserSetting shareInstance].customEqThree;
//                    NSLog(@"customEqThree=%@",self.customEqThree);
//                    [self popTipsWithArr:self.customEqThree andView:fail];
//                }else if(self.customBtn.tag - 100 == 4){
//                    self.customEqFour = [KSAPPUserSetting shareInstance].customEqFour;
//                    NSLog(@"customEqFour=%@",self.customEqFour);
//                    [self popTipsWithArr:self.customEqFour andView:fail];
//                }else if(self.customBtn.tag - 100 == 5){
//                    self.customEqFive = [KSAPPUserSetting shareInstance].customEqFive;
//                    NSLog(@"customEqFive=%@",self.customEqFive);
//                    [self popTipsWithArr:self.customEqFive andView:fail];
//                }
//
//                if (self.array.count == 6) {
//
//                    if (self.currentCustom == self.array.count -1) {//点击了第六个
//                         [self.customBtn setTitle:name forState:(UIControlStateNormal)];
//
//                        [self.array replaceObjectAtIndex:self.currentCustom withObject:name];
//                                               [self.array writeToFile:self.arrPath atomically:YES];
//                        [[KSAPPUserSetting shareInstance] setIsAddEq:YES];
//                    }
//
//                    if (self.currentCustom < self.array.count -1) {//再次点击保存的值
//                        [self.customBtn setTitle:name forState:(UIControlStateNormal)];
//                        [self.array replaceObjectAtIndex:self.currentCustom withObject:name];
//                        [self.array writeToFile:self.arrPath atomically:YES];
//                    }
//
//                    if (self.customBtn.tag -100< self.array.count -1){
//                        [self.customBtn setTitle:name forState:(UIControlStateNormal)];
//                        [self.array replaceObjectAtIndex:self.customBtn.tag -100 withObject:name];
//                        [self.array writeToFile:self.arrPath atomically:YES];
//                    }
//                }
//                if (self.array.count >= 0 && self.array.count < 6){
//                     if (self.customBtn.tag -100< self.array.count -1) {
//
//                        [self.customBtn setTitle:name forState:(UIControlStateNormal)];
//                        [self.array replaceObjectAtIndex:self.customBtn.tag -100 withObject:name];
//                         [self.array writeToFile:self.arrPath atomically:YES];
//
//                           NSLog(@"点击了2-5个");
//                     }else{
//                         if (self.isAddEqValue) {//如果有拖动
//                             [self.bgView removeFromSuperview];
//
//                                                     [self.array insertObject:name atIndex:self.array.count -1];
//
//                             self.beforeSaveBtn =(int) self.currentSelectBtn.tag;
//                             self.isSave = YES;
//                             self.paraM.isClickSave  = YES;
//                             self.paraM.addNewEqTag = self.array.count -2;
//                                                    // 重新排布
//                                                     [self show];
//                                                     NSLog(@"添加后 - %@",self.array);
//
//                                                     [self.array writeToFile:self.arrPath atomically:YES];
//                         }else{
//
//                         }
//
//                     }
//
//                }
//
//            }
//        };
//         [kKeyWindow addSubview:fail];
//
//
//}
////点击恢复
//-(IBAction)resetClick:(UIButton*)sender{
//    NSLog(@"resetTag==%ld",self.quitTag);
//     NSArray *arr1 = [[NSArray alloc]initWithObjects:@(0), @(0), @(0), @(0), @(0) ,@(0), @(0), @(0), @(0), @(0),nil];
//    if (self.isCustom){
//            //自定义好了之后 如果用户手动滑动了 可以再次编辑
////            self.saveBtn.hidden = NO;
//            if (self.currentCustom == 1) {
//                NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr1];
//    //            NSLog(@"custom1 ==%@ ---第%d个",custom1,self.currentCustom);
//                NSArray * array = [custom1 copy];
//                [[KSAPPUserSetting shareInstance] setCustomEqFirst:array];
//            }else if (self.currentCustom == 2){
//                NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr1];
//    //            NSLog(@"custom2 ==%@ ---第%d个",custom1,self.currentCustom);
//                NSArray * array = [custom1 copy];
//                [[KSAPPUserSetting shareInstance] setCustomEqTwo:array];
//
//            }else if (self.currentCustom == 3){
//                NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr1];
//    //            NSLog(@"custom3 ==%@ ---第%d个",custom1,self.currentCustom);
//                NSArray * array = [custom1 copy];
//                [[KSAPPUserSetting shareInstance] setCustomEqThree:array];
//            }else if (self.currentCustom == 4){
//                NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr1];
//    //            NSLog(@"custom4 ==%@ ---第%d个",custom1,self.currentCustom);
//                NSArray * array = [custom1 copy];
//                [[KSAPPUserSetting shareInstance] setCustomEqFour:array];
//            }else if (self.currentCustom == 5){
//                NSMutableArray *custom1 = [NSMutableArray arrayWithArray:arr1];
//    //            NSLog(@"custom5 ==%@ ---第%d个",custom1,self.currentCustom);
//                NSArray * array = [custom1 copy];
//                [[KSAPPUserSetting shareInstance] setCustomEqFive:array];
//
//        }
//    }
//        for (UIView *sub in self.view.subviews) {
//            if ([sub isKindOfClass:[KSEqSlider class]]) {
//                [sub removeFromSuperview];
//            }
//        }
//
//
//            [UIView animateWithDuration:0.01 animations:^{
//
//                [self setupSliderWith:arr1];
//            }];
//
//            if ([self.delegate respondsToSelector:@selector(sendSliderReset:)]) {
//
//                self.values = [NSMutableArray arrayWithArray:arr1];
//
//                NSLog(@"values=%@",self.values);
//                [self.delegate sendSliderReset:self.values];
//            }
//}
//-(void)popTipsWithArr:(NSArray*)arr andView:(KSEQCustomView*)view{
//    if (arr == nil || [arr isKindOfClass:[NSNull class]] || arr.count == 0) {
//                           [view close];
//
//                           [MBProgressHUD showAutoMessage:@"请先滑动设置EQ值再保存" toView:kKeyWindow];
//        self.isAddEqValue = NO;
//
//    }else{
//       self.isAddEqValue = YES;
//    }
//
//}
//- (int)input0x16String:(NSString *)string{
//    char *_0x16String = (char *)string.UTF8String;
//    NSMutableString *binaryString = [[NSMutableString alloc] init];
//    for (int i = 0; i < string.length; i++) {
//        char c = _0x16String[i];
//        NSString *binary = [self binaryWithHexadecimal:[NSString stringWithFormat:@"%c",c]];
//        [binaryString appendString:binary];
//    }
//
//    if ([binaryString characterAtIndex:0] == '1') {
//        //反码
//        for (int i = (int)binaryString.length - 1; i > 0; i--) {
//            char c = [binaryString characterAtIndex:i];
//            c = c^0x1;
//            [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
//        }
//
//        //补码
//        BOOL flag = NO; //进位
//        NSInteger lastIndex = binaryString.length - 1;
//        char lastChar = [binaryString characterAtIndex:lastIndex];
//        if (lastChar == '0') {
//            lastChar = '1';
//        } else {
//            lastChar = '0';
//            flag = YES;
//        }
//
//        [binaryString replaceCharactersInRange:NSMakeRange(lastIndex, 1) withString:[NSString stringWithFormat:@"%c",lastChar]];
//
//        if (flag) {
//            for (int i = (int)binaryString.length - 2; i > 0; i--) {
//                char c = [binaryString characterAtIndex:i];
//                if (flag) {//进位
//                    if (c == '0') {
//                        c = '1';
//                        flag = NO;
//                        [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
//                        break;
//                    } else if (c == '1'){
//                        c = '0';
//                        flag = YES;
//                        [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
//                    }
//                }
//            }
//        }
//    }
//
//    int result = 0;
//    int bit = 0;
//    //计算
//    for (int i = (int)binaryString.length - 1; i > 0; i--) {
//        char c = [binaryString characterAtIndex:i];
//        if (c == '1') {
//            result += pow(2, bit);
//        }
//        ++bit;
//    }
//    if ([binaryString characterAtIndex:0] == '1') {
//        result = result *-1;
//    }
//    return result;
//}
//-(NSString *)binaryWithHexadecimal:(NSString *)string{
//    // 现将16进制转换车无符号的10进制
//    long a = strtoul(string.UTF8String, NULL, 16);
//    NSMutableString *binary = [[NSMutableString alloc] init];
//    while (a/2 !=0) {
//        [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
//        a = a/2;
//    }
//
//    [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
//
//    //不够4位的高位补0
//    while (binary.length%4 !=0) {
//        [binary insertString:@"0" atIndex:0];
//    }
//    return binary;
//}

@end

