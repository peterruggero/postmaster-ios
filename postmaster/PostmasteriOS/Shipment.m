//
//  Shipment.m
//  PostmasteriOS
//
//  Created by luczakp on 21.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "Shipment.h"
#import "Postmaster.h"
#import "PostMasterRequest.h"

@implementation Shipment

NSString *const DICT_KEY_TRACKING_RESULTS = @"results";
NSString *const DICT_KEY_SHIPMENT_FETCH = @"results";
NSString *const DICT_KEY_SHIPMENT_PREVIOUS_CURSOR = @"previousCursor";
NSString *const DICT_KEY_SHIPMENT_CURSOR = @"cursor";
NSString *const DICT_KEY_TRACKING_RESULTS_HISTORY = @"history";
NSString *const DICT_KEY_DELIVERY_TIMES = @"services";

NSString *const SHIPMENT_KEY_CARRIER = @"carrier";
NSString *const SHIPMENT_KEY_CREATEDAT = @"created_at";
NSString *const SHIPMENT_KEY_COST = @"cost";
NSString *const SHIPMENT_KEY_FROM = @"from";
NSString *const SHIPMENT_KEY_SHIPMENTID = @"id";
NSString *const SHIPMENT_KEY_PACKAGEINFO = @"package";
NSString *const SHIPMENT_KEY_PACKAGECOUNT = @"package_count";
NSString *const SHIPMENT_KEY_PACKAGES = @"packages";
NSString *const SHIPMENT_KEY_STATUS = @"status";
NSString *const SHIPMENT_KEY_TO = @"to";
NSString *const SHIPMENT_KEY_TRACKING = @"tracking";
NSString *const SHIPMENT_KEY_SERVICE = @"service";
NSString *const SHIPMENT_KEY_REFERENCE = @"reference";


-(NSDictionary*)toJSONReadyDictionary{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_CARRIER andObject:self.carrier];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_CREATEDAT andObject:self.createdAt];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_COST andObject:self.cost];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_FROM andObject:[self.from toJSONReadyDictionary]];
        
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_SHIPMENTID andObject:self.shipmentId];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_PACKAGEINFO andObject:[self.packageInfo toJSONReadyDictionary]];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_PACKAGECOUNT andObject:self.packageCount];
    
    if(self.packages){
        [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_PACKAGES andObject:[Package convertToJsonArrayFromEntityArray:self.packages]];
    }
    
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_STATUS andObject:self.status];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_TO andObject:[self.to toJSONReadyDictionary]];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_TRACKING andObject:self.tracking];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_SERVICE andObject:self.service];
    [self putPropertyToJsonReadyDictionary:dict ofKey:SHIPMENT_KEY_REFERENCE andObject:self.reference];
 
    return dict;
}

-(id)initWithJSON:(NSDictionary*) jsonDict{
    if([jsonDict count] > 0){
    self = [super init];
    
    self.carrier = [jsonDict objectForKey:SHIPMENT_KEY_CARRIER];
    self.createdAt = [jsonDict objectForKey:SHIPMENT_KEY_CREATEDAT];
    self.cost = [jsonDict objectForKey:SHIPMENT_KEY_COST];
    self.from = [[Address alloc] initWithJSON:[jsonDict objectForKey:SHIPMENT_KEY_FROM]];
    self.shipmentId = [jsonDict objectForKey:SHIPMENT_KEY_SHIPMENTID];
    self.packageInfo = [[Package alloc] initWithJSON:[jsonDict objectForKey:SHIPMENT_KEY_PACKAGEINFO]];
    self.packageCount = [jsonDict objectForKey:SHIPMENT_KEY_PACKAGECOUNT];
    self.packages = [Package getFromJSONArray:[jsonDict objectForKey:SHIPMENT_KEY_PACKAGES]];
    self.status = [jsonDict objectForKey:SHIPMENT_KEY_STATUS];
    self.to = [[Address alloc] initWithJSON:[jsonDict objectForKey:SHIPMENT_KEY_TO]];
    self.tracking = [jsonDict objectForKey:SHIPMENT_KEY_TRACKING];
    self.service = [jsonDict objectForKey:SHIPMENT_KEY_SERVICE];
    self.reference = [jsonDict objectForKey:SHIPMENT_KEY_REFERENCE];
    
    return self;
    }
    return nil;
}

-(ShipmentCreationResult*)createShipment{
    
    PostMasterRequest *request = [PostMasterRequest createShipmentRequest:self];
    
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    
    ShipmentCreationResult* result;
    
    if(receivedError){
        result = [[ShipmentCreationResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        result = [[ShipmentCreationResult alloc] initWithJSON:jsonResponse];
    }

    return result;

}


+(ShipmentFetchResult*)fetchShipmentsWithCursor:(NSString*)cursor andLimit:(NSInteger)limit{
    PostMasterRequest *request = [PostMasterRequest fetchShipmentRequestWithCursor:cursor andLimit:limit];
    
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    
    ShipmentFetchResult* result;
    
    if(receivedError){
        result = [[ShipmentFetchResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        result = [[ShipmentFetchResult alloc] initWithJSON:jsonResponse];
    }
    
    return result;
}


+(ShipmentTrackResult*)track:(NSInteger) shipmentId{
    PostMasterRequest *request = [PostMasterRequest trackShipmentRequest:shipmentId];
    
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    
    ShipmentTrackResult* result;
    
    if(receivedError){
        result = [[ShipmentTrackResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        result = [[ShipmentTrackResult alloc] initWithJSON:jsonResponse];
    }
    
    return result;
}

-(ShipmentTrackResult*)track{
    return [Shipment track:[[self shipmentId]integerValue]];
}

+(ShipmentTrackByReferenceResult*)trackByReferenceNumber:(NSString*)referenceNumber{
    PostMasterRequest *request = [PostMasterRequest trackByReferenceNumber:referenceNumber];
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    ShipmentTrackByReferenceResult* result;
    
    if(receivedError){
        result =[[ShipmentTrackByReferenceResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        result =[[ShipmentTrackByReferenceResult alloc] initWithJSON:jsonResponse];
    }
   
    return result;
}

+(ShipmentVoidResult*)voidShipment:(NSInteger)shipmentId{
    PostMasterRequest *request = [PostMasterRequest voidShipmentRequest:shipmentId];
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    
    ShipmentVoidResult* result;
    
    if(receivedError){
        result = [[ShipmentVoidResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        
        result = [[ShipmentVoidResult alloc] initWithJSON:jsonResponse];
    }

    return result;
}

-(ShipmentVoidResult*)voidShipment{
    return [Shipment voidShipment:[[self shipmentId] integerValue]];
}

+(DeliveryTimeResult*)deliveryTime:(DeliveryTimeQueryMessage*)message{
    PostMasterRequest *request = [PostMasterRequest deliveryTimeRequest:message];
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
    
    DeliveryTimeResult* result;
    
    if(receivedError){
        result = [[DeliveryTimeResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        result = [[DeliveryTimeResult alloc] initWithJSON:jsonResponse];
    }
    
    return result;
}

+(RateResult*)rates:(RateQueryMessage*)rateMessage{
    PostMasterRequest *request = [PostMasterRequest rates:rateMessage];
    NSHTTPURLResponse *receivedResponse;
    NSError *receivedError;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&receivedResponse error:&receivedError];
   
    RateResult* result;
    
    if(receivedError){
        result = [[RateResult alloc] initWithCommonHTTPError:receivedError];
    }
    else{
        NSMutableDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&receivedError];
        
        result = [[RateResult alloc] initWithJSON:jsonResponse];
    }
    
    return result;
}

@end
