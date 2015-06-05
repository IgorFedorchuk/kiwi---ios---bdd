//
//  IFWebCore.h
//  RSS
//
//  Created by Igor Fedorchuk on 02/11/14.
//  Copyright (c) 2014 Igor Fedorchuk. All rights reserved.
//

typedef void (^SuccessBlock)(NSData *data);
typedef void (^FailureBlock)(NSError *error);
typedef void (^SuccessImageRequestBlock)(BOOL success, NSString *imagePath);

@interface IFWebCore : NSObject

+ (void)requestWithUrl:(NSURL *)imageUrl imagePath:(NSString *)imagePath success:(SuccessImageRequestBlock)success;
+ (void)requestWithUrl:(NSURL *)url success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
