//
//  SQReqeustCache.m
//  AFNetworking
//
//  Created by heiguoliangle on 2019/3/21.
//

#import "SQReqeustCache.h"
#import <WCDB/WCDB.h>

@implementation SQReqeustCache

WCDB_IMPLEMENTATION(SQReqeustCache)
WCDB_SYNTHESIZE(SQReqeustCache, indentify)
WCDB_SYNTHESIZE(SQReqeustCache, responseData)
WCDB_PRIMARY(SQReqeustCache, indentify)

@end
