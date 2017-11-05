//
//  PGTrendingViewController.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGTrendingViewController.h"
#import "PGTableCellViewModel.h"
#import "PGGif.h"
#import "PGImage.h"
#import <FLAnimatedImageView.h>
#import "FLAnimatedImage.h"
#import "PGTableViewCell.h"

@interface PGTrendingViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PGTableCellViewModel *tableViewCellVM;
@end

@implementation PGTrendingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupTableView];
    [self _getTrendingData];
}

- (void)_setupTableView
{
    UINib *cellNib = [UINib nibWithNibName:[PGTableViewCell nibName] bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:[PGTableViewCell cellIdentifier]];
}


///-------------------------------------------------
/// UITableViewDataSource Methods
///-------------------------------------------------
#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewCellVM.gifs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PGTableViewCell cellIdentifier]
                                                            forIndexPath:indexPath];

    PGGif *gif = self.tableViewCellVM.gifs[indexPath.row];

    __weak typeof(self)weakSelf = self;
    cell.onBlock = ^{
        gif.favourite = NO;
        [weakSelf.tableViewCellVM updateGif:gif];
    };

    cell.offBlock = ^{
        gif.favourite = YES;
        [weakSelf.tableViewCellVM updateGif:gif];
    };

    [cell updateWithGif:gif];

    return cell;
}


///-------------------------------------------------
/// UISearchBar Delegates
///-------------------------------------------------
#pragma mark - UISearchBar Delegates

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self _getSearchDataWithSearch:searchBar.text];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self _getTrendingData];
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""])
    {
        [self _getTrendingData];
    }
    else
    {
        [self _getSearchDataWithSearch:searchBar.text];
    }

    [searchBar resignFirstResponder];
}

- (void)_getSearchDataWithSearch:(NSString *)search
{
    self.tableViewCellVM = [[PGTableCellViewModel alloc] init];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self)weakSelf = self;
    [self.tableViewCellVM setupSearchDataWithSearchString:search completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
}

- (void)_getTrendingData
{
    self.tableViewCellVM = [[PGTableCellViewModel alloc] init];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak typeof(self)weakSelf = self;
    [self.tableViewCellVM setupTrendingDataWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
}

@end
