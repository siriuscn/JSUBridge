//
//  JSUActiveWKWebView.h
//  JSUridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "JSUWebLoadingProtocol.h"

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.10), ios(8.0))
@interface JSUActiveWKWebView : WKWebView <JSUWebLoadingProtocol>

#if !TARGET_OS_IPHONE
@property (nullable, strong) NSMenu *menu;
#endif

@end

NS_ASSUME_NONNULL_END
