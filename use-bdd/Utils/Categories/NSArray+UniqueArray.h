//
//  NSArray+UniqueArray.h
//  use-bdd
//
//  Created by Igor on 11.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

typedef BOOL(^UniqueFunction)(id first, id second);

@interface NSArray (UniqueArray)

- (NSArray*)uniqueByBlock:(UniqueFunction)block;

@end
