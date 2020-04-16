//
//  JSUJavaScriptHandler.h
//  JSUridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSUJavaScriptHandler : NSObject

- (instancetype)initWithUserContentController:(WKUserContentController *)userContentController API_AVAILABLE(macos(10.10), ios(8.0));

- (void)addWithObjectName:(NSString *)objectName
             functionName:(NSString *)functionName
                 invoking:(void (^)(NSArray<id> *))invoking;

- (void)removeWithObjectName:(NSString *)objectName
                functionName:(NSString *)functionName;

- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
