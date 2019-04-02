//
//  SQNNetWorkBaseRequest.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import <Foundation/Foundation.h>
#import "SQNNetWorkRequestProtocol.h"
#import "SQNNetWorkResponseInterceptor.h"


NS_ASSUME_NONNULL_BEGIN

@interface SQNNetWorkBaseRequest : NSURLRequest<SQNNetWorkRequestProtocol>

@property(nonatomic,weak)id<SQNNetWorkResponseInterceptor> interceptorDelegate;

@property(nonatomic,copy)NSString * sqkbIndenti;

@end

NS_ASSUME_NONNULL_END
