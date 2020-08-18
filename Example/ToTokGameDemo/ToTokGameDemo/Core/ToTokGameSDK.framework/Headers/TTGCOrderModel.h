//
//  TTGCOrderModel.h
//  ToTokGameSDK
//
//  Created by Balalaika on 2020/2/16.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTGCOrderModel : NSObject


@property (nonatomic, copy) NSString *orderId; //order id
@property (nonatomic, copy) NSString *orderRef; //pay-third orderid

@property (nonatomic, copy) NSString *channel; //pay channel  0: apple，1: google, 2: totok
@property (nonatomic, copy) NSString *env; //pay environment  0: sandbox，1: production
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *payTime;
@property (nonatomic, copy) NSString *cancelTime;

@property (nonatomic, copy) NSString *status; // 1: success, 2: failure


@end

NS_ASSUME_NONNULL_END
