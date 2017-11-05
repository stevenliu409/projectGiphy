//
//  PGGifConverter.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGGifConverter.h"
#import "PGGif.h"
#import "PGImageConverter.h"
#import "PGImage.h"
#import "PGGifEntity.h"

@interface PGGifConverter ()
@property (nonatomic, strong) PGImageConverter *imageConverter;
@end

@implementation PGGifConverter

- (PGImageConverter *)imageConverter
{
    if (_imageConverter == nil)
    {
        _imageConverter = [[PGImageConverter alloc] init];
    }
    return _imageConverter;
}

- (PGGif *)createGifFromJSON:(NSDictionary *)json
{
    NSString *identifier = json[@"id"];

    NSDictionary *images = [self.imageConverter imagesFromJSON:json[@"images"] withIdentifier:identifier];

    PGGif *gif = [[PGGif alloc] initWithIdentifier:identifier images:images];

    return gif;
}

- (PGGif *)gifFromGifEntity:(PGGifEntity *)gifEntity
{
    PGGif *gif = [[PGGif alloc] initWithIdentifier:gifEntity.identifier images:nil];
    gif.favourite = gifEntity.favourite;

    return gif;
}

- (void)updateGifEntity:(PGGifEntity *)gifEntity withGif:(PGGif *)gif
{
    gifEntity.identifier = gif.identifier;
    gifEntity.favourite = gif.favourite;
}

@end
