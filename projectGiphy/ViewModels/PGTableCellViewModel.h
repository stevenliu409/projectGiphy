//
//  PGTableCellViewModel.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-31.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PGTableCellViewModelCompletionHandler)(void);

@class PGGif;
@interface PGTableCellViewModel : NSObject

@property (nonatomic, readonly) NSArray *gifs;


- (void)setupTrendingDataWithCompletion:(PGTableCellViewModelCompletionHandler)completion;
- (void)setupSearchDataWithSearchString:(NSString *)searchString completion:(PGTableCellViewModelCompletionHandler)completion;
- (void)updateGif:(PGGif *)gif;
- (BOOL)containGifWithIdentifier:(NSString *)identifier;
- (PGGif *)retrieveFavouriteGifWithIdentifier:(NSString *)identifier;
@end
