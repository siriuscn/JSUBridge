//
//  JSBWebKitUtils.m
//  JSBridge
//
//  Created by sirius on 2020/1/16.
//  Copyright © 2020 sirius. All rights reserved.
//

#import "JSBWebKitUtils.h"

NSString *JSBArgumentGetEscapedFromString(NSString *src) {
    NSString *escaped = [src stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    escaped = [escaped stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    return escaped;
}
