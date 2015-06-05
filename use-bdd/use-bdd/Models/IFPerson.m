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

- (instancetype)initWithName:(NSString *)aName avatarLocation:(NSString *)avatarLocation
{
    if ((self = [super init]))
    {
        self.name = [aName copy];
        if (avatarLocation)
        {
            self.avatarURL = [[NSURL alloc] initWithString:avatarLocation];
        }
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name %@, avatarURL: %@", self.name, self.avatarURL];
}

- (NSString *)debugDescription
{
    return [self description];
}

@end
