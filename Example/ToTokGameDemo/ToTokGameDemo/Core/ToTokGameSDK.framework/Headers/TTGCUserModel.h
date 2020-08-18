//
//  TTGCUserModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/16.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  用户类型
 */
typedef NS_ENUM(NSInteger, TTGCLoginType) {
    TTGCLoginType_unloggedIn       = 0,             // unlogin
    TTGCLoginType_ToTok            = 1,             // ToTok user
    TTGCLoginType_GameCenter       = 2,             // GameCenter user
    TTGCLoginType_Facebook         = 3,             // Facebook user
    TTGCLoginType_Guest            = 4,             // Guest user
};

NS_ASSUME_NONNULL_BEGIN

@interface TTGCUserModel : NSObject

@property (nonatomic) TTGCLoginType userType; //user type
@property (nonatomic, copy) NSString *userId; //totok gamecenter userid
@property (nonatomic, copy) NSString *nickname; //nick name
@property (nonatomic, copy) NSString *photoUrl; //photo
@property (nonatomic, copy) NSString *pushOff;


@end

NS_ASSUME_NONNULL_END
