//
//  PostmasterEntity.h
//  PostmasteriOS
//
//  Created by luczakp on 20.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostmasterEntity : NSObject

-(NSDictionary*)toJSONReadyDictionary;
-(id)initWithJSON:(NSDictionary*) jsonDict;
+(NSMutableArray*)getFromJSONArray:(NSDictionary*) jsonArray;
+(NSArray*)convertToJsonArrayFromEntityArray:(NSArray*)entitiesArray;
-(void)putPropertyToJsonReadyDictionary:(NSMutableDictionary*)dict ofKey:(NSString*)key andObject:(NSObject*)object;

@end
