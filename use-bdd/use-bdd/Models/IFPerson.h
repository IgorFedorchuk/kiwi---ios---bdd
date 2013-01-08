//
//  IFPerson.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//


@interface IFPerson : NSObject

@property (readonly, strong) NSString *name;
@property (readonly, strong) NSURL *avatarURL;

- (id)initWithName: (NSString *)aName avatarLocation: (NSString *)location;

@end
