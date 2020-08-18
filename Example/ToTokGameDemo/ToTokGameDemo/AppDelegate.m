//
//  AppDelegate.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/1/22.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "AppDelegate.h"
#import <TTkGameSDK/TTkGameSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
    

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // set SDK Api Enviroment
    [[TTkGameManager defaultManager] setServerDomainTest];
    [[TTkGameManager defaultManager] setPayEnvironmentTest];
    
    // open log
    [[TTkGameManager defaultManager] openLogInfo];
    
    // launch SDK
    NSString *appId = @"LTAIe4EmdMyxioiR";
    NSString *appSecret = @"d96b2c8baa2a1bf6671ad29cfd3fb566";
    NSString *gameid = @"126847495400849409";
    [[TTkGameManager defaultManager] setupWithAppId:appId Secret:appSecret GameId:gameid Application:application Options:launchOptions];
    
    [self noti];
    return YES;
}

- (void)noti {
    [[TTkGameManager defaultManager] accountBannedNotification:^(NSString * _Nullable information, NSString * _Nullable time) {
        NSLog(@"--%@--",information);
        NSLog(@"--%@--",time);
    }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [[TTkGameManager defaultManager] application:app openURL:url options:options];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[TTkGameManager defaultManager] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[TTkGameManager defaultManager] application:application didReceiveRemoteNotification:userInfo];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[TTkGameManager defaultManager] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[TTkGameManager defaultManager] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[TTkGameManager defaultManager] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[TTkGameManager defaultManager] applicationWillTerminate:application];
}

#pragma mark Universal Link
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [[TTkGameManager defaultManager] application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}


@end
