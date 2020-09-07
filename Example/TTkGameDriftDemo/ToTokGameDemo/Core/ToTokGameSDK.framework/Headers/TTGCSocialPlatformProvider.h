//
//  TTGCSocialPlatformProvider.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/21.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTGCConfig.h"


NS_ASSUME_NONNULL_BEGIN

@protocol TTGCSocialPlatformProvider <NSObject>

@optional

/**
 *  初始化平台
 *
 *  @param launchOptions       第三方平台的appKey
 */
- (BOOL)ttgcSocial_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/**
 *  设置平台的appkey
 *
 *  @param appKey       第三方平台的appKey
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 */
- (BOOL)ttgcSocial_setAppKey:(NSString *)appKey
                   appSecret:(NSString *)appSecret
                 redirectURL:(NSString *)redirectURL;

/**
 *  授权
 *
 *  @param userInfo          用户的授权的自定义数据
 *  @param completionHandler 授权后的回调
 *  @discuss userInfo在有些平台可以带入，如果没有就传入nil.
 */
-(void)ttgcSocial_AuthorizeWithUserInfo:(NSDictionary *)userInfo
                withCompletionHandler:(TTGCSocialPlateLoginCompletionHandler)completionHandler;

/**
 *  取消授权
 *
 *  @param completionHandler 取消授权后的回调
 *  @discuss userInfo在有些平台可以带入，如果没有就传入nil.
 */
-(void)ttgcSocial_cancelAuthWithCompletionHandler:(TTGCSocialPlateLogoutCompletionHandler)completionHandler;


/**
 *  设置分享平台
 *
 *  @param messageObject  分享的content @see TTGCMessageObject
 *  @param completion   回调
 */
- (void)ttgcSocial_shareMessageObject:(TTGCSocialMessageObject *)messageObject
                           completion:(TTGCShareCompleteHandler)completion;


/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url               第三方sdk的打开本app的回调的url
 *  @param sourceApplication 回调的源程序
 *  @param annotation        annotation
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 *
 */
- (BOOL)ttgcSocial_application:(UIApplication *)application OpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)ttgcSocial_application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

//通用（备用）
- (BOOL)ttgcSocial_handleOpenURL:(NSURL *)url options:(NSDictionary*)options;

#pragma mark - Universal Link
- (BOOL)ttgc_application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler;

/**
 *  平台是否安装
 *
 *  @return YES 代表安装，NO 代表未安装
 */
- (BOOL)ttgcSocial_isInstall;

/**
 *  当前平台是否支持分享
 *
 *  @return YES代表支持，NO代表不支持
 */
- (BOOL)ttgcSocial_isSupport;

/**
 *  当前平台token是否有效
 *
 *  @return YES代表有效，NO代表无效
*/
- (BOOL)ttgcSocial_isCurrentAccessTokenActive;

#pragma mark - Facebook unique
/**
 *  Show Facebook friends and send game invitations.
 *
 *  @param messageObject  message content @see TTGCMessageObject
 *  @param completion   回调
 *
*/
- (void)ttgcSocial_showFBFriendsSendInvitations:(TTGCSocialMessageObject *)messageObject
                                     completion:(TTGCShareCompleteHandler)completion;

#pragma mark - GA unique

- (void)ttgcLog_eventShareWithTarget:(NSString *)target shareType:(NSString *)type;

- (void)ttgc_setAnalyticsUser;


@end

NS_ASSUME_NONNULL_END
