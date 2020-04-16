//
//  JSBWebViewController.m
//  JSBridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import "JSBWebViewBuilder.h"
#import "JSBJavaScriptHandler.h"
#import "JSBActiveWKWebView.h"

API_AVAILABLE(macos(10.10), ios(8.0))
@interface JSBWebViewBuilder ()
@property (strong, nonatomic) JSBJavaScriptHandler *handler;
@property (strong, nonatomic) WKWebViewConfiguration *configuration;
@end

@implementation JSBWebViewBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
        self.debugable = NO;
    }
    return self;
}

- (void)dealloc {
    [self.handler removeAllObjects];
    self.handler = nil;
    self.webView = nil;
}

- (BOOL)debugable {
    return [self.configuration.preferences valueForKey:@"developerExtrasEnabled"] != nil;
}

- (void)setDebugable:(BOOL)debugable {
    if (debugable) {
        [self.configuration.preferences setValue:@(YES) forKey:@"developerExtrasEnabled"];
    } else {
        [self.configuration.preferences setValue:@(NO) forKey:@"developerExtrasEnabled"];
    }
}

- (void)setup {
    if (@available(macOS 10.10, iOS 8.0, *)) {
        self.configuration = [[WKWebViewConfiguration alloc] init];

        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        self.configuration.userContentController = userContentController;
        
        self.handler = [[JSBJavaScriptHandler alloc] initWithUserContentController:userContentController];
    }
}

- (void)setObjectName:(NSString *)objectName
         functionName:(NSString *)functionName
             invoking:(void (^)(NSArray<id> *))invoking {
    [self.handler addWithObjectName:objectName functionName:functionName invoking:invoking];
}

- (void)build {
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"WebContinuousSpellCheckingEnabled"];
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"WebAutomaticSpellingCorrectionEnabled"];
    
#if !TARGET_OS_IPHONE
    if (@available(macOS 10.10, *)) {
        self.webView = [[JSBActiveWKWebView alloc] initWithFrame:NSZeroRect configuration:self.configuration];
        self.webView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    }
#else
    if (@available(iOS 8.0, *)) {
        self.webView = [[JSBActiveWKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
#endif
}

- (void)evaluateJavaScript:(NSString *)javaScriptString
         completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler {
    [self.webView evaluateJavaScript:javaScriptString
                   completionHandler:completionHandler];
}
@end
