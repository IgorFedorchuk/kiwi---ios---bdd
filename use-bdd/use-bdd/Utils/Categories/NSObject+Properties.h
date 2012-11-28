//
//  NSObject+Properties.h
//  Pic24
//
//  Created by Oleg Lola on 13.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Properties)

- (NSArray*)propertyList;
- (id)valueForPropertyName:(NSString *)name;

@end
