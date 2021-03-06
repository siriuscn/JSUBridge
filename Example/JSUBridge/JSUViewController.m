//
//  JSUViewController.m
//  JSUBridge
//
//  Created by siriuscn on 04/16/2020.
//  Copyright (c) 2020 siriuscn. All rights reserved.
//

#import "JSUViewController.h"
#import <JSUBridge/JSUBridge.h>

@interface JSUViewController ()
@property (strong, nonatomic) JSUWebViewBuilder *webViewBuilder;
@end

@implementation JSUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self configWebView];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" inDirectory:@"dist"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webViewBuilder.webView loadRequest:request];
}

- (void)configWebView {
    self.webViewBuilder = [[JSUWebViewBuilder alloc] init];
    self.webViewBuilder.debugable = YES;

    __weak typeof(self) weakSelf = self;
    [self.webViewBuilder setObjectName:@"obj" functionName:@"fun" invoking:^(NSArray<id> *args) {
        NSString *message = @"string";
        NSString *escaped = JSUArgumentGetEscapedFromString(message);
        NSString *script = [NSString stringWithFormat:@"jsfunc(%d, \"%@\")", 33, escaped];
        [weakSelf.webViewBuilder evaluateJavaScript:script completionHandler:^(id _Nullable res, NSError * _Nullable error) {
        }];
    }];

    [self.webViewBuilder build];
    self.webViewBuilder.webView.frame = self.view.bounds;
    self.webViewBuilder.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.webViewBuilder.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
