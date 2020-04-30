//
//  KSProgressTimeView.m
//  Interview
//
//  Created by kiss on 2020/4/27.
//  Copyright © 2020 cl. All rights reserved.
//

#import "KSProgressTimeView.h"

@interface KSProgressTimeView()
@property (nonatomic, weak  ) UIView    *showunderView;
@property (nonatomic, weak  ) NSTimer   *countTimer;
@property (nonatomic, assign) CGFloat    toStartCountDown;
@end

@implementation KSProgressTimeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        UIView *showunderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        UIView *showunderView=[[UIView alloc]init];
        showunderView.backgroundColor=_timeCountColor?_timeCountColor:[UIColor orangeColor];
        [self addSubview:showunderView];
        self.showunderView=showunderView;
        
        UILabel *timeCountLab=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, 0, 100, 0)];
        timeCountLab.font=[UIFont systemFontOfSize:10];
        timeCountLab.textAlignment=NSTextAlignmentCenter;
        timeCountLab.textColor=self.timeCountLabColor?self.timeCountLabColor:[UIColor lightGrayColor];

        [self addSubview:timeCountLab];
        self.timeCountLab=timeCountLab;
    }
    return self;
}
-(void)layoutSubviews{
    
}
-(void)countTime:(NSTimer *)sender{
    self.toStartCountDown--;
    NSLog(@"%f",self.toStartCountDown);
    float settime= self.toStartCountDown/self.totalTimeFrequency;
    self.timeCountLab.text=[NSString stringWithFormat:@"%.0f %%",100*(1-settime)];
    
    if ([self.delegate respondsToSelector:@selector(timeChange:)]) {
        [self.delegate timeChange:self.timeCountLab.text];
    }
    
    self.showunderView.frame=CGRectMake(0, 0, self.frame.size.width*(1-settime), 30);
    if (self.toStartCountDown<=0){
        [self.countTimer invalidate];
        self.countTimer=nil;
        if ([self.delegate respondsToSelector:@selector(KSProgressTimeUp:)]) {
            [self.delegate KSProgressTimeUp:self];
        }
    }
}
-(void)KSProgramTimerStart{
    if (![self.countTimer isValid]){
         self.showunderView.frame=CGRectMake(0, 0, 0, 5);
         self.toStartCountDown=self.originTimeFrequency;
        self.countTimer = [ NSTimer scheduledTimerWithTimeInterval:self.timeInterval?self.timeInterval:1.0 target:self selector:@selector(countTime:)userInfo:nil repeats:YES];
        [self.countTimer fire];
    }else{
        
    }
    
    self.timeCountLab.textColor=self.timeCountLabColor?self.timeCountLabColor:[UIColor blackColor];
    self.showunderView.backgroundColor=_timeCountColor?_timeCountColor:[UIColor orangeColor];
}
@end
