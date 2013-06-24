//
//  PostMasterRequest.h
//  PostmasteriOS
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#define CONTENT_TYPE_KEY @"Content-Type"
#define CONTENT_TYPE_JSON @"application/json"

#define CONTENT_LENGTH_KEY @"Content-Length"

#define CONN_TYPE_POST @"POST"
#define CONN_TYPE_GET @"GET"
#define CONN_TYPE_DELETE @"DELETE"
#define CONN_TYPE_PUT @"PUT"
#define API_VERSION_1 @"v1"

#import <Foundation/Foundation.h>
#import "Address.h"
#import "Shipment.h"
#import "NSDictionary+Postmaster.h"

@interface PostMasterRequest : NSMutableURLRequest{
    NSString* _apiKey;
}

+(PostMasterRequest*)validateAddressRequest:(Address*)address;
+(PostMasterRequest*)createShipmentRequest:(Shipment*)shipment;
+(PostMasterRequest*)fetchShipmentRequestWithCursor:(NSString*)cursor andLimit:(NSInteger)limit;
+(PostMasterRequest*)trackShipmentRequest:(NSInteger)shipmentId;
+(PostMasterRequest*)trackByReferenceNumber:(NSString*)referenceNumber;
+(PostMasterRequest*)voidShipmentRequest:(NSInteger)shipmentId;
+(PostMasterRequest*)deliveryTimeRequest:(DeliveryTimeQueryMessage*)message;
+(PostMasterRequest*)rates:(RateQueryMessage*)message;

@end
