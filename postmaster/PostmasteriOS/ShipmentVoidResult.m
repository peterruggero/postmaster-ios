//
//  ShipmentVoidResult.m
//  PostmasteriOS
//
//  Created by luczakp on 08.07.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "ShipmentVoidResult.h"

@implementation ShipmentVoidResult

-(BOOL)voidSuccess{
    if(!_jsonErrorCode && !_jsonErrorMessage && !self.commonHTTPError){
        return YES;
    }
    return NO;
}

-(id)initWithJSON:(NSDictionary *)json{
    self = [super init];
    
    [self wrapJSONErrorData:json];
    
    return self;
}

@end
