//
//  JSUJavaScriptHandler.m
//  JSUridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import "JSUJavaScriptHandler.h"

API_AVAILABLE(macos(10.10), ios(8.0))
@interface JSUJavaScriptHandler () <WKScriptMessageHandler>
@property (nonatomic, strong) NSMutableDictionary<NSString *, void (^)(NSArray<id> *)> *invokings;
@property (nonatomic, weak) WKUserContentController *userContentController;
@end

@implementation JSUJavaScriptHandler

- (instancetype)initWithUserContentController:(WKUserContentController *)userContentController  API_AVAILABLE(macos(10.10), ios(8.0)) {
    self = [super init];
    if (self) {
        self.userContentController = userContentController;
        self.invokings = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {

}

- (void)addWithObjectName:(NSString *)objectName
             functionName:(NSString *)functionName
                 invoking:(void (^)(NSArray<id> *))invoking {
    NSString *name = [self mixedNameWithObjectName:objectName
                                      functionName:functionName];
    [self.invokings setObject:invoking forKey:name];

    [self.userContentController addScriptMessageHandler:self
                                                   name:name];

    NSString *source = [self injectedSourceWithObjectName:objectName functionName:functionName];

    if (@available(macOS 10.10, iOS 8.0, *)) {
        WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];

        [self.userContentController addUserScript:script];
    }
}

- (void)removeWithObjectName:(NSString *)objectName
                functionName:(NSString *)functionName {
    NSString *name = [self mixedNameWithObjectName:objectName
    functionName:functionName];

    [self.invokings removeObjectForKey:name];

    [self.userContentController removeScriptMessageHandlerForName:name];

    NSString *source = [self removingSourceWithObjectName:objectName functionName:functionName];

    if (@available(macOS 10.10, iOS 8.0, *)) {
        WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];

        [self.userContentController addUserScript:script];
    }
}

- (void)removeAllObjects {
    NSArray<NSString *> *allNames = [self.invokings allKeys];
    for (NSString *name in allNames) {
        [self.userContentController removeScriptMessageHandlerForName:name];
    }
    [self.invokings removeAllObjects];
}

- (NSString *)injectedSourceWithObjectName:(NSString *)objectName
                              functionName:(NSString *)functionName {
    NSString *format = @"if (window.%@ === undefined) {window.%@ = {}}window.%@.%@=function(){window.webkit.messageHandlers.%@.postMessage(Array.prototype.slice.call(arguments))}";
    return [NSString stringWithFormat:format, objectName,
         objectName, objectName, functionName,
            [self mixedNameWithObjectName:objectName functionName:functionName]];
}

- (NSString *)removingSourceWithObjectName:(NSString *)objectName
                              functionName:(NSString *)functionName {
    NSString *format = @"delete %@.%@; var empty = (JSON.stringify(%@) == \"{}\"); if (empty) { delete %@;}";
    return [NSString stringWithFormat:format, objectName, functionName,
         objectName, objectName];
}

- (NSString *)removingSourceWithObjectName:(NSString *)objectName {
    NSString *format = @"delete %@;";
    return [NSString stringWithFormat:format, objectName];
}

- (NSString *)mixedNameWithObjectName:(NSString *)objectName
                         functionName:(NSString *)functionName {
    return [NSString stringWithFormat:@"_$_%@_$_%@", objectName, functionName];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message API_AVAILABLE(macos(10.10), ios(8.0)) {
    void (^invoking)(id _Nullable)  = [self.invokings objectForKey:message.name];
    if (invoking != nil) {
        invoking(message.body);
    }
}
@end
