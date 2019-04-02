//
//  SQNNetWorkingDefines.h
//  Pods
//
//  Created by heiguoliangle on 2019/4/2.
//

#ifndef SQNNetWorkingDefines_h
#define SQNNetWorkingDefines_h

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, SQNManagerRequestType){
    SQNManagerRequestTypePost,
    SQNManagerRequestTypeGet,
};


typedef NS_ENUM (NSUInteger, SQNManagerErrorType){
    /// 需要重新刷新accessToken
    SQNManagerErrorTypeNeedAccessToken,
    /// 需要登陆
    SQNManagerErrorTypeNeedLogin,
    /// 没有产生过API请求，这个是manager的默认状态。
    SQNManagerErrorTypeDefault,
    /// 调用API需要登陆态，弹出登陆页面之后用户取消登陆了
    SQNManagerErrorTypeLoginCanceled,
    /// API请求成功且返回数据正确
    SQNManagerErrorTypeSuccess,
    /// API请求成功但返回数据不正确
    SQNManagerErrorTypeNoContent,
    /// 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的
    SQNManagerErrorTypeParamsError,
    /// 请求超时
    SQNManagerErrorTypeTimeout,
    /// 网络不通
    SQNManagerErrorTypeNoNetWork,
    /// 取消请求
    SQNManagerErrorTypeCanceled,
    /// 无错误
    SQNManagerErrorTypeNoError,
};

typedef NS_OPTIONS(NSUInteger, SQNManagerCachePolicy) {
    SQNManagerCachePolicyNoCache = 0,
    SQNManagerCachePolicyMemory = 1 << 0,
    SQNManagerCachePolicyDisk = 1 << 1,
};


#endif /* SQNNetWorkingDefines_h */
