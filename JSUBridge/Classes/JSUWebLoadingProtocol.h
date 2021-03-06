//
//  JSUWebLoadingProtocol.h
//  JSUridge
//
//  Created by sirius on 2020/1/7.
//  Copyright © 2020 sirius. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSUWebLoadingProtocol <NSObject>
- (nullable id)loadRequest:(NSURLRequest *)request;
@end

NS_ASSUME_NONNULL_END
