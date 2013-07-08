//
//  PostmasteriOSTests.m
//  PostmasteriOSTests
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "PostmasteriOSTests.h"
#import "Address.h"
#import "Shipment.h"
#import "Package.h"
#import "Service.h"
#import "DeliveryTimeQueryMessage.h"
#import "RateQueryMessage.h"

@implementation PostmasteriOSTests

- (void)setUp
{
    [super setUp];
    [[Postmaster instance] setAPIKey:API_KEY];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


-(void)testInit{
        
}


-(void)test_01_ValidateAddress{

    Address *address = [[Address alloc] init];
    address.city = @"Austin";
    address.country = @"US";
    address.contact = @"Joe Smith";
    address.line1 = @"1110 Algarita Ave.";
    address.residential = YES;
    address.state = @"TX";
    address.zipCode = @"78704";
    
    BOOL testResult = NO;
    
    AddressValidationResult* result = [address validate];
    if(result && ([[result standarizedAddresses] count] > 0)){
        Address* receivedAddress = [[result standarizedAddresses] objectAtIndex:0];
        if([address.city isEqualToString:receivedAddress.city]){
            testResult = YES;
        }
    }
    
    if(!testResult){
        STFail(@"No appropriate address was returned");
    }
    NSLog(@"%@",result);
}



-(void)test_02_CreateShipment{
    
    Shipment* sh =[[Shipment alloc] init];
    Address* toAddress = [[Address alloc]init];
    Package* pkg = [[Package alloc]init];

    toAddress.company = @"ASLS";
    toAddress.contact = @"Joe Smith";
    toAddress.line1 = @"1110 Someplace Ave.";
    toAddress.city = @"Austin";
    toAddress.phoneNumber = @"1231231239";
    toAddress.state = @"TX";
    toAddress.zipCode = @"78704";

    sh.to = toAddress;
    sh.carrier = @"ups";
    sh.service = @"2DAY";

    pkg.width = [NSNumber numberWithInt:10];
    pkg.height = [NSNumber numberWithInt:6];
    pkg.length = [NSNumber numberWithInt:8];
    pkg.weight = [NSNumber numberWithFloat:1.5f];
    pkg.value = @"55";

    sh.packageInfo = pkg;
    sh.reference = @"Order # 54321";

   
    ShipmentCreationResult* result = [sh createShipment];
    
    if(!result.commonHTTPError && ![result jsonErrorMessage] && ([result shipment])){
        STFail(@"Shipment creation failed");
    }
    NSLog(@"%@",result);

}


-(void)test_031_getShipments{
    
    ShipmentFetchResult* result = [Shipment fetchShipmentsWithCursor:nil andLimit:5];
    BOOL testResult = NO;
    
    if(result && ([[result shipments] count]>0)){
        testResult = YES;
    }
    
    if(!testResult){
        STFail(@"Nothing was returned");
    }
    
    NSLog(@"%@",result);
}


-(void)test_03_trackShipment{
    
    ShipmentTrackResult* result = [Shipment track:1002];
    
    if(![result trackingDetails]){
        STFail(@"Nothing was returned");
    }
    NSLog(@"%@",result);
    
}


-(void)test_04_trackShipmentByRefNo{
    
    ShipmentTrackByReferenceResult* result = [Shipment trackByReferenceNumber:@"1Z8V81310297718490"];

    if(([[result trackingHistoryList] count]) == 0 && ![result jsonErrorMessage]){
        STFail(@"Nothing was returned");
    }
    
    NSLog(@"%@",result);
    
}

 
-(void)test_05_voidShipment{
    
    ShipmentVoidResult* result = [Shipment voidShipment:1004];
    if([result voidSuccess]){
        NSLog(@"VOID SUCCESSFUL");
    }
    else{
        NSLog(@"VOID FAILED");
    }
    
    if(![result voidSuccess] && ![result jsonErrorMessage]){
        STFail(@"Nothing was returned");
    }
    
    NSLog(@"%@",result);
    
}

 
-(void)test_06_deliveryTimesTest{
       
    DeliveryTimeQueryMessage* service = [[DeliveryTimeQueryMessage alloc] init];
    service.carrier = @"ups";
    service.fromZip = @"28771";
    service.toZip = @"78704";
    service.weight = [NSNumber numberWithFloat:1.0f];
    DeliveryTimeResult* result = [Shipment deliveryTime:service];
    
    if([[result services] count] == 0){
        STFail(@"No services returned");
    }
    
    NSLog(@"Result:%@",result);
}


-(void)test_07_ratesTest{
    
    RateQueryMessage* message = [[RateQueryMessage alloc] init];
    message.carrier = @"fedex";
    message.fromZip = @"28771";
    message.toZip = @"78704";
    message.weight = [NSNumber numberWithFloat:1.0f];
    
    RateResult* result = [Shipment rates:message];
    
    if(![result rate]){
        STFail(@"No rate returned");
    }
    
    NSLog(@"%@",result);
}
 

@end
