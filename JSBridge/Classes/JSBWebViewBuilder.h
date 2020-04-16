//
//  JSBWebViewController.h
//  JSBridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#import "JSBWebKitUtils.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * A builder for WebView (WKWebView)
 *
 * @author sirius
*/
@interface JSBWebViewBuilder : NSObject

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
@property (strong, nonatomic) WKWebView * _Nullable webView;
#pragma clang diagnostic pop

@property (assign, nonatomic) BOOL debugable;

/**
 * @abstract       Set the JavaScript invoking with object and function.
 *
 * @discussion  JavaScript statements like these:
 *
 *              @c objectName.functionName(arg1, arg2, argn)
 *
 *              @c window.objectName.functionName(arg1, arg2, argn)
 *
 *              The types of the Javascript args can be primitive types and object type.
 *
 *              The RULES for arguments to native array objects are:
 *
 *                  number -> NSNumber
 *
 *                  tring -> NSString
 *
 *                  object -> NSDictionary
 *
 *                  array -> NSArray
 *
 * @param objectName        The JavaScript object name
 * @param functionName    The JavaScript function name of the object
 * @param invoking             The native excuting block.
 *                      The array arguments is the Objects passed from Javascript call.
*/
- (void)setObjectName:(NSString *)objectName
         functionName:(NSString *)functionName
             invoking:(void (^)(NSArray<id> *))invoking;

/**
 * @abstract        Build the webview.
*/
- (void)build;

/**
 * @abstract        Evaluates the given JavaScript string.
 * @discussion      The completionHandler is passed the result of the script evaluation or an error.
 *
 *  Only integer, bool, number and string can be used as the argument within JavaScript function.
 *  If a NSString object is desired to be passed to JavaScript function as the argument,
 *      it must be escaped the characters ( \ and " ).
 *
 * @c NSString *escaped = JSBArgumentGetEscapedFromString(str);
 * @c NSString *script = [NSString stringWithFormat:@"js_func(%d, %@, \"%@\")", int, number, escaped];
 *
 * @param javaScriptString      The JavaScript string to evaluate.
 * @param completionHandler     A block to invoke when script evaluation completes or fails.
*/
- (void)evaluateJavaScript:(NSString *)javaScriptString
         completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable))completionHandler;
@end

NS_ASSUME_NONNULL_END
