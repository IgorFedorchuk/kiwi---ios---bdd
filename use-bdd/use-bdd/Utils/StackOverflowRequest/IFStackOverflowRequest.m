//
//  IFStackOverflowRequest.m
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFStackOverflowRequest.h"
#import "AFJSONRequestOperation.h"
NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";

@interface IFStackOverflowRequest()

@property(nonatomic, weak) id<StackOverflowRequestDelegate> delegate;

@end

@implementation IFStackOverflowRequest

-(id)initWithDelegate:(id<StackOverflowRequestDelegate>)requestDelegate
{
    if (self = [super init])
    {
        self.delegate = requestDelegate;
    }
    return self;
}

-(AFJSONRequestOperation *)fetchQestions
{
    NSURL *url = [NSURL URLWithString:questionsUrlString];    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSLog(@"questions: %@", [JSON valueForKeyPath:@"questions"]);
        [self.delegate receivedJSON:JSON];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"error: %@", error);
        [self.delegate fetchFailedWithError:error];
    }];
    return operation;
}


@end
