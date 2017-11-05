//
//  PGNewtorkRequest.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGNewtorkRequestManager.h"
#import "PGConstants.h"

@implementation PGNewtorkRequestManager

- (NSURLRequest *)trendingRequest
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.giphy.com/v1/gifs/trending?api_key=%@", API_KEY]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"image/*" forHTTPHeaderField:@"Accept"];

    return request;
}

- (NSURLRequest *)searchRequestWithSearchString:(NSString *)searchString
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.giphy.com/v1/gifs/search?q=%@&api_key=%@", searchString, API_KEY]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"image/*" forHTTPHeaderField:@"Accept"];

    return request;
}

- (NSURLRequest *)downloadRequestWithURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"image/*" forHTTPHeaderField:@"Accept"];

    return request;
}

@end
