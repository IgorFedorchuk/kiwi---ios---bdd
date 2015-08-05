//
//  IFPersonBuilder.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//


@class IFPerson;

@interface IFPersonBuilder : NSObject

+ (IFPerson *) personFromDictionary: (NSDictionary *) ownerValues;

@end
