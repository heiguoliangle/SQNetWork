//
//  SQNNetWokrManager.m
//  AFNetworking
//
//  Created by heiguoliangle on 2019/4/2.
//

#import "SQNNetWokrManager.h"
#import <AFNetworking/AFNetworking.h>
#import "SQNMacro.h"
#import "SQNNetWorkResponse.h"
#import <objc/runtime.h>

static NSString *sqkbIndentiKey = @"sqkbIndentiKey";
@interface NSURLSessionDataTask (SQKB)
@property(nonatomic,copy)NSString * sqkbIndenti;
@end

@implementation NSURLSessionDataTask

- (void)setSqkbIndenti:(NSString *)sqkbIndenti{
    objc_setAssociatedObject(self, &sqkbIndentiKey, sqkbIndenti, OBJC_ASSOCIATION_COPY);
}
- (NSString *)sqkbIndenti {
    return objc_getAssociatedObject(self, &sqkbIndentiKey);
}

@end


@interface SQNNetWokrManager ()

@property (nonatomic, strong) NSMutableArray * dispatchTaskArray;
@end


@implementation SQNNetWokrManager
- (AFHTTPSessionManager *)sessionManagerWithRequest:(id)request
{
    AFHTTPSessionManager *sessionManager = nil;
    if (sessionManager == nil) {
        sessionManager = [AFHTTPSessionManager manager];
    }
    return sessionManager;
}

- (void)callServiceWithRequest:(SQNNetWorkBaseRequest *)request success:(SQNCallback)success fail:(SQNCallback)fail
{
    __block NSURLSessionDataTask *dataTask = nil;
    AFHTTPSessionManager * sessionManager = [self sessionManagerWithRequest:request];
    AFHTTPRequestSerializer * requestSerializer = [AFHTTPRequestSerializer serializer];
    [self _configRequestSerializerWithRequest:request serializer:requestSerializer];
    
    sessionManager.requestSerializer = requestSerializer;
    
    dataTask = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        [self.dispatchTaskArray removeObject:dataTask];
        NSDictionary * result = [request resultWithResponseObject:responseObject response:response error:&error];
        
        SQNNetWorkResponse * netWorkResponse = [[SQNNetWorkResponse alloc]initWithResponseString:@"" request:request responseObject:result error:error];
        if (error) {
            fail ? fail(netWorkResponse) : nil;
        }else{
            success ? success(netWorkResponse) : nil;
        }
    }];
    
    if (!IsEmpty(request.sqkbIndenti)) {
        dataTask.sqkbIndenti = request.sqkbIndenti;
    }
    [self _addTaskToTaskPool:dataTask];
    [dataTask resume];
    
    
}

#pragma mark - 取消

- (void)cancelRequestWithTag:(NSString *)sqkbIndenti
{
    for (NSURLSessionDataTask * dataTask in self.dispatchTaskArray) {
        if ([dataTask.sqkbIndenti isEqualToString:sqkbIndenti]) {
            [dataTask cancel];
            [self.dispatchTaskArray removeObject:dataTask];
            break;
        }
    }
}

- (void)cancelAllRequests
{
    for (NSURLSessionDataTask * dataTask in self.dispatchTaskArray) {
        [dataTask cancel];
    }
    [self.dispatchTaskArray removeAllObjects];
}

#pragma mark - 私有方法

- (void)_configRequestSerializerWithRequest:(SQNNetWorkBaseRequest *)request serializer:(AFHTTPRequestSerializer *)requestSerializer{
    if ([request respondsToSelector:@selector(sessionManagerRequestSerializer)]) {
        AFHTTPRequestSerializer * serializer = [request sessionManagerRequestSerializer];
        if (serializer) {
            requestSerializer = serializer;
        }
    }
}

- (void)_addTaskToTaskPool:(NSURLSessionDataTask *)task {
    if (!task) {
        return;
    }
    [self.dispatchTaskArray addObject:task];
}

- (BOOL)isReachable
{
    return  YES;
}

#pragma mark - 默认配置

- (void)defaultConfigForRequest:(NSURLRequest *)request {
    
    
}


#pragma mark - 懒加载

- (NSMutableArray *)dispatchTaskArray{
    if (_dispatchTaskArray == nil) {
        _dispatchTaskArray = [[NSMutableArray alloc] init];
    }
    return _dispatchTaskArray;
}

@end

