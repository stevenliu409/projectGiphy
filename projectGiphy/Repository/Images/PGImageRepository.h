//
//  PGImageRepository.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGConstants.h"

@class PGImage;
@interface PGImageRepository : NSObject

+ (instancetype)sharedRepository;
- (NSDictionary<NSString *, PGImage *> *)imagesForIdentifier:(NSString *)identifier;
- (void)saveImage:(PGImage *)image;

@end
