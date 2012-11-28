//
//  IFStackOverflowRequest.h
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

@class AFJSONRequestOperation;
@protocol StackOverflowRequestDelegate;


@interface IFStackOverflowRequest : NSObject

-(id)initWithDelegate:(id<StackOverflowRequestDelegate>)delegate;
-(AFJSONRequestOperation *)fetchQestions;

@end


@protocol StackOverflowRequestDelegate <NSObject>

- (void)fetchFailedWithError: (NSError *)error;
- (void)receivedJSON: (NSDictionary *)json;

@end