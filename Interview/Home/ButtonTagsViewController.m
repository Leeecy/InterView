//
//  ButtonTagsViewController.m
//  Interview
//
//  Created by kiss on 2019/12/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ButtonTagsViewController.h"
#import "CLTagsModel.h"
#import "KSAPPUserSetting.h"
#import "KSEQCustomView.h"
#import "NSString+Extension.h"
@interface ButtonTagsViewController ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)NSMutableArray *eqArray;//需要存储的EQ数组
@property(nonatomic,assign)NSInteger quitTag;//记录退出之前的tag
@property(nonatomic,strong) CLTagsModel *tagM;
@property(nonatomic,strong)UIButton *beforeClickBtn;//点击下一个之前的btn
@property(nonatomic,strong)NSString *arrPath;
@property(nonatomic,assign)NSInteger selectTag;//当前选中的tag全局用
@property(nonatomic,strong)NSMutableArray *values;
@end

@implementation ButtonTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     NSMutableArray *realArr = [[NSMutableArray alloc]initWithObjects:@(-1), @(-2), @(-3), @(-4), @(-5) ,@(-6), @(-9), @(-10), @(-11), @(-12),nil];
//     NSMutableArray *value1 = [NSMutableArray arrayWithArray:[realArr copy]];
    
//   NSArray *arr1 = [NSArray arrayWithArray:value1];
    int c= 0xffff;
    int a = -10;
    int b =  abs(a) ;
    [NSString to16:(c-b+1)];
          
    [self sendSliderReset:realArr];
    [self sendSliderReset11:realArr];
    NSLog(@"%@",[self getHexByDecimal:-1]);
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    CLTagsModel *tagM = [[CLTagsModel alloc]init];
    self.tagM = tagM;
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"eqstyle.plist"];
    NSArray *arrMain = [NSArray arrayWithContentsOfFile:filePath];
    self.arrPath = filePath;
    
     if (arrMain.count > 0) {
           self.eqArray = [NSMutableArray arrayWithArray:arrMain];
       }else{
           self.eqArray = [NSMutableArray arrayWithObjects:NSLocalizedString(@"Bypass",nil),NSLocalizedString(@"添加新EQ",nil), nil];
       }
    
    [self createBtn];
    [self delete];
    [self back];
    
  
}
-(void)sendSliderReset:(NSMutableArray*)arr{
    NSMutableArray * arr1 = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              
          int value = [obj intValue];
          NSString *subStr;
          if (value < 0) {
              NSString *str1 = [self getHexByDecimal:value];
              subStr = [str1 substringFromIndex:str1.length -2];
          }else{
              subStr = [NSString to16:value];
          }
          [arr1 addObject:subStr];
                  
          }];
       
       NSLog(@"arr1==%@",arr1);
}

