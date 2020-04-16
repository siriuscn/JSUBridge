//
//  JSUWebKitUtils.m
//  JSUridge
//
//  Created by sirius on 2020/1/16.
//  Copyright © 2020 sirius. All rights reserved.
//

#import "JSUWebKitUtils.h"

NSString *JSUArgumentGetEscapedFromString(NSString *src) {
    NSString *escaped = [src stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    escaped = [escaped stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    return escaped;
}
