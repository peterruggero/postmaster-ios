//
//  OperationResult.m
//  PostmasteriOS
//
//  Created by luczakp on 24.06.2013.
//  Copyright (c) 2013 STXNext. All rights reserved.
//

#import "OperationResult.h"

@implementation OperationResult

-(NSString*)jsonErrorMessage{
    return _jsonErrorMessage;
}
-(NSInteger) jsonErrorCode{
    return _jsonErrorCode;
}

-(void)wrapJSONErrorData:(NSDictionary*)json{
    _jsonErrorMessage = [json objectForKey:@"message"];
    _jsonErrorCode = [[json valueForKey:@"code"] integerValue];
}

-(id)initWithCommonHTTPError:(NSError*)error{
    self = [super init];
    
    self.commonHTTPError = error;
    
    return self;
}

@end
