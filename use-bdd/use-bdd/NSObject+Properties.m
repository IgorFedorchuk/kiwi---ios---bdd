//
//  NSObject+Properties.m
//  Pic24
//
//  Created by Oleg Lola on 13.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

- (NSArray *)propertyList
{
    NSMutableArray* propertyList = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *propertyType = [NSString stringWithCString:propType encoding:NSUTF8StringEncoding];
            [propertyList addObject:[NSDictionary dictionaryWithObjectsAndKeys:propertyName,@"propertyName",propertyType,@"propertyType", nil]];
        }
    }
    free(properties);
    return propertyList;
}

-(BOOL)hasPropertyWithName:(NSString *)name object:(NSObject *)object
{
    if (!object || !name)
    {
        return NO;
    }
    
    NSArray* propertyList = [object propertyList];
    BOOL hasProperty = NO;
    for (NSDictionary *propertyInfo in propertyList)
    {
        NSString *propertyName = [propertyInfo objectForKey:@"propertyName"];
        if([propertyName isEqualToString:name])
        {
            hasProperty = YES;
            break;
        }
    }
    return hasProperty;
}

-(id)valueForPropertyName:(NSString *)name
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL propertyGetter = NSSelectorFromString(name);
    return[self performSelector:propertyGetter];
#pragma clang diagnostic pop
}

@end
