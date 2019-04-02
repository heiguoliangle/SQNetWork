//
//  SQReqeustCache.h
//  AFNetworking
//
//  Created by heiguoliangle on 2019/3/21.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
/// 网络数据返回类
@interface SQReqeustCache : NSObject
/// 请求接口hash值
@property(nonatomic,assign)NSInteger indentify;
/// 响应数据
@property(nonatomic,strong) NSData * responseData;
@end

NS_ASSUME_NONNULL_END
