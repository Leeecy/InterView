//
//  LabelViewController.m
//  Interview
//
//  Created by kiss on 2019/8/2.
//  Copyright © 2019 cl. All rights reserved.
//

#import "LabelViewController.h"
#import "SZDataModel.h"
#import "SZUtils.h"
#import "LLGifImageView.h"
@interface LabelViewController ()<UIGestureRecognizerDelegate>{
   
}
@property (nonatomic, strong)NSArray *dataArrs;
@property (nonatomic, strong)NSArray *heightArrs;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) LLGifImageView *gifImageView;
@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,strong)UIView *smallView;
@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self loadCADisplayLineImageView];
    
    self.bigView = [[UIView alloc]initWithFrame:CGRectMake(150, 150, 100, 100)];
      self.bigView.backgroundColor = [UIColor redColor];
      UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigMap:)];
      recognizer.delegate = self;
      [self.bigView addGestureRecognizer:recognizer];
      [self.view addSubview:self.bigView];
    
      self.smallView = [[UIView alloc]initWithFrame:CGRectMake(-20, 0, 50, 50)];
      self.smallView.backgroundColor = [UIColor yellowColor];
      [self.bigView addSubview:self.smallView];

}
-(IBAction)bigMap:(UIGestureRecognizer*)sender{
    NSLog(@"点击了");
}


-(void)test{
    //    CGFloat ymax = CGRectGetMaxY(bgV.frame) +21;
    //       CGRect bounds = CGRectMake(0, 0, ScreenWidth, 100 - 10 - ymax);
    //       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    //       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //       maskLayer.frame = bounds;
    //       maskLayer.path = maskPath.CGPath;
    //       [bgV.layer addSublayer:maskLayer];
    //       bgV.layer.mask = maskLayer;
    //       bgV.layer.masksToBounds = YES;
        UIView *bgV = [[UIView alloc]initWithFrame:CGRectMake(100, 600, 200, 100)];
           bgV.backgroundColor = [UIColor lightGrayColor];
           [self.view addSubview:bgV];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgV.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = bgV.bounds;
            maskLayer.path = maskPath.CGPath;
            bgV.layer.mask = maskLayer;
        
        
        
        
        //将GIF图片分解成多张PNG图片
        //得到GIF图片的url
       
    //    NSString *path = [NSBundle.mainBundle pathForResource:@"222" ofType:@"gif"];
    //    NSData *data = [NSData dataWithContentsOfFile:path];
    //
    //
    //    //将GIF图片转换成对应的图片源
    //    CGImageSourceRef gifSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    //    //获取其中图片源个数，即由多少帧图片组成
    //    size_t frameCount = CGImageSourceGetCount(gifSource);
    //    //定义数组存储拆分出来的图片
    //    NSMutableArray *frames = [[NSMutableArray alloc] init];
    //    for (size_t i = 0; i < frameCount; i++) {
    //        //从GIF图片中取出源图片
    //        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
    //        //将图片源转换成UIimageView能使用的图片源
    //        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
    //        //将图片加入数组中
    //        [frames addObject:imageName];
    //        CGImageRelease(imageRef);
    //    }
    //    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.5-15, 15, 30, 30)];
    //    //将图片数组加入UIImageView动画数组中
    //    gifImageView.animationImages = frames;
    //    //每次动画时长
    //    gifImageView.animationDuration = 1.3;
    //    //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    //    [gifImageView startAnimating];
    //    [self.view addSubview:gifImageView];

        
    //    NSArray *randomArr = [[NSArray alloc] initWithObjects:
    //                          @"考生因身高遭淘汰北京体育大学艺考现场,一名考生因身高不够遭淘汰,提前走出考场,家长们立即蜂拥而上。她还现场表演了本来为复试准备的舞蹈,现场一片叫好",
    //                          @"音乐服务，同时将导致您在Sonos平台上无法继续使用多米音乐”。北京商报记者观察发现，多米音乐计划停止运营似乎在此前就已经有所预兆。不仅曾保持每周更新约5条消息的多米音乐官方微博，在2月9日中午发布一条视频后，至今已有近一个月未再更新其他消息，除此以外，在今年春节前夕，即2月14日，在新三板挂牌一年多的多米音乐发布公告称，申请在新三板终止挂牌。",
    //
    //                          @"翠鸟的德语名字是“Eisvogel”,字面意思就是“冰鸟”", nil];
    //
    //
    //    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    //    for (int index = 0; index < 10; index++) { //随机取十条数据
    //        SZDataModel *model = [[SZDataModel alloc] init];
    //        model.content = randomArr[random()%3];
    //        [tempArr addObject:model];
    //    }
    //
    //    self.dataArrs = [tempArr copy];
    //    //获取cell所对应的高度数组
    //    self.heightArrs = [[SZUtils shareUtils] getHeightArrayWithDatas:_dataArrs labelWidth:260];
    //
    //    for (int i = 0; i<randomArr.count; i++) {
    //
    //        _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 260,12)];
    //        _describeLabel.backgroundColor = [UIColor redColor];
    //        _describeLabel.font = [UIFont systemFontOfSize:12.f];
    //        _describeLabel.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.8f];
    //        _describeLabel.numberOfLines = 0;  //自动换行
    //        self.describeLabel.text = _dataArrs[i];
    //        [self.view addSubview:_describeLabel];
    //    }
}
-(void)loadCADisplayLineImageView{
    [self removeGif];
    
    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"222" ofType:@"gif"]];
    _gifImageView = [[LLGifImageView alloc] initWithFrame:self.view.bounds];
    _gifImageView.contentMode = UIViewContentModeScaleAspectFit;
    _gifImageView.gifData = localData;
    [self.view addSubview:_gifImageView];
    [_gifImageView startGif];
    
    UILabel * label = [[UILabel alloc]init];
    [self.view addSubview:label];
}
- (void)removeGif {
    if (_gifImageView.superview) {
        [_gifImageView removeFromSuperview];
        _gifImageView = nil;
    }
}
@end
