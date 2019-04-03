//
//  SQCompressHelp.m
//  SQNetWork_Example
//
//  Created by heiguoliangle on 2019/4/3.
//  Copyright © 2019 heiguoliangle@163.com. All rights reserved.
//

#import "SQCompressHelp.h"
#import "SQCompressRequest.h"
#import <SQNetWork.h>

@interface SQCompressHelp ()<SQNNetWorkResponseInterceptor>

@end

@implementation SQCompressHelp

- (void)upload {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filepath = [NSString pathWithComponents:@[[bundle resourcePath], @"example.json"]];
    NSData *original = [NSData dataWithContentsOfFile:filepath];
    SQCompressRequest * request = [SQCompressRequest new];
    request.interceptorDelegate = self;
    request.requestType = SQNManagerRequestTypePost;
    request.compressType = SQNManagerRequestCompressTypeSnappy;
    request.allHTTPHeaderFields = @{
                                    @"Content-Encoding" : @"snappy"
                                    };
    request.parameters = original;
    request.requestPath = @"/log/crashLog";
    
    SQNNetWokrManager * manager = [[SQNNetWokrManager alloc]init];
    manager.baseURL = @"http://dev.17gwx.com/";
    [manager callServiceWithRequest:request success:^(SQNNetWorkResponse * _Nonnull response) {
        
    } fail:^(SQNNetWorkResponse * _Nonnull response) {
        
    }];
}

@end
