//
//  PGNetworkManager.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGNetworkManager.h"
#import "PGNewtorkRequestManager.h"

@interface PGNetworkManager () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) PGNewtorkRequestManager *networkRequestManager;
@end

@implementation PGNetworkManager

+ (instancetype)sharedManager
{
    static id _sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });

    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:nil];
        _networkRequestManager = [[PGNewtorkRequestManager alloc] init];
    }

    return self;
}

- (void)getTrendingWithCompletion:(PGURLDataCompletionBlock)completion
{
    NSURLRequest *request = [self.networkRequestManager trendingRequest];

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         completion(data, response, error);
                                                     }];
    [dataTask resume];
}

- (void)getSearchDataForSearch:(NSString *)searchString completion:(PGURLDataCompletionBlock)completion;
{
    NSURLRequest *request = [self.networkRequestManager searchRequestWithSearchString:searchString];

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         completion(data, response, error);
                                                     }];
    [dataTask resume];
}

- (void)downloadImageAtURL:(NSString *)url
{
    NSURLRequest *request = [self.networkRequestManager downloadRequestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];

    [downloadTask resume];
}

///-------------------------------------------------
/// NSURLSession Delegates
///-------------------------------------------------
#pragma mark - NSURLSession Delegates

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{

}

@end
