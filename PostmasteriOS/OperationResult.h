//
//  OperationResult.h
//  PostmasteriOS
//
//  Created by luczakp on 24.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "PostmasterEntity.h"

@interface OperationResult : NSObject{
    NSString* _jsonErrorMessage;
    NSInteger _jsonErrorCode;
}

@property(nonatomic,retain) NSError* commonHTTPError;

-(void)wrapJSONErrorData:(NSDictionary*)json;
-(NSString*)jsonErrorMessage;
-(NSInteger) jsonErrorCode;
-(id)initWithJSON:(NSDictionary*)json;
-(id)initWithCommonHTTPError:(NSError*)error;

@end
