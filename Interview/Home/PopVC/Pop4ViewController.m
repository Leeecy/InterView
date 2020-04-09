//
//  Pop4ViewController.m
//  Interview
//
//  Created by kiss on 2019/11/29.
//  Copyright © 2019 cl. All rights reserved.
//

#import "Pop4ViewController.h"
#import "InterCircleView.h"

#define VolumeNum (240/15) //16音量0-f
@interface Pop4ViewController (){
    int _currentAngle;
       int _originVolume;
}
@property(strong,nonatomic)InterCircleView *circleView;
@end

@implementation Pop4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor =[ UIColor blackColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth , ScreenHeight )];
  
    imgV.image = [UIImage imageNamed:@"set_bg"];
    [self.view addSubview:imgV];
    
    CGFloat circleX = (ScreenWidth - 275 -20*2)*0.5;
    self.circleView = [[InterCircleView alloc]initWithFrame:CGRectMake(23,100, ScreenWidth -23*2, ScreenWidth -23*2) lineWidth:2 circleAngle:240 imageName:@"qian" imageWidth:5];
      [self.view addSubview:self.circleView];
      
      self.circleView.angle = -210 + _originVolume * VolumeNum;
      
      _currentAngle = self.circleView.angle;
      [self.circleView addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
      [self.circleView addTarget:self action:@selector(touchValue:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void) newValue:(InterCircleView*)slider{
    _currentAngle = slider.angle;
 
    [self.circleView changeAngle:slider.angle];
    [self.circleView setNeedsDisplay];
    NSLog(@"newValue:%d",_currentAngle);
    //    [self writeDataWtihAngle:_currentAngle];
}
-(void)touchValue:(InterCircleView*)slider{
    _currentAngle = slider.angle;
   
    NSLog(@"touchValue:%d",_currentAngle);
    [self.circleView changeAngle:_currentAngle];
//    [self writeDataWtihAngle:_currentAngle];
    [self.circleView setNeedsDisplay];
}
- (NSInteger)getMinValueShowLevel:(NSArray *)showLevels mapZoomLevel:(CGFloat)mapZoomLevel{
    NSInteger suitValue = (int)mapZoomLevel;
    NSInteger diffLevel = 9999;
    for (NSNumber *showLevel in showLevels) {
        NSInteger diffLevelTmp = fabs(mapZoomLevel - [showLevel intValue]);
        if (diffLevelTmp < diffLevel) {
            diffLevel = diffLevelTmp;
            suitValue = [showLevel intValue];
        }
    }
    return suitValue;
}
@end
