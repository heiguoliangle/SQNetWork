//
//  SQNNetWorkResponse.m
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import "SQNNetWorkResponse.h"
#import "SQNNetWorkBaseRequest.h"

@interface SQNNetWorkResponse ()
@property (nonatomic, assign, readwrite) SQNURLResponseStatus status;
@property (nonatomic,copy,readwrite) NSString * responseStr;
@property (nonatomic, strong, readwrite) id jsonObject;
@property (nonatomic, strong, readwrite) SQNNetWorkBaseRequest * request;
@property (nonatomic, assign, readwrite) BOOL isCache;
@property (nonatomic, copy, readwrite) NSString * msg;
@property (nonatomic,copy, readwrite)NSString * sqkbIndenti;


@end

@implementation SQNNetWorkResponse

- (instancetype)initWithResponseString:(NSString *)responseString request:(SQNNetWorkBaseRequest *)request responseObject:(id)responseObject error:(NSError *)error{
    self = [super init];
    if (self) {
        self.responseStr = responseString;
        self.request = request;
        self.sqkbIndenti = request.sqkbIndenti;
        self.isCache = NO;
        self.status = [self responseStatusWithError:error];
        self.jsonObject = responseObject ? responseObject : @{};
        self.msg = [NSString stringWithFormat:@"%@", error];
    }
    return self;
}

#pragma mark - private methods
- (SQNURLResponseStatus)responseStatusWithError:(NSError *)error
{
    if (error) {
        SQNURLResponseStatus result = SQNURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = SQNURLResponseStatusErrorTimeout;
        }
        if (error.code == NSURLErrorCancelled) {
            result = SQNURLResponseStatusErrorCancel;
        }
        if (error.code == NSURLErrorNotConnectedToInternet) {
            result = SQNURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return SQNURLResponseStatusSuccess;
    }
}

@end
