//
//  PGImage.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, PGImageSizeType) {
    PGImageSizeTypeSmall = 0,
    PGImageSizeTypeMedium,
    PGImageSizeTypeLarge
};

@interface PGImage : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) PGImageSizeType sizeType;

@end
