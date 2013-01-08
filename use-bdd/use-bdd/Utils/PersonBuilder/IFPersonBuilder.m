//
//  IFPersonBuilder.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFPersonBuilder.h"
#import "IFPerson.h"

@implementation IFPersonBuilder

+ (IFPerson *) personFromDictionary: (NSDictionary *) ownerValues
{
    NSString *name = [ownerValues objectForKey: @"display_name"];
    NSString *avatarURL = [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey: @"email_hash"]];
    return [[IFPerson alloc] initWithName: name avatarLocation: avatarURL];
}


@end
