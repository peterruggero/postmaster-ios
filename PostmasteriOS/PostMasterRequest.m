//
//  PostMasterRequest.m
//  PostmasteriOS
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "PostMasterRequest.h"
#import "Settings.h"
#import "NSData+Base64.h"
#import "Postmaster.h"
#import "Shipment.h"

@implementation PostMasterRequest


+(PostMasterRequest*)validateAddressRequest:(Address*)address{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_POST version:API_VERSION_1 path:@"/validate" parameters:nil];
    [request addContentLengthWithDictionary:[address toJSONReadyDictionary] ];
    return request;
}

+(PostMasterRequest*)createShipmentRequest:(Shipment*)shipment{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_POST version:API_VERSION_1 path:@"/shipments" parameters:nil];
    [request addContentLengthWithDictionary:[shipment toJSONReadyDictionary] ];
    return request;
}

+(PostMasterRequest*)trackShipmentRequest:(NSInteger)shipmentId{
        PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_GET version:API_VERSION_1 path:[NSString stringWithFormat:@"/shipments/%d/track",shipmentId] parameters:nil];
        return request;
}

+(PostMasterRequest*)trackByReferenceNumber:(NSString*)referenceNumber{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_GET version:API_VERSION_1 path:[NSString stringWithFormat:@"/track?tracking=%@",referenceNumber] parameters:nil];
    return request;
}

+(PostMasterRequest*)voidShipmentRequest:(NSInteger)shipmentId{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_DELETE version:API_VERSION_1 path:[NSString stringWithFormat:@"/shipments/%d/void",shipmentId] parameters:nil];
    return request;
}

+(PostMasterRequest*)deliveryTimeRequest:(DeliveryTimeQueryMessage*)message{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_POST version:API_VERSION_1 path:@"/times" parameters:nil];
    [request addContentLengthWithDictionary:[message toJSONReadyDictionary] ];
    return request;
}

+(PostMasterRequest*)rates:(RateQueryMessage*)message{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_POST version:API_VERSION_1 path:@"/rates" parameters:nil];
    [request addContentLengthWithDictionary:[message toJSONReadyDictionary] ];
    return request;
}

+(PostMasterRequest*)fetchShipmentRequestWithCursor:(NSString*)cursor andLimit:(NSInteger)limit{
    PostMasterRequest* request = [self requestWithHTTPMethod:CONN_TYPE_GET version:API_VERSION_1 path:@"/shipments" parameters:nil];
    return request;
}

- (void)addContentLengthWithDictionary:(NSDictionary*)dictionary;
{
    NSError *jsonError;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                          options:0
                                                            error:&jsonError];
    
    if(jsonError)
        return;
    
    [self setValue:CONTENT_TYPE_JSON forHTTPHeaderField:CONTENT_TYPE_KEY];
    [self setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:CONTENT_LENGTH_KEY];
    [self setHTTPBody:requestData];
}


+ (PostMasterRequest *)requestWithHTTPMethod:(NSString *)method
                                     version:(NSString*)version
                                 path:(NSString *)path
                           parameters:(NSDictionary *)parameters;
{
    
    BOOL isPOST = [method isEqualToString:CONN_TYPE_POST];
    NSString *queryString = @"";
    NSString *URLString = [NSString stringWithFormat:@"%@/%@%@",API_DOMAIN,version,path];
    
    if(!isPOST){
        NSString *parameterString = [parameters URLQueryString];
        if([parameterString length] > 0)
            queryString = [NSString stringWithFormat:@"?%@", parameterString];
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URLString, queryString]];
    PostMasterRequest* request = [PostMasterRequest requestWithURL:url];
    [request setHTTPMethod:method];
    
    if(parameters && isPOST){
        NSData *body = [parameters HTTPBodyWithEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:body];
    }
    
    [request setValue:[NSString stringWithFormat:@"Basic %@=",[self getAuthEncodedString] ]forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    return request;
}

+(NSString *)getAuthEncodedString{
    NSString* toHash = [NSString stringWithFormat:@"%@:",[[Postmaster instance] getAPIKey]];
    NSData* data = [toHash dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedString];
}

@end
