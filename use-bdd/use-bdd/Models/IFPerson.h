//
//  IFPerson.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//


@interface IFPerson : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *avatarURL;

- (instancetype)initWithName: (NSString *)aName avatarLocation: (NSString *)location;

@end
