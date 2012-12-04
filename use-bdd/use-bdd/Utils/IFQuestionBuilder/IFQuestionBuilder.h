//
//  IFQuestionBuilder.h
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFStackOverflowRequest.h"
@protocol QuestionBuilderDelegate;

@interface IFQuestionBuilder : NSObject <StackOverflowRequestDelegate>

-(id)initWithDelegate:(id<QuestionBuilderDelegate>)delegate;

@end


@protocol QuestionBuilderDelegate <NSObject>

//- (void)fetchFailedWithError: (NSError *)error;
//- (void)receivedJSON: (NSDictionary *)json;

@end