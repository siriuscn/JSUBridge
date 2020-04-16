# JSBridge

[![CI Status](https://img.shields.io/travis/siriuscn/JSUBridge.svg?style=flat)](https://travis-ci.org/siriuscn/JSUBridge)
[![Version](https://img.shields.io/cocoapods/v/JSUBridge.svg?style=flat)](https://cocoapods.org/pods/JSUBridge)
[![License](https://img.shields.io/cocoapods/l/JSUBridge.svg?style=flat)](https://cocoapods.org/pods/JSUBridge)
[![Platform](https://img.shields.io/cocoapods/p/JSUBridge.svg?style=flat)](https://cocoapods.org/pods/JSUBridge)

JSUBridge is an universal framework for `iOS` and `macOS`. It helps JavaScript programmer to develop apps without checking whether the running OS is `iOS` / `macOS` nor `Android` anymore! It is intended to be simple, lightweight, and easy to use.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Call to native methods. The count of arguments is NOT limited!
```javascript
window.obj.fun(arg1, arg2) 
obj.fun(arg1, arg2)
```

Call back to JavaScript from native methods. The count of arguments is NOT limited!
```javascript
window.callback = func(arg1, arg2) {
    ...
}
```

Native Objective-C codes can be implemented as below:
```objc
self.webViewBuilder = [[JSBWebViewBuilder alloc] init];
self.webViewBuilder.debugable = YES;

__weak typeof(self) weakSelf = self;
[self.webViewBuilder setObjectName:@"obj" functionName:@"fun" invoking:^(NSArray<id> *args) {
    NSString *message = @"string";
    NSString *escaped = JSBArgumentGetEscapedFromString(message);
    NSString *script = [NSString stringWithFormat:@"jsfunc(%d, \"%@\")", 33, escaped];
    [weakSelf.webViewBuilder evaluateJavaScript:script completionHandler:^(id _Nullable res, NSError * _Nullable error) {
    }];
}];

[self.webViewBuilder build];
self.webViewBuilder.webView.frame = self.view.bounds;
self.webViewBuilder.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
[self.view addSubview:self.webViewBuilder.webView];
```

## Requirements

## Installation

JSBridge is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JSUBridge', '~> 1.0.0'
```

## Requirements

| JSBridge Version | Minimum iOS Target  | Minimum macOS Target   |                                   Notes                                   |
|:--------------------:|:---------------------------:|:----------------------------:|:----------------------------:|:----------------------------:|:-------------------------------------------------------------------------:|
| 1.x | iOS 8 | macOS 10.10  | Xcode 11+ is required. |

(macOS projects must support [64-bit with modern Cocoa runtime](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtVersionsPlatforms.html)).

## Author

sirius ( siruscn ) , 331862034@qq.com

## License

JSBridge is available under the MIT license. See the LICENSE file for more info.

    Copyright (c) 2020 sirius <331862034@qq.com>

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
