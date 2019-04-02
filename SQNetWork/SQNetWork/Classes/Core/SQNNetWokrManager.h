//
//  SQNNetWokrManager.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import <Foundation/Foundation.h>
#import "SQNNetWorkResponse.h"
#import "SQNNetWorkRequestProtocol.h"
#import "SQNNetWorkBaseRequest.h"
#import "SQNNetWorkResponse.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^SQNCallback)(SQNNetWorkResponse * response);


@interface SQNNetWokrManager : NSObject

- (void)callServiceWithRequest:(SQNNetWorkBaseRequest *)request success:(SQNCallback)success fail:(SQNCallback)fail;

- (void)cancelAllRequests;

- (void)cancelRequestWithTag:(NSString *)sqkbIndenti;



@end



NS_ASSUME_NONNULL_END
