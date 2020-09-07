//
//  TTGCMessageModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/5.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTGCMessageModel : NSObject

@property (nonatomic, copy) NSString *ttkUid; //好友的totok 用户id或者群组id
@property (nonatomic, copy) NSString *templateId; //消息模板id
@property (nonatomic, copy) NSString *message;//消息内容 TODO

@end

NS_ASSUME_NONNULL_END
