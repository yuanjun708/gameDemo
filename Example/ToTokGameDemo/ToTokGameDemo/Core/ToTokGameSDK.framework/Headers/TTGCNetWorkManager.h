//
//  TTGCNetWorkManager.h
//  ToTokGameNetWork
//
//  Created by Balalaika on 2020/1/14.
//  Copyright © 2020 GMCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTGCNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTGCNetWorkManager : NSObject

//GET
+ (nullable TTGCHTTPSessionManager *)GET:(nonnull NSString *)URLString
                              parameters:(nullable id)parameters
                                progress:(nullable void (^)(NSProgress *_Nullable downloadProgress)) downloadProgress
                                 success:(nullable void (^)(id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSError *_Nonnull error))failure;

+ (nullable TTGCHTTPSessionManager *)GET:(nonnull NSString *)URLString
                              parameters:(nullable id)parameters
                                 success:(nullable void (^)(id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSError *_Nonnull error))failure;

//POST
+ (nullable TTGCHTTPSessionManager *)POST:(nonnull NSString *)URLString
                               parameters:(nullable id)parameters
                                 progress:(nullable void (^)(NSProgress *_Nonnull uploadProgress)) uploadProgress
                                  success:(nullable void (^)(id _Nullable responseObject))success
                                  failure:(nullable void (^)( NSError *_Nonnull error))failure;

+ (nullable TTGCHTTPSessionManager *)POST:(nonnull NSString *)URLString
                               parameters:(nullable id)parameters
                                  success:(nullable void (^)(id _Nullable responseObject))success
                                  failure:(nullable void (^)( NSError *_Nonnull error))failure;

//basePOST no token
+ (nullable TTGCHTTPSessionManager *)basePOST:(nonnull NSString *)URLString
                                   parameters:(nullable id)parameters
                                     progress:(nullable void (^)(NSProgress *_Nonnull uploadProgress)) uploadProgress
                                      success:(nullable void (^)(id _Nullable responseObject))success
                                      failure:(nullable void (^)( NSError * _Nonnull error))failure;

//PUT
+ (nullable TTGCHTTPSessionManager *)PUT:(nonnull NSString *)URLString
                              parameters:(nullable id)parameters
                                 success:(nullable void (^)(id _Nullable responseObject))success
                                 failure:(nullable void (^)( NSError * _Nonnull error))failure;

//DELETE
+ (nullable TTGCHTTPSessionManager *)DELETE:(nonnull NSString *)URLString
                                 parameters:(nullable id)parameters
                                    success:(nullable void (^)(id _Nullable responseObject))success
                                    failure:(nullable void (^)( NSError * _Nonnull error))failure;

//UPLOAD
+ (nullable TTGCHTTPSessionManager*)upload:(nonnull NSString *)URLString
                                     image:(UIImage *)image
                                parameters:(nullable id)parameters
                                   success:(nullable void (^)(id _Nullable responseObject))success
                                   failure:(nullable void (^)( NSError *_Nonnull error))failure;

+ (nullable TTGCHTTPSessionManager*)upload:(nonnull NSString *)URLString
                                    images:(NSMutableArray *)imagesArray
                                parameters:(nullable id)parameters
                                   success:(nullable void (^)(id _Nullable responseObject))success
                                   failure:(nullable void (^)( NSError *_Nonnull error))failure;

@end

NS_ASSUME_NONNULL_END
