//
//  PGTableViewCell.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGTableViewCell.h"
#import "PGGif.h"
#import "PGImage.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <FLAnimatedImage/FLAnimatedImage.h>

@interface PGTableViewCell ()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;

@property (nonatomic, strong) PGGif *gif;
@end

@implementation PGTableViewCell

+ (NSString *)cellIdentifier
{
    return @"PGTableViewCellIdentifier";
}

+ (NSString *)nibName
{
    return @"PGTableViewCell";
}

- (void)updateWithGif:(PGGif *)gif
{
    self.gif = gif;
    PGImage *image = self.gif.images[@"small"];

    if (image.webURL == nil)
    {
        [self _showError];
    }
    else
    {
        [self _showImage];
    }

    (self.gif.isFavourite) ? [self _setButtonAsFavourite] : [self _setButtonAsUnfavourite];
}

- (IBAction)onFavouriteButtonTapped
{
    if (self.gif.isFavourite)
    {
        if (self.onBlock != nil)
        {
            self.onBlock();
        }
    }
    else
    {
        if (self.offBlock != nil)
        {
            self.offBlock();
        }
    }

    (self.gif.isFavourite) ? [self _setButtonAsFavourite] : [self _setButtonAsUnfavourite];
}

- (void)_showImage
{
    PGImage *image = self.gif.images[@"small"];
    NSLog(@"trending data = %@", image.webURL);

    FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image.webURL]]];
    self.gifImageView.animatedImage = gifImage;
    self.statusLabel.text = @"";
    self.favouriteButton.hidden = NO;
}

- (void)_showError
{
    self.gifImageView.animatedImage = nil;
    self.statusLabel.text = @"Oops! Something went wrong!";
    self.favouriteButton.hidden = YES;
}

- (void)_setButtonAsFavourite
{
    UIImage *favouriteImage = [UIImage imageNamed:@"favourite-on"];
    [self.favouriteButton setImage:favouriteImage forState:UIControlStateNormal];
}

- (void)_setButtonAsUnfavourite
{
    UIImage *favouriteImage = [UIImage imageNamed:@"favourite-off"];
    [self.favouriteButton setImage:favouriteImage forState:UIControlStateNormal];
}

@end
