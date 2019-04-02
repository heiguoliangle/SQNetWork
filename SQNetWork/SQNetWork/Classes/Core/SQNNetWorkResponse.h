//
//  SQNNetWorkResponse.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SQNURLResponseStatus)
{
    /// 服务器有没有返回
    SQNURLResponseStatusSuccess,
    SQNURLResponseStatusErrorTimeout,
    SQNURLResponseStatusErrorCancel,
    /// 默认除了超时以外的错误都是无网络错误。
    SQNURLResponseStatusErrorNoNetwork
};

@class SQNNetWorkBaseRequest;

NS_ASSUME_NONNULL_BEGIN


/// 网络响应处理类
@interface SQNNetWorkResponse : NSObject
@property (nonatomic, assign, readonly) SQNURLResponseStatus status;
@property (nonatomic, strong, readonly) id jsonObject;
@property (nonatomic,copy, readonly)NSString * sqkbIndenti;

@property (nonatomic, strong, readonly) SQNNetWorkBaseRequest * request;


@property(nonatomic,copy,readonly) NSString * responseStr;
@property (nonatomic, copy, readonly) NSString * msg;

- (instancetype)initWithResponseString:(NSString *)responseString request:(SQNNetWorkBaseRequest *)request responseObject:(id)responseObject error:(NSError *)error;

@property (nonatomic, assign, readonly) BOOL isCache;
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
