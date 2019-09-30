//
//  AppDelegate.h
//  Interview
//
//  Created by cl on 2019/7/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL updateInProgress;
@property (nonatomic) NSString *updateFileName;
@property (nonatomic) double updateProgress;

@end

