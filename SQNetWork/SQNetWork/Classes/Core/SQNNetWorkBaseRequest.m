//
//  SQNNetWorkBaseRequest.m
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import "SQNNetWorkBaseRequest.h"

@interface SQNNetWorkBaseRequest ()
@property(nonatomic,strong,readwrite) AFHTTPRequestSerializer * requestSerializer;
@end

@implementation SQNNetWorkBaseRequest

#pragma mark - SQNNetWorkRequestProtocol

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.compressType = SQNManagerRequestCompressTypeNone;
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}

- (AFHTTPRequestSerializer *)sessionManagerRequestSerializer{
    AFHTTPRequestSerializer * serializer = [AFHTTPRequestSerializer serializer];
    
    if (self.compressType != SQNManagerRequestCompressTypeNone) {
        [serializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    }
    return serializer;
}

#pragma mark - SQNNetWorkResponseProtocol

- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response error:(NSError * _Nullable __autoreleasing *)error{
    NSData *jsonData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return result;
}

@end
