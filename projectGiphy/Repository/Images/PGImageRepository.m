//
//  PGImageRepository.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGImageRepository.h"
#import "PGImageConverter.h"
#import "AppDelegate.h"

@interface PGImageRepository ()
@property (nonatomic, strong) PGImageConverter *imageConverter;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@end

@implementation PGImageRepository

///-------------------------------------------------
/// Properties
///-------------------------------------------------
#pragma mark - Properties

- (PGImageConverter *)imageConverter
{
    if (_imageConverter == nil)
    {
        _imageConverter = [[PGImageConverter alloc] init];
    }
    return _imageConverter;
}

- (NSManagedObjectContext *)mainContext
{
    if (_mainContext == nil)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _mainContext = appDelegate.persistentContainer.viewContext;
    }
    return _mainContext;
}


///-------------------------------------------------
/// Initialization
///-------------------------------------------------
#pragma mark - Initialization

+ (instancetype)sharedRepository {
    static id _sharedRepository = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _sharedRepository = [[self.class alloc] init];
    });

    return _sharedRepository;
}


///-------------------------------------------------
/// Core Data methods
///-------------------------------------------------
#pragma mark - Core Data methods

- (NSDictionary<NSString *,PGImage *> *)imagesForIdentifier:(NSString *)identifier
{
    return nil;
}

@end
