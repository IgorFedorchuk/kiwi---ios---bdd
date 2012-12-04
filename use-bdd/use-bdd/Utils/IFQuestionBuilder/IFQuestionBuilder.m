//
//  IFQuestionBuilder.m
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFQuestionBuilder.h"

@interface IFQuestionBuilder()

@property(nonatomic, weak) id<QuestionBuilderDelegate> delegate;

@end

@implementation IFQuestionBuilder

-(id)initWithDelegate:(id<QuestionBuilderDelegate>)requestDelegate
{
    if (self = [super init])
    {
        self.delegate = requestDelegate;
    }
    return self;
}

#pragma mark - StackOverflowRequestDelegate
- (void)fetchFailedWithError:(NSError *)error
{
}

- (void)receivedJSON:(NSDictionary *)json
{
}

@end
