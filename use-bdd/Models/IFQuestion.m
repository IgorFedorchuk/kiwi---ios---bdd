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


@end

@implementation IFQuestion

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n questionID: %lu, title %@, asker: %@", (long)self.questionID, self.title, self.asker];
}

- (NSString *)debugDescription
{
    return [self description];
}

@end
