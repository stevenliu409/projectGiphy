//
//  PGNetworkManager.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PGURLDataCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);

@interface PGNetworkManager : NSObject

+ (instancetype)sharedManager;
- (void)getTrendingWithCompletion:(PGURLDataCompletionBlock)completion;
- (void)getSearchDataForSearch:(NSString *)searchString completion:(PGURLDataCompletionBlock)completion;
- (void)downloadImageAtURL:(NSURL *)url;

@end
