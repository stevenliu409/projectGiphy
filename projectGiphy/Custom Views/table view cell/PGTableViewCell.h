//
//  PGTableViewCell.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PGGif;

typedef void(^onFavouriteButtonTappedBlock)(void);

@interface PGTableViewCell : UITableViewCell

@property (nonatomic, copy) onFavouriteButtonTappedBlock onBlock;
@property (nonatomic, copy) onFavouriteButtonTappedBlock offBlock;

+ (NSString *)cellIdentifier;
+ (NSString *)nibName;

- (void)updateWithGif:(PGGif *)gif;

@end
