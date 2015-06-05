//
//  IFAnswerRequest.m
//  use-bdd
//
//  Created by Igor on 6/5/15.
//  Copyright (c) 2015 IgorFedorchuk. All rights reserved.
//

#import "IFAnswerRequest.h"
#import "IFWebCore.h"
#import "IFQuestionBuilder.h"

@interface IFAnswerRequest ()

@property (nonatomic, strong) NSURL *url;

@end

@implementation IFAnswerRequest

- (instancetype)initWithPage:(NSInteger)page
{
    if (self = [super init])
    {
        NSString *urlString = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions?page=%ld&pagesize=10&order=desc&sort=activity&tagged=iphone&site=stackoverflow", (long)page];
        self.url = [NSURL URLWithString:urlString];
        NSLog(@"++++++++++urlString: %@", urlString);
    }
    return self;
}

- (void)sendWithCompletion:(IFItemsRequestBlock)completion
{
    static NSOperationQueue *operationQueue = nil;
    if (operationQueue == nil)
    {
        operationQueue = [NSOperationQueue new];
        operationQueue.maxConcurrentOperationCount = 1;
    }
    
    [IFWebCore requestWithUrl:self.url success:^(NSData *data) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (completion)
        {
            if (json)
            {
                IFQuestionBuilder *questionBuilder = [IFQuestionBuilder new];
                NSArray *questions = [questionBuilder questionsFromJSON:json];
                completion(YES, questions);
            }
            else
            {
                completion(NO, nil);
            }
        }

    } failure:^(NSError *error) {
        if (completion)
        {
            completion(NO, nil);
        }
    }];
}
@end
