//
//  KSTitleButton.m
//  FastPair
//
//  Created by cl on 2019/7/24.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSTitleButton.h"

#define KSTitleButton_Margin 0   // 行_列间距
#define LinkStartMargin 0   // 每行首列起始间距

@interface KSTitleButton()
@property(nonatomic,assign)CGFloat viewW;
@property(nonatomic,assign)CGFloat viewH;
// 行
@property(nonatomic,assign)NSInteger linkNumber ;
// 列
@property(nonatomic,assign)NSInteger columnsNumber ;

// 内容数组
@property(nonatomic,strong)NSMutableArray * titleArr ;

// 图片、文字位置样式
@property(nonatomic,assign)KSEdgeInsetsStyle style ;
// 图片、文字间隙
@property(nonatomic,assign)CGFloat space ;


@property(nonatomic,assign)BOOL isH12;
@end
@implementation KSTitleButton

-(instancetype)initWithFrame:(CGRect)frame TitleArr:(NSArray*)titleArr LineNumber:(NSInteger)linkNumber ColumnsNumber:(NSInteger)columnsNumber EdgeInsetsStyle:(KSEdgeInsetsStyle)style ImageTitleSpace:(CGFloat)space isUpdate:(BOOL)update isFemale:(BOOL)isH12{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor] ;
        self.isH12 = isH12;
        self.viewW = ScreenWidth - 40;
        self.viewH = 200;
        self.titleArr = [NSMutableArray arrayWithArray:titleArr] ;
        self.linkNumber = linkNumber ;
        self.columnsNumber = columnsNumber ;
        self.style = style ;
        self.space = space ;
        self.isRotate = update;
        [self configUIWithUpdate:self.isRotate];
    }
    return self;
}
-(void)configUIWithUpdate:(BOOL)update{
    //初始控件X、Y
    CGFloat btnX = 0;
    CGFloat btnY = 0;
     CGFloat btnW = (self.viewW- (self.columnsNumber + 1) * KSTitleButton_Margin) / self.columnsNumber;
      CGFloat btnH = ((self.viewH - 0) - (self.linkNumber + 1) * KSTitleButton_Margin) / self.linkNumber;
    for (int i=0; i<self.titleArr.count; i++) {
        UIButton * bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //间隙 + 当前列数的值（总数取余得到） * （间隙 + 宽度）
        btnX = KSTitleButton_Margin + (i % self.columnsNumber) * (KSTitleButton_Margin + btnW);
        //间隙 + 当前行数的值（总数整除得到） * （间隙 + 高度)+首行起始距离
        btnY = KSTitleButton_Margin + (i / self.columnsNumber) * (KSTitleButton_Margin + btnH) + 0;
        
        bgBtn.tag = i ;
        //        bgBtn.clipsToBounds = YES ;
        //设置位置
        bgBtn.frame = CGRectMake(btnX+LinkStartMargin, btnY, btnW, btnH);
        //事件
        [bgBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        //添加图片、文字
        [self addImageTitleToBtn:bgBtn index:i btnW:btnW btnH:btnH update:update];
        //添加按钮，并保存到数组
        [self addSubview:bgBtn];

    }
}

#pragma mark--添加图片、文字
-(void)addImageTitleToBtn:(UIButton *)btn index:(NSInteger)i btnW:(CGFloat)btnW btnH:(CGFloat)btnH update:(BOOL)update{
    NSArray *arr =self.isH12 ? @[@"female_Key setting",@"female_general settings",@"female_eq",@"female_update"] : @[@"按键设置",@"通用设置",@"EQ",@"固件更新"];
    if (i < 3) {
        //创建图片控件
        UIImageView * iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arr[i]]] ;
        //创建文字控件
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = self.titleArr[i] ;
        titleLabel.textColor = self.isH12 ?[UIColor colorWithHexString:@"#999899"]: [UIColor colorWithHexString:@"#999999"] ;
        titleLabel.font = [UIFont systemFontOfSize:15];//SHCNFont(13)  ;
        titleLabel.textAlignment = 1 ;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle; //中间位置省略号
        
        CGFloat iconImgX ;
        CGFloat iconImgY ;
        CGFloat titleX ;
        CGFloat titleY ;
        CGFloat titleW ;
        CGFloat titleH = 20 ;
        switch (self.style) {
            case LZHEdgeInsetsStyleTop: //图片在上，文字在下
                iconImgX = (btnW-iconImg.frame.size.width)/2 ;
                iconImgY = (btnH-iconImg.frame.size.height-self.space-titleH)/2 ;
                titleX = 0 ;
                titleY = iconImgY+kMaxY(iconImg.frame)+self.space ;
                titleW = btnW ;
                break;
                
            case LZHEdgeInsetsStyleLeft: ////图片在左，文字在右
                titleW = [self calculateRowWidth:self.titleArr[i]] ;
                iconImgX = (btnW-iconImg.frame.size.width-titleW-self.space)/2 ;
                iconImgY = (btnH-iconImg.frame.size.height)/2 ;
                titleX = iconImgX+kMaxX(iconImg.frame)+self.space ;
                titleY = (btnH-titleH)/2 ;
                break;
                
            case LZHEdgeInsetsStyleBottom://图片在下，文字在上
                titleX = 0 ;
                titleY = (btnH-iconImg.frame.size.height-self.space-titleH)/2 ;
                titleW = btnW ;
                iconImgX = (btnW-iconImg.frame.size.width)/2 ;
                iconImgY = titleY+titleH+self.space ;
                break;
                
            case LZHEdgeInsetsStyleRight://图片在右，文字在左
                titleW = [self calculateRowWidth:self.titleArr[i]] ;
                titleX = (btnW-titleW-self.space-iconImg.frame.size.width)/2 ;
                titleY = (btnH-titleH)/2 ;
                iconImgX = titleX+titleW+self.space ;
                iconImgY = (btnH-iconImg.frame.size.height)/2 ;
                break;
                
            default:
                break;
        }
        
        //设置位置
        iconImg.frame = CGRectMake(iconImgX, iconImgY, iconImg.frame.size.width, iconImg.frame.size.height);
        titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH) ;
        //添加
        [btn addSubview:iconImg];
        [btn addSubview:titleLabel];
    }else {
        UIImageView *iconImg;
        
        if (update) {
//            NSLog(@"固件更新");
            if (self.isH12) {
                iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"female_update_"]];
            }else{
                iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WechatIMG"]];
            }
            
        }else{
//            [self.roundV hideAnimate];
            //创建图片控件
            iconImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:arr[i]]] ;
        }
        
        //创建文字控件
                   UILabel * titleLabel = [[UILabel alloc]init];
                   titleLabel.text = self.titleArr[i] ;
                   titleLabel.textColor = [UIColor colorWithHexString:@"#999999"] ;
                   titleLabel.font = [UIFont systemFontOfSize:13];//SHCNFont(13)  ;
                   titleLabel.textAlignment = 1 ;
                   titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle; //中间位置省略号
                   
                   CGFloat iconImgX ;
                   CGFloat iconImgY ;
                   CGFloat titleX ;
                   CGFloat titleY ;
                   CGFloat titleW ;
                   CGFloat titleH = 20 ;
                   switch (self.style) {
                       case LZHEdgeInsetsStyleTop: //图片在上，文字在下
                           iconImgX = (btnW-iconImg.frame.size.width)/2 ;
                           iconImgY = (btnH-iconImg.frame.size.height-self.space-titleH)/2 ;
                           titleX = 0 ;
                           titleY = iconImgY+kMaxY(iconImg.frame)+self.space ;
                           titleW = btnW ;
                           break;
                           
                       case LZHEdgeInsetsStyleLeft: ////图片在左，文字在右
                           titleW = [self calculateRowWidth:self.titleArr[i]] ;
                           iconImgX = (btnW-iconImg.frame.size.width-titleW-self.space)/2 ;
                           iconImgY = (btnH-iconImg.frame.size.height)/2 ;
                           titleX = iconImgX+kMaxX(iconImg.frame)+self.space ;
                           titleY = (btnH-titleH)/2 ;
                           break;
                           
                       case LZHEdgeInsetsStyleBottom://图片在下，文字在上
                           titleX = 0 ;
                           titleY = (btnH-iconImg.frame.size.height-self.space-titleH)/2 ;
                           titleW = btnW ;
                           iconImgX = (btnW-iconImg.frame.size.width)/2 ;
                           iconImgY = titleY+titleH+self.space ;
                           break;
                           
                       case LZHEdgeInsetsStyleRight://图片在右，文字在左
                           titleW = [self calculateRowWidth:self.titleArr[i]] ;
                           titleX = (btnW-titleW-self.space-iconImg.frame.size.width)/2 ;
                           titleY = (btnH-titleH)/2 ;
                           iconImgX = titleX+titleW+self.space ;
                           iconImgY = (btnH-iconImg.frame.size.height)/2 ;
                           break;
                           
                       default:
                           break;
                   }
                   
                   //设置位置
                   iconImg.frame = CGRectMake(iconImgX, iconImgY, iconImg.frame.size.width, iconImg.frame.size.height);
                   titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH) ;
                   //添加
                   [btn addSubview:iconImg];
                   [btn addSubview:titleLabel];
        
    }
}

-(void)clickBtn:(UIButton *)sender{
    NSInteger index = sender.tag ;
    KSTitleViewStyle style = sender.tag;
    
    if ([self.delegate respondsToSelector:@selector(clickBTnIndex:Title:)]) {
        [self.delegate clickBTnIndex:style Title:self.titleArr[index]];
    }
}

-(void)setIsRotate:(BOOL)isRotate{
    _isRotate = isRotate;
//    [self setNeedsLayout];
//    [self configUIWithUpdate:isRotate];

}

#pragma mark--计算文字宽度 （文字大小若改动，此处请自行修改）
- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 20)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

@end
