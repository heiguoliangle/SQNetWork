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

@interface SQNNetWorkBaseRequest : NSObject<SQNNetWorkRequestProtocol>

@property(nonatomic,weak)id<SQNNetWorkResponseInterceptor> interceptorDelegate;
/// 压缩格式,默认不压缩.
@property(nonatomic,assign)SQNManagerRequestCompressType compressType;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property(nonatomic,strong,readonly) AFHTTPRequestSerializer * requestSerializer;

@property(nonatomic,assign) SQNManagerRequestType requestType;

@property(nonatomic,strong) id parameters;

@property(nonatomic,copy) NSString * requestPath;

@property(nonatomic,strong) NSDictionary<NSString *,NSString *> * allHTTPHeaderFields;


@property(nonatomic,copy)NSString * sqkbIndenti;

@end

NS_ASSUME_NONNULL_END
