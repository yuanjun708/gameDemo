//
//  AppDelegate.m
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/1/22.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "AppDelegate.h"
#import <TTkGameSDK/TTkGameSDK.h>
#import "Header.h"

#import <UserNotifications/UserNotifications.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <TwitterKit/TWTRKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SETUP_TTGCHUD
    
    // set SDK Api Enviroment
    [[TTkGameManager defaultManager] setServerDomainTest];
//    [[TTkGameManager defaultManager] setServerDomainProduction];
    [[TTkGameManager defaultManager] setPayEnvironmentTest];
    
    // open log
    [[TTkGameManager defaultManager] openLogInfo];
    
    // launch SDK test
    NSString *appId = @"LTAIe4EmdMyxioiR";
    NSString *appSecret = @"d96b2c8baa2a1bf6671ad29cfd3fb566";
    NSString *gameid = @"126847495400849409";
    
    [[TTkGameManager defaultManager] setupWithAppId:appId Secret:appSecret GameId:gameid Application:application Options:launchOptions];
        
    //fb
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    //tw
    [[Twitter sharedInstance] startWithConsumerKey:@"NfL3oT5912t6nsO00AlC3M0Nc" consumerSecret:@"3xCiiqVrTnpO1tJN0xaxTcquz1rBTqIGeEZzCV79z0lpHq9EXB"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.absoluteString hasPrefix:@"fb"]) {
        return [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    } else if ([url.absoluteString hasPrefix:@"twitter"]) {
        return [[Twitter sharedInstance] application:app openURL:url options:options];
    }
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
