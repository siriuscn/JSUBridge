//
//  JSBActiveWKWebView.m
//  JSBridge
//
//  Created by sirius on 2020/1/2.
//  Copyright © 2020 sirius. All rights reserved.
//

#import "JSBActiveWKWebView.h"

@interface JSBActiveWKWebView ()
#if !TARGET_OS_IPHONE
@property (copy) NSArray<NSMenuItem *> *itemArray;
#endif
@end

@implementation JSBActiveWKWebView

#if !TARGET_OS_IPHONE
@dynamic menu;
#endif

- (BOOL)acceptsFirstResponder {
    return YES;
}

#pragma mark - Mouse event

#if !TARGET_OS_IPHONE
- (BOOL)acceptsFirstMouse:(NSEvent *)event {
    return YES;
}

#pragma mark - Menu event

- (void)willOpenMenu:(NSMenu *)menu withEvent:(NSEvent *)event {
    for (NSMenuItem *item in menu.itemArray) {
        if ([item.identifier isEqualToString:@"WKMenuItemIdentifierOpenImageInNewWindow"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierDownloadImage"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierCopyImage"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierLookUp"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierSearchWeb"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierReload"] ||
            [item.identifier isEqualToString:@"WKMenuItemIdentifierGoBack"]) {
            [menu removeItem:item];
        }
    }

    self.itemArray = self.menu.itemArray;
    [self.menu removeAllItems];

    [menu addItem:[NSMenuItem separatorItem]];

    for (NSMenuItem *item in self.itemArray) {
        [menu addItem:item];
    }

    [menu addItem:[NSMenuItem separatorItem]];

    menu.autoenablesItems = YES;
}

- (void)didCloseMenu:(NSMenu *)menu withEvent:(nullable NSEvent *)event {
    [menu removeAllItems];

    for (NSMenuItem *item in self.itemArray) {
        [self.menu addItem:item];
    }
}

#endif

@end
