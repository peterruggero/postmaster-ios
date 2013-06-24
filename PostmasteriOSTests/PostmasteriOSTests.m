//
//  PostmasteriOSTests.m
//  PostmasteriOSTests
//
//  Created by luczakp on 17.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "PostmasteriOSTests.h"
#import "Address.h"
#import "TestDelegate.h"
#import "Shipment.h"
#import "Package.h"
#import "Service.h"
#import "DeliveryTimeQueryMessage.h"
#import "RateQueryMessage.h"

@implementation PostmasteriOSTests

-(void)hangUntilAsyncFinished:(TestDelegate*) delegate:(int) secondsTimeout{
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:secondsTimeout];
    
    if(delegate!=nil){
        while ([delegate done] == NO && [loopUntil timeIntervalSinceNow] > 0) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                     beforeDate:loopUntil];
        }
        if(![delegate done]){
            STFail(@"Timeout reached!");
        }
    }
    else{
        while ([loopUntil timeIntervalSinceNow] > 0) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                     beforeDate:loopUntil];
        }
    }
    
}

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
    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
    Address *address = [[Address alloc] init];
    address.city = @"Austin";
    address.country = @"US";
    address.contact = @"Joe Smith";
    address.line1 = @"1110 Algarita Ave.";
    address.residential = YES;
    address.state = @"TX";
    address.zipCode = @"78704";
    
    [address validate];
    [self hangUntilAsyncFinished:nil :20];
}

/*
-(void)test_02_CreateShipment{

    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
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

    [sh createShipment];
    
    [self hangUntilAsyncFinished:nil :20];


}
 */

/*
-(void)test_03_trackShipment{
    __block TestDelegate* sender = [[TestDelegate alloc] init];

    [Shipment track:1002];
    
    [self hangUntilAsyncFinished:nil :20];
}
 */

/*

-(void)test_04_trackShipment{
    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
    [Shipment trackByReferenceNumber:@"1Z8V81310297718490"];
    
    [self hangUntilAsyncFinished:nil :20];
}
*/
 
/*
-(void)test_05_voidShipment{
    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
    [Shipment voidShipment:1004];
    
    [self hangUntilAsyncFinished:nil :20];
}
*/
/*
-(void)test_06_deliveryTimesTest{
    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
    
    
    //[Shipment :1004];
    DeliveryTimeQueryMessage* service = [[DeliveryTimeQueryMessage alloc] init];
    service.carrier = @"ups";
    service.fromZip = @"28771";
    service.toZip = @"78704";
    service.weight = [NSNumber numberWithFloat:1.0f];
    [Shipment deliveryTime:service];
    
    [self hangUntilAsyncFinished:nil :20];
}
*/

/*

-(void)test_07_ratesTest{
    __block TestDelegate* sender = [[TestDelegate alloc] init];
    
    RateQueryMessage* message = [[RateQueryMessage alloc] init];
    message.carrier = @"fedex";
    message.fromZip = @"28771";
    message.toZip = @"78704";
    message.weight = [NSNumber numberWithFloat:1.0f];
    
    [Shipment rates:message];
    
    [self hangUntilAsyncFinished:nil :20];
}
 */

/*
-(void)test_08_fetchShipment{
    
    [Shipment fetchShipmentsWithCursor:nil andLimit:0];
    
    [self hangUntilAsyncFinished:nil :20];
}

 */
@end
