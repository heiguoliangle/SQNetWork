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
#import "Snappy-ObjC.h"

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
    
    if (![request.interceptorDelegate respondsToSelector:@selector(shouldCallAPIWithParams:)]) {
       BOOL beforeCallInterceptor = [request.interceptorDelegate shouldCallAPIWithParams:request.parameters];
        if (!beforeCallInterceptor) {
            NSError * error = [[NSError alloc]initWithDomain:@"请求未开启" code:-1 userInfo:@{
                                                                                                                                            
                                                                                                                                            NSLocalizedFailureReasonErrorKey : @"请求参数判断异常"                                                                                 }];
            SQNNetWorkResponse * responseFailed = [[SQNNetWorkResponse alloc]initWithResponseString:@"" request:request responseObject:nil error:error];
            
            fail(responseFailed);
            return;
        }
    }
    
    NSURLRequest * requestURL = [self _buildRequestWithBaseRequest:request];
    
    sessionManager.requestSerializer = request.requestSerializer;
    dataTask = [sessionManager dataTaskWithRequest:requestURL uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
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
    
    if (![request.interceptorDelegate respondsToSelector:@selector(afterCallingAPIWithParams::)]) {
        [request.interceptorDelegate afterCallingAPIWithParams:request.parameters];
    }
    
    
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

- (NSURLRequest *)_buildRequestWithBaseRequest:(SQNNetWorkBaseRequest *)request {
    NSString * requestMethod = @"get";
    if (request.requestType == SQNManagerRequestTypeGet) {
        requestMethod = @"get";
    }else if (request.requestType == SQNManagerRequestTypePost){
        requestMethod = @"post";
    }
    NSDictionary<NSString *,NSString *> * dict = [request allHTTPHeaderFields];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [request.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:request.parameters forKey:@"data"];
    if (request.compressType == SQNManagerRequestCompressTypeSnappy) {
       NSData * requestData = [request.parameters data];
       NSData *compressed = [requestData snappy_compressedData];
        if (compressed.length >= 0 && compressed) {
            NSString * compressStr = [compressed base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [parameters setObject:compressStr forKey:@"data"];
        }
    }
    
    NSString * url = [[NSString alloc]initWithFormat:@"%@%@",self.baseURL,request.requestPath ];
    
    return [request.requestSerializer requestWithMethod:requestMethod URLString:self.baseURL parameters:parameters error:nil];
    
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

#pragma mark - 懒加载

- (NSMutableArray *)dispatchTaskArray{
    if (_dispatchTaskArray == nil) {
        _dispatchTaskArray = [[NSMutableArray alloc] init];
    }
    return _dispatchTaskArray;
}

@end

