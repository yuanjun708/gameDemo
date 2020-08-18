//
//  TTGCProgressAnimatedView.h
//  TTGCProgressHUD
//
//  Created by Balalaika on 2020/1/18.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTGCProgressAnimatedView : UIView

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeEnd;

@end
