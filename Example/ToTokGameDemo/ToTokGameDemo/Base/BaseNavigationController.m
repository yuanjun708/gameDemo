//
//  BaseNavigationController.m
//  ChildrenPalace
//
//  Created by Ji Feng on 2018/12/17.
//  Copyright © 2018 Ji Feng. All rights reserved.
//

#import "BaseNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (InteractivePopGestureRecognizerEnable)

- (void)setInteractivePopGestureRecognizerEnable:(BOOL)interactivePopGestureRecognizerEnable {
    objc_setAssociatedObject(self, @selector(interactivePopGestureRecognizerEnable), [NSNumber numberWithBool:interactivePopGestureRecognizerEnable], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)interactivePopGestureRecognizerEnable {
    NSNumber *enable = objc_getAssociatedObject(self, _cmd);
    if (!enable) {
        return YES;
    }
    return enable.boolValue;
}

@end

@interface BaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.interactivePopGestureRecognizer.enabled = NO;
    [super pushViewController:viewController animated:animated];
}

- (void)backAction {
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    if (self.viewControllers.count > 1) {
        self.interactivePopGestureRecognizer.enabled = viewController.interactivePopGestureRecognizerEnable;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.childViewControllers count] <= 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return YES;
}

//解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end
