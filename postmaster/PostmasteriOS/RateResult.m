//
//  RateResult.m
//  PostmasteriOS
//
//  Created by luczakp on 24.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "RateResult.h"

@implementation RateResult

-(id)initWithJSON:(NSDictionary*)json{
    self=[super init];
    [self wrapJSONErrorData:json];
    if(!_jsonErrorCode){
        _rate = [[Rate alloc] initWithJSON:json];
    }
    return self;
}

@end
