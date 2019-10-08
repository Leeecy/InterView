//
//  SOTrackingSlider.h
//  SOSlider
//
//  Created by wangli on 2017/3/30.
//  Copyright © 2017年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
//title显示在滑块的上方或下方
typedef enum : NSUInteger{
    TopTitleStyle,
    BottomTitleStyle
}TitleStyle;


@protocol SOTrackingSliderDelegate;
@interface SOTrackingSlider : UISlider
@property (nonatomic, unsafe_unretained) id<SOTrackingSliderDelegate>delegate;
//是否显示百分比
@property (nonatomic,assign) BOOL isShowTitle;
@property (nonatomic,assign) TitleStyle titleStyle;

@end
@protocol SOTrackingSliderDelegate <NSObject>
@optional
- (void)currentValueOfSlider:(SOTrackingSlider *)slider;
- (void)beginSwipSlider:(SOTrackingSlider *)slider;
- (void)endSwipSlider:(SOTrackingSlider *)slider;
@end
