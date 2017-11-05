//
//  PGGif.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGGif.h"

@implementation PGGif

- (instancetype)initWithIdentifier:(NSString *)identifier images:(NSDictionary <NSString *, PGImage *> *)images
{
    self = [super init];
    if (self != nil)
    {
        _identifier = [identifier copy];
        _images = images;
        _favourite = NO;
    }

    return self;
}

@end
