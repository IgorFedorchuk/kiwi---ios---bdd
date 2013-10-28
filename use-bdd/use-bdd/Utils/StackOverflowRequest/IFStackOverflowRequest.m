//
//  IFStackOverflowRequest.m
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFStackOverflowRequest.h"
#import "AFNetworking.h"

@interface IFStackOverflowRequest()

@property(nonatomic, weak) id<StackOverflowRequestDelegate> delegate;
@property(nonatomic, strong) NSURL *url;

@end

@implementation IFStackOverflowRequest

-(id)initWithDelegate:(id<StackOverflowRequestDelegate>)requestDelegate urlString:(NSString *)urlString
{
    if (self = [super init])
    {
        self.delegate = requestDelegate;
        self.url = [NSURL URLWithString:urlString]; 
    }
    return self;
}

-(AFHTTPRequestOperation *)fetchQestions
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"questions: %@", [responseObject valueForKeyPath:@"questions"]);
        [self.delegate receivedJSON:responseObject];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error: %@", error);
        [self.delegate fetchFailedWithError:error];
    }];
    return operation;
}

@end
