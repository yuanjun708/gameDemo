//
//  Header.h
//  ToTokGameDemo
//
//  Created by Balalaika on 2020/3/26.
//  Copyright © 2020 GMCT. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - 屏幕
#define IsPortrait (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || \
([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

/** Float: Return screen width **/
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
/** Float: Return screen height **/
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

// Device Info
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) /** BOOL: Detect if device is an iPad **/
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) /** BOOL: Detect if device is an iPhone or iPod **/

#pragma mark - 导航栏，状态栏，TabBar的高度
#define StatusBar_Height [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBar_Height 44.0
#define Nav_StatusBar_Height (NavBar_Height + StatusBar_Height)
#define TabBar_Height ([UIApplication sharedApplication].statusBarFrame.size.height > 20 ? 83 : 49)
#define KBottomSpace_Height ([UIApplication sharedApplication].statusBarFrame.size.height > 20 ? 34 : 0)


#endif /* Header_h */
