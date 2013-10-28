//
//  IFStackOverflowRequest.h
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

@class AFHTTPRequestOperation;
@protocol StackOverflowRequestDelegate;


@interface IFStackOverflowRequest : NSObject

-(id)initWithDelegate:(id<StackOverflowRequestDelegate>)delegate urlString:(NSString *)urlString;
-(AFHTTPRequestOperation *)fetchQestions;

@end


@protocol StackOverflowRequestDelegate <NSObject>

- (void)fetchFailedWithError: (NSError *)error;
- (void)receivedJSON: (NSDictionary *)json;

@end