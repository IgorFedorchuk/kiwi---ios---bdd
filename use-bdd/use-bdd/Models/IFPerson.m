//
//  IFPerson.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFPerson.h"

@interface IFPerson()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSURL *avatarURL;

@end

@implementation IFPerson

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location
{
    if ((self = [super init]))
    {
        self.name = [aName copy];
        self.avatarURL = [[NSURL alloc] initWithString: location];
    }
    return self;
}


@end
