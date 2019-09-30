//
//  AppDelegate.m
//  Interview
//
//  Created by cl on 2019/7/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import "AppDelegate.h"
#import "Main/MainTabBarController.h"
#import "Utils/RunLoop/CLMonitorRunloop.h"
#import "CSRConnectionManager.h"

extern CFAbsoluteTime StartTime;

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize updateFileName;
@synthesize updateInProgress;
@synthesize updateProgress;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[CLMonitorRunloop sharedInstance]startMonitor];
//    [CLMonitorRunloop sharedInstance].callbackWhenStandStill = ^{
//        NSLog(@"eagle.检测到卡顿了");
//        
//    };
    
    #if DEBUG
        // iOS
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
        // macOS
        //[[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
    #endif
    
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    MainTabBarController *rootViewController = [[MainTabBarController alloc] init];
    [self.window setRootViewController:rootViewController];
//    [self setUpNavigationBarAppearance];
    double launchTime = (CFAbsoluteTimeGetCurrent() - StartTime);

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[CSRConnectionManager sharedInstance] shutDown];
}


@end