-(void)sendSliderReset11:(NSMutableArray*)arr{
    NSMutableArray * arr1 = [[NSMutableArray alloc]init];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        
          int value = [obj intValue];
        int c= 0xffff;
        
          NSString *subStr;
          if (value < 0) {
              int b =  abs(value) ;
              NSString *str1 = [NSString to16:(c-b+1)];
              subStr = [str1 substringFromIndex:str1.length -2];
          }else{
              subStr = [NSString to16:value];
          }
          [arr1 addObject:subStr];
                  
          }];
       
       NSLog(@"arr2==%@",arr1);
}
-(void)createBtn{
    
    CGFloat bgVHeigth = iPhoneX ? 115 : 95;
    CGFloat leftSpace = 40 ; //左间距和右间距
    CGFloat space = 23; //每个item的间距
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnW = (sw - leftSpace * 2 - space * 2)/3; //每个item的宽
    UIView  * bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 105, ScreenWidth, bgVHeigth)];
    [self.view addSubview:bgV];
     self.bgView = bgV;
    for (int i=0; i<self.eqArray.count; i++) {
        NSInteger page = i / 3;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
                   btn.tag = 100 + i;
        [btn setTitle:_eqArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.tagM.normalTitleColor forState:UIControlStateNormal];
        [btn setBackgroundImage:self.tagM.normalImg forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn addTarget:self action:@selector(clickCustomBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bgV addSubview:btn];
        btn.frame = CGRectMake(leftSpace + space * (i % 3) + btnW * (i % 3),40 * page+10  ,btnW , 30);
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (![KSAPPUserSetting shareInstance].isFirstEnterEq) {
            NSLog(@"第一次进来");
            if (i==0) {
                [btn setTitleColor:self.tagM.selectTitleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:self.tagM.selectImg forState:UIControlStateNormal];
                               NSLog(@"当前被选中的是%d个 %@",i,btn.titleLabel.text);
                self.beforeClickBtn = btn;
                self.selectTag = 0;
                [self defaultClick];
            }
        }
        if (self.tagM.isAddNewBtn) {//新增了eq之后 默认被选中
            if (i == self.eqArray.count -2) {
                [btn setTitleColor:self.tagM.selectTitleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:self.tagM.selectImg forState:UIControlStateNormal];
                NSLog(@"当前被选中的是%d个 %@",i,btn.titleLabel.text);
                self.tagM.isAddNewBtn= NO;
                self.beforeClickBtn = btn;
                self.selectTag = i;
            }
        }
        if (self.tagM.isAddLastBtn) {//新增第六个eq
            if (i == 5) {
                [btn setTitleColor:self.tagM.selectTitleColor forState:UIControlStateNormal];
                [btn setBackgroundImage:self.tagM.selectImg forState:UIControlStateNormal];
                NSLog(@"-----当前被选中的是%d个 %@",i,btn.titleLabel.text);
                self.tagM.isAddLastBtn= NO;
                self.beforeClickBtn = btn;
                self.selectTag = 5;
            }
        }
        //退出之后再进来
        if ([KSAPPUserSetting shareInstance].quitTag == i && !self.tagM.isAddLastBtn && !self.tagM.isAddNewBtn) {
            [btn setTitleColor:self.tagM.selectTitleColor forState:UIControlStateNormal];
            [btn setBackgroundImage:self.tagM.selectImg forState:UIControlStateNormal];
            NSLog(@"====当前被选中的是%d个 %@",i,btn.titleLabel.text);
            self.beforeClickBtn = btn;
            self.selectTag = i;
        }
        
    }
    [[KSAPPUserSetting shareInstance] setIsFirstEnterEq:YES];
}

-(void)clickCustomBtn:(UIButton*)sender{
     NSLog(@"clickCustomBtn ------%@==select第%ld个",sender.titleLabel.text,sender.tag -100);
    self.selectTag = sender.tag -100;
    [self.beforeClickBtn setBackgroundImage:self.tagM.normalImg forState:(UIControlStateNormal)];
    [self.beforeClickBtn setTitleColor:self.tagM.normalTitleColor forState:(UIControlStateNormal)];
    NSLog(@"beforeClickBtn11==%@",self.beforeClickBtn.titleLabel.text);
//    [sender setBackgroundImage:self.tagM.normalImg forState:(UIControlStateNormal)];
//    [sender setTitleColor:self.tagM.normalTitleColor forState:(UIControlStateNormal)];
    sender.selected = !sender.selected;
    [sender setBackgroundImage:self.tagM.selectImg forState:(UIControlStateNormal)];
    [sender setTitleColor:self.tagM.selectTitleColor forState:(UIControlStateNormal)];
    self.beforeClickBtn = sender;
    NSLog(@"beforeClickBtn22==%@",self.beforeClickBtn.titleLabel.text);
    if (sender.tag == 100) {//默认第一个
        [self defaultClick];
    }else{
        if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"添加新EQ",nil)]) {
            [self popTips];
        }
    }
        
}

