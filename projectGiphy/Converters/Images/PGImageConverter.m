//
//  PGImageConverter.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGImageConverter.h"
#import "PGImage.h"
#import "PGImageEntity.h"

@implementation PGImageConverter

- (NSDictionary <NSString *, PGImage *> *)imagesFromJSON:(NSDictionary *)json withIdentifier:(NSString *)identifier
{
    NSMutableDictionary *images = [[NSMutableDictionary alloc] init];

    NSDictionary *imageSmallDict = json[@"preview_gif"];
    NSDictionary *imageMediumDict = json[@"fixed_width"];
    NSDictionary *imageLargeDict = json[@"downsized"];

    PGImage *imageSmall = [self imageFromJSON:imageSmallDict];
    imageSmall.identifier = identifier;
    imageSmall.sizeType = PGImageSizeTypeSmall;

    PGImage *imageMedium = [self imageFromJSON:imageMediumDict];
    imageMedium.identifier = identifier;
    imageMedium.sizeType = PGImageSizeTypeMedium;

    PGImage *imageLarge = [self imageFromJSON:imageLargeDict];
    imageLarge.identifier = identifier;
    imageLarge.sizeType = PGImageSizeTypeLarge;
    
    [images setObject:imageSmall forKey:@"small"];
    [images setObject:imageMedium forKey:@"medium"];
    [images setObject:imageLarge forKey:@"large"];

    return images;
}

- (PGImage *)imageFromJSON:(NSDictionary *)json
{
    PGImage *image = [[PGImage alloc] init];
    image.url = json[@"url"];
    image.width = [json[@"width"] floatValue];
    image.height = [json[@"height"] floatValue];

    return image;
}

- (PGImage *)imageFromImageEntity:(PGImageEntity *)imageEntity
{
    PGImage *image = [[PGImage alloc] init];
    image.identifier = imageEntity.identifier;
    image.url = imageEntity.url;
    image.width = imageEntity.width;
    image.height = imageEntity.height;

    return image;
}

- (void)updateImageEntity:(PGImageEntity *)imageEntity withImage:(PGImage *)image
{
    imageEntity.identifier = image.identifier;
    imageEntity.url = image.url;
    imageEntity.width = image.width;
    imageEntity.height = image.height;
}

@end
