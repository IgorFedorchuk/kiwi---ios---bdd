//
//  NSArray+UniqueArray.m
//  use-bdd
//
//  Created by Igor on 11.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

#import "NSArray+UniqueArray.h"

@implementation NSArray (UniqueArray)

- (BOOL) containsObject:(id)target byBlock:(UniqueFunction)block
{
    for (id item in self)
    {
        if (block(target, item))
        {
            return YES;
        }
    }
    return NO;
}

- (NSArray*)uniqueByBlock:(UniqueFunction)block
{
    NSMutableArray* result = [NSMutableArray array];
    for (id item in self)
    {
        if (![result containsObject:item byBlock:block])
        {
            [result addObject:item];
        }
    }
    return result;
}

@end
