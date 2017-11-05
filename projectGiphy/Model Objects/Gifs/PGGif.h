//
//  PGGif.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PGImage;

@interface PGGif : NSObject

@property (nonatomic, readonly) NSDictionary<NSString *, PGImage *> *images;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, assign, getter=isFavourite) BOOL favourite;

- (instancetype)initWithIdentifier:(NSString *)identifier images:(NSDictionary <NSString *, PGImage *> *)images;
@end
