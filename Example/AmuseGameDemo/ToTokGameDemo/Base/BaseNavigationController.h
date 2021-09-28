//
//  BaseNavigationController.h
//  ChildrenPalace
//
//  Created by Ji Feng on 2018/12/17.
//  Copyright © 2018 Ji Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (InteractivePopGestureRecognizerEnable)

@property (nonatomic, unsafe_unretained) BOOL interactivePopGestureRecognizerEnable;

@end

@interface BaseNavigationController : UINavigationController

@end

NS_ASSUME_NONNULL_END
