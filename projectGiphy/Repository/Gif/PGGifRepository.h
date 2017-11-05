//
//  PGGifRepository.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PGGif;
@interface PGGifRepository : NSObject

+ (instancetype)sharedRepository;

- (void)saveGif:(PGGif *)gif;
- (PGGif *)retrieveGifWithIdentifier:(NSString *)identifier;
- (NSArray<PGGif *> *)retrieveFavouriteGifs;

@end
