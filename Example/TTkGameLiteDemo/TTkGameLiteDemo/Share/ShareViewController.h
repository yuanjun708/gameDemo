//
//  ShareViewController.h
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <TTkGameSDK/TTkGameSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareViewController : BaseViewController

@property (nonatomic) TTGCLoginType userType;

@end

NS_ASSUME_NONNULL_END
