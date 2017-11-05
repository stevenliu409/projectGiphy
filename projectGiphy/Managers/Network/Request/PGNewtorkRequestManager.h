//
//  PGNewtorkRequestManager.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGNewtorkRequestManager : NSObject

- (NSURLRequest *)trendingRequest;
- (NSURLRequest *)searchRequestWithSearchString:(NSString *)searchString;
- (NSURLRequest *)downloadRequestWithURL:(NSString *)urlString;

@end
