//
//  IFStackOverflowRequest.m
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFStackOverflowRequest.h"
#import "AFJSONRequestOperation.h"

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

-(AFJSONRequestOperation *)fetchQestions
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
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
