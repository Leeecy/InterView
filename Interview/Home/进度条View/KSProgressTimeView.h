//
//  KSProgressTimeView.h
//  Interview
//
//  Created by kiss on 2020/4/27.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KSProgressTimeView;
@protocol  KSProgressTimeViewDelegate <NSObject>
//Time Up's Feedback  时间结束回调
-(void)KSProgressTimeUp:(KSProgressTimeView *)KSProgressTimeView;
-(void)timeChange:(NSString*)text;

@end
@interface KSProgressTimeView : UIView
//time Count Color           进度条颜色
@property (nonatomic, strong) UIColor  *timeCountColor;
//time Count Lab             计时栏
@property (nonatomic, weak  ) UILabel   *timeCountLab;
//time Count Lab Color       计时栏颜色
@property (nonatomic, strong) UIColor     *timeCountLabColor;
//origin Time Frequency      初始时间次数
@property (nonatomic, assign) CGFloat     originTimeFrequency;
//time Interval (Unit：Seconds)    计时间隔 （单位：秒）
@property (nonatomic, assign) CGFloat    timeInterval;
//total Time Frequency       计时总次数
@property (nonatomic, assign) CGFloat      totalTimeFrequency;
-(void)KSProgramTimerStart;
@property (nonatomic, weak  )id<KSProgressTimeViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
