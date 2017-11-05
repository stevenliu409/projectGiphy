//
//  PGImageConverter.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PGImage;
@class PGImageEntity;

@interface PGImageConverter : NSObject

- (NSDictionary <NSString *, PGImage *> *)imagesFromJSON:(NSDictionary *)json withIdentifier:(NSString *)identifier;
- (PGImage *)imageFromJSON:(NSDictionary *)json;
- (PGImage *)imageFromImageEntity:(PGImageEntity *)imageEntity;
- (void)updateImageEntity:(PGImageEntity *)imageEntity withImage:(PGImage *)image;

@end
