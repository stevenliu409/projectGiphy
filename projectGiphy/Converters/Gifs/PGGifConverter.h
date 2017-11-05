//
//  PGGifConverter.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PGGif;
@class PGGifEntity;
@interface PGGifConverter : NSObject

- (PGGif *)createGifFromJSON:(NSDictionary *)json;
- (PGGif *)gifFromGifEntity:(PGGifEntity *)gifEntity;
- (void)updateGifEntity:(PGGifEntity *)gifEntity withGif:(PGGif *)gif;

@end
