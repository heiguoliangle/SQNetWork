//
//  SQNNetWorkRequestProtocol.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SQNNetWorkingDefines.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SQNNetWorkRequestProtocol <NSObject>


- (NSDictionary *)resultWithResponseObject:(id)responseObject response:(NSURLResponse *)response error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
