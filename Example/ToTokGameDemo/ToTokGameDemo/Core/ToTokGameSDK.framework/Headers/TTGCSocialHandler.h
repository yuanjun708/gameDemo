//
//  TTGCSocialHandler.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/21.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTGCSocialPlatformProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTGCSocialHandler : NSObject <TTGCSocialPlatformProvider>

/**
*  实现所有平台的基类
*  @discuss
*  前提条件:需要在主工程配置 other link flag -ObjC
*  所有实现TTGCSocialHandler对应平台类型子类，需要重写如下方法：
*  1.+(NSArray*) socialPlatformTypes; 返回对应平台的类型的数组，此处用数组是为了在微信和qq的平台是可以有不同的平台类型（微信，朋友圈等）与统一handler公用
*  2.重写load函数：
*  代码示例：
*   +(void)load
*   {
*       [super load];//必须调用
*   }
*
*  重载后保证调用基类的[UMSocialHandler load]
*  3.重写defaultManager单例类方法，保证运行时能找到defaultManager来获得当前的单例方法,保证其唯一性。
*/
#pragma mark - 子类需要重载的类
+ (void)load;

+ (NSArray*)socialPlatformTypes;

+ (instancetype)defaultManager;


#pragma mark -
@property (nonatomic, copy) NSString *appID;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *redirectURL;


@property (nonatomic, weak) UIViewController *currentViewController;

@end

NS_ASSUME_NONNULL_END
