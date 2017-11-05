//
//  PGTrendingViewModel.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-31.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGTableCellViewModel.h"
#import "PGNetworkManager.h"
#import "PGGifConverter.h"
#import "PGGif.h"
#import "PGGifRepository.h"

@interface PGTableCellViewModel ()

@property (nonatomic, strong) PGGifConverter *gifConverter;
@property (nonatomic, strong) NSMutableArray *mutableGifs;
@property (nonatomic, copy) PGTableCellViewModelCompletionHandler completion;
@property (nonatomic, strong) PGGifRepository *gifRepository;

@end

@implementation PGTableCellViewModel

///-------------------------------------------------
/// Properties
///-------------------------------------------------
#pragma mark - Properties

- (PGGifConverter *)gifConverter
{
    if (_gifConverter == nil)
    {
        _gifConverter = [[PGGifConverter alloc] init];
    }
    return _gifConverter;
}

- (NSArray *)gifs
{
    return self.mutableGifs;
}

- (PGGifRepository *)gifRepository
{
    return [PGGifRepository sharedRepository];
}


///-------------------------------------------------
/// Initialization
///-------------------------------------------------
#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _mutableGifs = [NSMutableArray new];
    }

    return self;
}


///-------------------------------------------------
/// Network
///-------------------------------------------------
#pragma mark - Network

- (void)setupTrendingDataWithCompletion:(PGTableCellViewModelCompletionHandler)completion
{
    self.completion = completion;

    __weak typeof(self)weakSelf = self;
    [[PGNetworkManager sharedManager] getTrendingWithCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
        [weakSelf _parseResponseData:data response:response];
        [weakSelf _onCompletion];
    }];
}

- (void)setupSearchDataWithSearchString:(NSString *)searchString completion:(PGTableCellViewModelCompletionHandler)completion
{
    self.completion = completion;

    NSString *search = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    __weak typeof(self)weakSelf = self;
    [[PGNetworkManager sharedManager] getSearchDataForSearch:search completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        [weakSelf _parseResponseData:data response:response];
        [weakSelf _onCompletion];
    }];
}

- (void)_parseResponseData:(NSData *)data response:(NSURLResponse *)response
{
    NSError *parseError = nil;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    NSArray *trendingData = responseDictionary[@"data"];

    if (trendingData != nil)
    {
        for (NSDictionary *json in trendingData)
        {
            if (json != nil)
            {
                PGGif *gif = [self.gifConverter createGifFromJSON:json];
                [self.mutableGifs addObject:gif];
            }
        }
    }
}

- (void)_onCompletion
{
    if (self.completion != nil)
    {
        self.completion();
    }
}


///-------------------------------------------------
/// CoreData
///-------------------------------------------------
#pragma mark - CoreData

- (void)updateGif:(PGGif *)gif
{
    [self.gifRepository saveGif:gif];
}

- (BOOL)containGifWithIdentifier:(NSString *)identifier
{
    return NO;
}

- (PGGif *)retrieveFavouriteGifWithIdentifier:(NSString *)identifier
{
    return [self.gifRepository retrieveGifWithIdentifier:identifier];
}


@end
