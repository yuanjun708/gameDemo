//
//  TTGCWebViewController.h
//  TTkGameSDK
//
//  Created by Balalaika on 2020/3/5.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TGWebViewController : UIViewController

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) NSURL *url;

@end

NS_ASSUME_NONNULL_END
