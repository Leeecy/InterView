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

@interface LabelViewController ()
@property (nonatomic, strong)NSArray *dataArrs;
@property (nonatomic, strong)NSArray *heightArrs;
@property (nonatomic, strong) UILabel *describeLabel;
@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *v1 = [UIView new];
    v1.frame = CGRectMake(100, 100, 100, 60);
    v1.backgroundColor = [UIColor redColor];
    UIView *v2 = [UIView new];
    v2.backgroundColor = [UIColor purpleColor];
    v2.frame = CGRectMake(80, 120, 100, 60);
    [self.view addSubview:v1];
    [self.view addSubview:v2];
    UIView *v3 = [UIView new];
    v3.backgroundColor = [UIColor yellowColor];
    v3.frame = CGRectMake(60, 140, 160, 60);
    [self.view insertSubview:v2 atIndex:3];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
