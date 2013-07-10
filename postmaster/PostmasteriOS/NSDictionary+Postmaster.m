//
//  NSDictionary.m
//  PostmasteriOS
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "NSDictionary+Postmaster.h"

@implementation NSDictionary(Postmaster)

- (NSString *)URLQueryString {
    NSUInteger count = [self count];
    
    if(count == 0)
        return @"";
    
    NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:count];
    Class stringClass = [NSString class];
    
    for(NSString *name in self){
        id value = [self objectForKey:name];
        NSString *stringValue = nil;
        
        if(!value)
            stringValue = @"";
        else if([value isKindOfClass:stringClass])
            stringValue = value;
        else if ([value respondsToSelector:@selector(stringValue)])
            stringValue = [value stringValue];
        else
            stringValue = [value description];
        
        NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)stringValue, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8);
        
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", name, result]];
    }
    
    return [pairs componentsJoinedByString:@"&"];
}

- (NSData *)HTTPBodyWithEncoding:(NSStringEncoding)encoding {
    return [[self URLQueryString] dataUsingEncoding:encoding];
}

- (id)objectForInt:(NSInteger)key;
{
    return [self objectForKey:[NSNumber numberWithInt:key]];
}



@end

@implementation NSMutableDictionary(Postmaster)


- (void)setBool:(BOOL)value forKey:(id)key {
    if (value) {
        [self setObject:@"true" forKey:key];
    } else {
        [self setObject:@"false" forKey:key];
    }
}

- (NSInteger)integerForKey:(id)key;
{
    NSNumber *integer = [self objectForKey:key];
    if(![integer isKindOfClass:[NSNumber class]])
        return 0;
    
    return [integer integerValue];
}

- (void)setInteger:(NSInteger)value forKey:(id)key {
    [self setObject:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)removeObjectForInt:(NSInteger)key;
{
    [self removeObjectForKey:[NSNumber numberWithInteger:key]];
}

- (void)setObject:(id)anObject forInt:(NSInteger)key;
{
    [self setObject:anObject forKey:[NSNumber numberWithInt:key]];
}


@end
