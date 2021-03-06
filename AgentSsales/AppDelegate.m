//
//  AppDelegate.m
//  AgentSsales
//
//  Created by 英诺 on 2016/12/16.
//  Copyright © 2016年 英诺. All rights reserved.
//

#import "AppDelegate.h"

#import "YNTabBarController.h"

#import "YNLoginViewController.h"



@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //测试更新
    [self FirUpdateApplication:application didFinishLaunchingWithOptions:launchOptions];
    //第三方分享
    [self ThirdShareApplication:application didFinishLaunchingWithOptions:launchOptions];
    //第三方支付
    [self ThirdPayApplication:application didFinishLaunchingWithOptions:launchOptions];
    //第三方客服
    [self ThirdChatApplication:application didFinishLaunchingWithOptions:launchOptions];
    //第三方推送
    [self JPushApplication:application didFinishLaunchingWithOptions:launchOptions];
    //通知设置
    [CRToastManager setDefaultOptions:@{kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                                        kCRToastFontKey             : [UIFont fontWithName:@"HelveticaNeue-Light" size:16],
                                        kCRToastTextColorKey        : [UIColor whiteColor],
                                        kCRToastBackgroundColorKey  : [UIColor orangeColor],
                                        kCRToastAutorotateKey       : @(YES)}];
    //请求配置
    [YNHttpManagers setupHttpTool];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    [window makeKeyAndVisible];
    id userLoginInfors = [DEFAULTS valueForKey:kUserLoginInfors];
    if (userLoginInfors == nil) {
        UINavigationController *nVc = [[UINavigationController alloc] initWithRootViewController:[[YNLoginViewController alloc] init]];
        self.window.rootViewController = nVc;
    }else{
        YNTabBarController *tab = [[YNTabBarController alloc]init];
        self.window.rootViewController = tab;
    }
    // Override point for customization after application launch.
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
}


@end
