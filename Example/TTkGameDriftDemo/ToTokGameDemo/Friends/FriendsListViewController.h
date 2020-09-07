//
//  FriendsListViewController.h
//
//  Created by Balalaika on 2020/2/19.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendsListViewController : BaseViewController

typedef void (^userList)(NSArray *list);

@property (nonatomic, copy) userList selectUsers;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isBotim;
@property (nonatomic) BOOL isDrift;

@end

NS_ASSUME_NONNULL_END
