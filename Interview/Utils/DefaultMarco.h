//
//  DefaultMarco.h
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#ifndef DefaultMarco_h
#define DefaultMarco_h


//size
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define SafeAreaTopHeight ((ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"] ? 88 : 64)
#define SafeAreaBottomHeight ((ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)

#define ScreenFrame [UIScreen mainScreen].bounds

//color
#define ColorThemeBackground RGBA(14.0, 15.0, 26.0, 1.0)
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define ColorWhiteAlpha20 RGBA(255.0, 255.0, 255.0, 0.2)
#define ColorWhiteAlpha40 RGBA(255.0, 255.0, 255.0, 0.4)
#define ColorWhiteAlpha60 RGBA(255.0, 255.0, 255.0, 0.6)
#define ColorWhiteAlpha80 RGBA(255.0, 255.0, 255.0, 0.8)
#define ColorThemeRed RGBA(241.0, 47.0, 84.0, 1.0)
#define ColorThemeYellow RGBA(250.0, 206.0, 21.0, 1.0)


#define ColorClear [UIColor clearColor]
#define ColorBlack [UIColor blackColor]
#define ColorWhite [UIColor whiteColor]
#define ColorGray  [UIColor grayColor]

//font
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

#define SuperSmallFont [UIFont systemFontOfSize:10.0]
#define SuperSmallBoldFont [UIFont boldSystemFontOfSize:10.0]

#define SmallFont [UIFont systemFontOfSize:12.0]
#define SmallBoldFont [UIFont boldSystemFontOfSize:12.0]

#define MediumFont [UIFont systemFontOfSize:14.0]
#define MediumBoldFont [UIFont boldSystemFontOfSize:14.0]

#define BigFont [UIFont systemFontOfSize:16.0]
#define BigBoldFont [UIFont boldSystemFontOfSize:16.0]

#define LargeFont [UIFont systemFontOfSize:18.0]
#define LargeBoldFont [UIFont boldSystemFontOfSize:18.0]

#define SuperBigFont [UIFont systemFontOfSize:26.0]
#define SuperBigBoldFont [UIFont boldSystemFontOfSize:26.0]

#define BaseUrl  @"http://116.62.9.17:8080/douyin/"



#endif /* DefaultMarco_h */
