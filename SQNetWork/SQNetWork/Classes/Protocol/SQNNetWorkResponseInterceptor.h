//
//  SQNNetWorkResponseInnerInterceptor.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SQNNetWorkResponse;
@protocol SQNNetWorkResponseInterceptor <NSObject>
- (BOOL)beforePerformSuccessWithResponse:(SQNNetWorkResponse *_Nullable)response;
- (void)afterPerformSuccessWithResponse:(SQNNetWorkResponse *_Nullable)response;
- (BOOL)beforePerformFailWithResponse:(SQNNetWorkResponse *_Nullable)response;
- (void)afterPerformFailWithResponse:(SQNNetWorkResponse *_Nullable)response;
- (BOOL)shouldCallAPIWithParams:(NSDictionary *_Nullable)params;
- (void)afterCallingAPIWithParams:(NSDictionary *_Nullable)params;

@end

NS_ASSUME_NONNULL_END
