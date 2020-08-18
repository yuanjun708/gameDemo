//
//  Created by Balalaika on 2020/1/18.
//  Copyright © 2020 GMCT. All rights reserved.
//

#define IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0

#define MAXFLOAT    0x1.fffffep+127f

#import "TTGCProgressHUD.h"

#pragma mark - TTGCProgressHUD

/**
*  TTGCHUD 初始设置
*
*/
#define SETUP_TTGCHUD   {\
[TTGCProgressHUD setMinimumDismissTimeInterval:1.5];\
[TTGCProgressHUD setDefaultStyle:TTGCProgressHUDStyleCustom];\
[TTGCProgressHUD setBackgroundColor:[UIColor groupTableViewBackgroundColor]];\
[TTGCProgressHUD setDefaultMaskType:TTGCProgressHUDMaskTypeClear];\
}

/**
 *  TTGCHUD 展示 默认隐藏
 *
 */
#define TTGCHUD_Normal(meg)   {\
[TTGCProgressHUD showWithStatus:meg];\
[TTGCProgressHUD dismissAfterDelay:1.5];\
}

/**
 *  TTGCHUD 展示 默认不隐藏
 *
 */
#define TTGCHUD_NO_Stop(meg) {\
[TTGCProgressHUD showWithStatus:meg];\
}

/**
 *  TTGCHUD 隐藏
 *
 */
#define TTGCHUD_Stop [TTGCProgressHUD dismiss];

/**
 *  TTGCHUD 请求失败
 */
#define TTGCHUD_HTTP_ERROR(msg) [TTGCProgressHUD showErrorWithStatus:msg?msg:@"Faild"];

/**
 *  TTGCHUD 请求成功
 */
#define TTGCHUD_HTTP_SUCCESS(msg) [TTGCProgressHUD showSuccessWithStatus:msg?msg:@"Success"];

/**
 *  TTGCHUD 提示
 */
#define TTGCHUD_HINT(msg) [TTGCProgressHUD showInfoWithStatus:msg];

/**
 *  TTGCHUD 请求失败
 */
#define TTGCHUD_ERROR(msg) [TTGCProgressHUD showErrorWithStatus:msg];

/**
 *  TTGCHUD 请求成功
 */
#define TTGCHUD_SUCCESS(msg) [TTGCProgressHUD showSuccessWithStatus:msg];

