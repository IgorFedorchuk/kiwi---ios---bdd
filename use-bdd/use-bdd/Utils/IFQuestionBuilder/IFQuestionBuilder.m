//
//  IFQuestionBuilder.m
//  use-bdd
//
//  Created by Igor on 28.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFQuestionBuilder.h"
#import "IFQuestion.h"
#import "IFPersonBuilder.h"

@interface IFQuestionBuilder()

@end

@implementation IFQuestionBuilder

- (NSArray *)questionsFromJSON:(NSDictionary *)json
{
    NSArray *questions = [json objectForKey: @"questions"];
    if (json == nil || questions == nil)
    {
        return [NSArray array];
    }
    
    NSMutableArray *results = [NSMutableArray array];
    for (NSDictionary *parsedQuestion in questions)
    {
        IFQuestion *thisQuestion = [self questionFromParsedQuestion:parsedQuestion];
        if (thisQuestion)
        {
            [results addObject: thisQuestion];
        }
    }
    return results;
}

- (IFQuestion *)questionFromParsedQuestion:(NSDictionary *)parsedQuestion
{
    if (parsedQuestion == nil)
    {
        return nil;
    }
    
    IFQuestion *question = [IFQuestion new];
    question.questionID = [[parsedQuestion objectForKey: @"question_id"] integerValue];
    question.date = [NSDate dateWithTimeIntervalSince1970: [[parsedQuestion objectForKey: @"creation_date"] doubleValue]];
    question.title = [parsedQuestion objectForKey: @"title"];
    question.score = [[parsedQuestion objectForKey: @"score"] integerValue];
    NSDictionary *ownerValues = [parsedQuestion objectForKey: @"owner"];
    question.asker = [IFPersonBuilder personFromDictionary:ownerValues];
    return question;
}
@end
