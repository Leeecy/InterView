//
//  KSSegmentEqView.m
//  Interview
//
//  Created by kiss on 2019/10/23.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSSegmentEqView.h"
#import "UIView+frameAdjust.h"
#define Margin 15
#define Height 40
@interface KSSegmentEqView()

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSMutableArray *buttonArr;
@property(nonatomic,strong)UIView *segmentedContainer;
@property(nonatomic,strong)UIView *sliderLine;

@end

@implementation KSSegmentEqView
-(instancetype)initWithSegmentedTitles:(NSArray *)titles{
    if (self = [super init]) {
        self.titleArr = titles;
        self.backgroundColor = [UIColor lightGrayColor];
        [self createSegmentView];
        [self setUpViews];
    }
    return self;
}
-(void)createSegmentView{
    self.buttonArr = [NSMutableArray array];
    for (int index = 0; index < self.titleArr.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [button setTitle:self.titleArr[index] forState:UIControlStateNormal];
        [button setTitle:self.titleArr[index] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorFromHexStr:@"#888888"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexStr:@"#FFFFFF"] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        if (index == 0) {
            button.selected = YES;
        }else{
            button.selected
            = NO;
        }
        button.tag = index;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
    }
}

-(void)setUpViews{
    [self addSubview:self.segmentedContainer];
    for (UIButton *button in self.buttonArr) {
        [self.segmentedContainer addSubview:button];
    }
    [self addSubview:self.sliderLine];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.segmentedContainer.frame = CGRectMake(Margin, 0, self.width - Margin*2, self.height);
    
    //每个子segment的宽度
    CGFloat segmentWith = (self.width-15*2) / self.buttonArr.count;
    for (int i=0; i<self.buttonArr.count; i++) {
        UIButton *button = (UIButton *)self.buttonArr[i];
        button.top = 0;
        button.left = i * segmentWith;
        button.width = segmentWith;
        button.height = Height;
    }
    //设置底部红色滑动线条的位置
    self.sliderLine.bottom = 0;
    self.sliderLine.left = self.segmentedContainer.left;
    self.sliderLine.width = segmentWith;
    self.sliderLine.height = 2.0f;
}
-(void)buttonClicked:(UIButton *)sender{
    [self selectedSegmentButton:sender];
    if (self.segmentClickBlock) {
        self.segmentClickBlock(sender.tag);
    }
}

- (UIView *)segmentedContainer{
    if (!_segmentedContainer) {
        _segmentedContainer = [[UIView alloc] init];
        _segmentedContainer.backgroundColor = [UIColor whiteColor];
    }
    return _segmentedContainer;
}
-(void)selectedSegmentButton:(UIButton *)selectedButton{
    selectedButton.selected = YES;
    [self changeSelectedWithSelectedButton:selectedButton];
}
-(void)changeSelectedWithSelectedButton:(UIButton *)selectedButton{
    for (UIButton *button in _buttonArr) {
        if (![button isEqual:selectedButton]) {
            button.selected = NO;
        }
    }
    [self setSliderLinePosition];
}

-(void)setSliderLinePosition{
    UIButton *button = [self selectedButton];
    [UIView animateWithDuration:0.3f animations:^{
        self.sliderLine.left = Margin + button.tag * 40;
    }];
}
-(UIButton *)selectedButton{
    NSInteger selIndex = [self selectedIndex];
    if (selIndex == -1 || self.buttonArr.count <= selIndex) {
        return nil;
    }
    return self.buttonArr[selIndex];
}
- (NSInteger)selectedIndex
{
    for(int i = 0; i < self.buttonArr.count; i++) {
        UIButton *button = (UIButton *)self.buttonArr[i];
        if (button.selected) {
            return i;
        }
    }
    return -1;
}
-(void)sliderToCurrentSelectedIndex:(NSInteger)index{
    UIButton *button = self.buttonArr[index];
    [self selectedSegmentButton:button];
}
-(UIView *)sliderLine
{
    if (!_sliderLine) {
        _sliderLine = [[UIView alloc] init];
        _sliderLine.backgroundColor = [UIColor redColor];
    }
    return _sliderLine;
}



@end