-(void)defaultClick{
     NSLog(@"click defaultClick");
}
-(void)popTips{
     NSArray *arr1 = @[NSLocalizedString(@"取消", nil) ,NSLocalizedString(@"保存", nil)];
    KSEQCustomView * fail = [[KSEQCustomView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
             hq_weak(fail)
             hq_weak(self)
     fail.onButtonTouchUpFail = ^(KSEQCustomView * _Nonnull alertView, NSInteger buttonIndex,NSString *name) {
         hq_strong(fail)
         hq_strong(self)
         if (buttonIndex == 0) {
             [fail close];
         }else{
             [fail close];
             if (name.length<=0) {
                   [MBProgressHUD showAutoMessage:NSLocalizedString(@"名称不能为空", nil) toView:self.view];
                   return ;
               }
             if (self.eqArray.count == 6){
                 if ([self.beforeClickBtn.titleLabel.text isEqualToString:NSLocalizedString(@"添加新EQ",nil)]) {
                     NSLog(@"点击的第六个是添加新EQ");
                    [self.eqArray replaceObjectAtIndex:5 withObject:name];
                     [self.eqArray writeToFile:self.arrPath atomically:YES];
                    [self.bgView removeFromSuperview];
                     self.tagM.isAddLastBtn = YES;
                    // 重新排布
                    [self createBtn];
                 }
             }else{
                 [self.eqArray insertObject:name atIndex:self.eqArray.count-1];
                 NSLog(@"%@",self.eqArray);
                  [self.eqArray writeToFile:self.arrPath atomically:YES];
                 [self.bgView removeFromSuperview];
                 // 重新排布
                 self.tagM.isAddNewBtn = YES;
                 [self createBtn];
             }
         }
     };
     [kKeyWindow addSubview:fail];
}
-(void)back{
    UIButton *reset = [[UIButton alloc]init];
   [reset setTitle:NSLocalizedString(@"back", nil) forState:(UIControlStateNormal)];

   reset.titleLabel.font = [UIFont systemFontOfSize:15];
   [reset setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
   [reset addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
   [self.view addSubview:reset];
   [reset mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.view.mas_centerX);
      make.size.mas_equalTo(CGSizeMake(60, 25));
      make.top.equalTo(self.view.mas_top).offset(450);
   }];
}
-(void)delete{
    UIButton *reset = [[UIButton alloc]init];
    [reset setTitle:NSLocalizedString(@"恢复", nil) forState:(UIControlStateNormal)];
 
    reset.titleLabel.font = [UIFont systemFontOfSize:15];
    [reset setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
    [reset addTarget:self action:@selector(resetClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:reset];
    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view.mas_centerX);
       make.size.mas_equalTo(CGSizeMake(60, 25));
       make.top.equalTo(self.view.mas_top).offset(400);
    }];
}
-(IBAction)resetClick:(id)sender{
//    [self.eqArray removeAllObjects];
//    [self.eqArray writeToFile:self.arrPath atomically:YES];
     NSArray *arr1 = @[NSLocalizedString(@"取消", nil) ,NSLocalizedString(@"保存", nil)];
     KSEQCustomView * fail = [[KSEQCustomView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
    fail.onButtonTouchUpFail = ^(KSEQCustomView * _Nonnull alertView, NSInteger buttonIndex,NSString *name) {
        
        
    };
    
    [kKeyWindow addSubview:fail];
}
-(IBAction)backClick:(id)sender{
    NSLog(@"%s当前选中的tag %ld",__func__,self.selectTag);
    [[KSAPPUserSetting shareInstance] setQuitTag:self.selectTag];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(NSString*)getHexByDecimal:(NSInteger)decimal {
    char *hexChar = ultostree(decimal, 16);
    NSString *hex = [NSString stringWithUTF8String:hexChar];
    return hex;
}
char *ultostree(unsigned long num, unsigned base) {
    static char string[64] = {'\0'};
    size_t max_chars = 64;
    char remainder;
    int sign = 0;
    if (base < 2 || base > 36) {
        return NULL;
    }
    for (max_chars --; max_chars > sign && num != 0; max_chars --) {
        remainder = (char)(num % base);
        if ( remainder <= 9 ) {
            string[max_chars] = remainder + '0';
        } else {
            string[max_chars] = remainder - 10 + 'A';
        }
        num /= base;
    }
    if (max_chars > 0) {
        memset(string, '\0', max_chars + 1);
    }
    return string + max_chars + 1;
}

- (NSString *)binaryWithHexadecimal:(NSString *)string{
    // 现将16进制转换车无符号的10进制
    long a = strtoul(string.UTF8String, NULL, 16);
    NSMutableString *binary = [[NSMutableString alloc] init];
    while (a/2 !=0) {
        [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
        a = a/2;
    }
    
    [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
    
    //不够4位的高位补0
    while (binary.length%4 !=0) {
        [binary insertString:@"0" atIndex:0];
    }
    return binary;
}


@end
