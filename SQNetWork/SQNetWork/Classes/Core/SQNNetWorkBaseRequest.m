//
//  SQNNetWorkBaseRequest.m
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import "SQNNetWorkBaseRequest.h"

@implementation SQNNetWorkBaseRequest

#pragma mark - SQNNetWorkRequestProtocol

- (NSDictionary<NSString *,NSString *> *)allHTTPHeaderFields{
    return @{
             
             };
}

- (SQNManagerRequestType)requestType{
    return SQNManagerRequestTypeGet;
}

#pragma mark - SQNNetWorkResponseProtocol

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response error:(NSError * _Nullable __autoreleasing *)error{
    NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return result;
}

@end
