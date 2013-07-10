//
//  NSDictionary.h
//  PostmasteriOS
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(Postmaster)

- (NSString *)URLQueryString;
- (NSData *)HTTPBodyWithEncoding:(NSStringEncoding)encoding;
- (id)objectForInt:(NSInteger)key;

@end

@interface NSMutableDictionary(Postmaster)

- (NSInteger)integerForKey:(id)key;
- (void)setBool:(BOOL)value forKey:(id)key;
- (void)setInteger:(NSInteger)value forKey:(id)key;
- (void)removeObjectForInt:(NSInteger)key;
- (void)setObject:(id)anObject forInt:(NSInteger)key;

@end