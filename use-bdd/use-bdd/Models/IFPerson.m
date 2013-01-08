//
//  IFPerson.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFPerson.h"


@implementation IFPerson

@synthesize name;
@synthesize avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location {
    if ((self = [super init]))
    {
        name = [aName copy];
        avatarURL = [[NSURL alloc] initWithString: location];
    }
    return self;
}


@end
