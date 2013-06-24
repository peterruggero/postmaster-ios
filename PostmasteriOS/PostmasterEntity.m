//
//  PostmasterEntity.m
//  PostmasteriOS
//
//  Created by luczakp on 20.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "PostmasterEntity.h"

@implementation PostmasterEntity
-(void)putPropertyToJsonReadyDictionary:(NSMutableDictionary*)dict ofKey:(NSString*)key andObject:(NSObject*)object{
    if(object){
        [dict setObject:object forKey:key];
    }
}

+(NSArray*)convertToJsonArrayFromEntityArray:(NSArray*)entitiesArray{
    NSMutableArray* result = [NSMutableArray array];
    for(PostmasterEntity* entity in entitiesArray){
        [result addObject:[entity toJSONReadyDictionary]];
    }
    
    return result;
}

+(NSMutableArray*)getFromJSONArray:(NSDictionary*) jsonArray{
    NSMutableArray* result = [NSMutableArray array];
    for(NSDictionary* item in jsonArray){
        PostmasterEntity* entity = [[self alloc] initWithJSON:item];
        [result addObject:entity];
    }
    
    return result;
}

@end
