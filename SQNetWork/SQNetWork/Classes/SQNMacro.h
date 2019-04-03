//
//  SQNMacro.h
//  SQNetWork
//
//  Created by heiguoliangle on 2019/4/2.
//

#ifndef SQNMacro_h
#define SQNMacro_h

/// int 转字符串
#define StringFromInt(int)      [NSString stringWithFormat:@"%ld",int]

/// 空值判断相关
#define IsEmpty(str)            (str == nil || ![str respondsToSelector:@selector(isEqualToString:)] || [str isEqualToString:@""])
#define IsNull(obj)             (obj == nil || [obj isEqual:[NSNull null]])
#define IsArray(obj)            (obj && [obj isKindOfClass:[NSArray class]] && [obj count])
#define IsDictionary(obj)       (obj && [obj isKindOfClass:[NSDictionary class]] && [obj count])

#endif /* SQNMacro_h */
