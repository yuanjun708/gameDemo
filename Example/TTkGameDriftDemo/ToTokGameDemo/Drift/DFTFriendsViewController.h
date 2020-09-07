//
//  DFTFriendsViewController.h
//  AmuseGameDemo
//
//  Created by Balalaika on 2020/9/1.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DFTFriendsViewController : BaseViewController

@property (nonatomic, copy) void(^friendsList)(NSArray *);

@end

NS_ASSUME_NONNULL_END
