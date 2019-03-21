//
//  SQReqeustCache+WCTTableCoding.h
//  SQNetWork
//
//  Created by heiguoliangle on 2019/3/21.
//

#import <SQNetWork/SQNetWork.h>
#import "SQReqeustCache.h"
#import <WCDB/WCDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface SQReqeustCache (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(indentify)
WCDB_PROPERTY(responseData)


@end

NS_ASSUME_NONNULL_END
