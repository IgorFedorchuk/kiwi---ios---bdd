//
//  IFQuestion.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFQuestion.h"
#import "IFPerson.h"

@interface IFQuestion()

@property (nonatomic, strong) NSMutableSet *answerSet;

@end

@implementation IFQuestion

- (id)init
{
    if (self = [super init])
    {
        self.answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [self.answerSet addObject: answer];
}

- (NSArray *)answers
{
    return [[self.answerSet allObjects] sortedArrayUsingSelector: @selector(compare:)];
}


@end
