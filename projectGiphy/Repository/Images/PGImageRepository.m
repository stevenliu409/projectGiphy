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
#import "PGImageEntity.h"
#import "PGImage.h"

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
    [self _retrieveImagesWithIdentifier:identifier];

    return nil;
}

- (NSArray<PGImageEntity *> *)_retrieveImagesWithIdentifier:(NSString *)identifier
{
    NSFetchRequest *request = [self _fetchImagesForIdentifier:identifier];
    [self _executeFetchForRequest:request];

    return nil;
}

- (void)saveImage:(PGImage *)image
{
    PGImageEntity *imageEntity = [self _retrieveImageWithIdentifier:image.identifier sizeType:image.sizeType];

    [self.imageConverter updateImageEntity:imageEntity withImage:image];

}

- (PGImageEntity *)_retrieveImageWithIdentifier:(NSString *)identifier sizeType:(PGImageSizeType)sizeType
{
    NSFetchRequest *request = [self _fetchImagesForIdentifier:identifier sizeType:sizeType];
    [self _executeFetchForRequest:request];

    return nil;
}

- (NSArray<PGImageEntity *> *)_createImageEntities
{
    return nil;
}

- (NSArray *)_executeFetchForRequest:(NSFetchRequest *)request
{
    NSManagedObjectContext *currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    NSError *error = nil;
    NSArray *results = [currentContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error fetching Gif objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }

    if ([results count] == 0)
    {
        return [self _createImageEntities];
    }

    return [results firstObject];
}

- (void)_save
{
    NSManagedObjectContext *currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    currentContext.parentContext = self.mainContext;

    [currentContext performBlock:^{
        NSError *error;
        if (![currentContext save:&error])
        {
            NSLog(@"error = %@", [error localizedDescription]);
        }

        if (currentContext.parentContext != nil)
        {
            [currentContext.parentContext performBlock:^{
                NSError *error;
                if (![currentContext.parentContext save:&error])
                {
                    NSLog(@"error = %@", [error localizedDescription]);
                }
            }];
        }
    }];
}


///-------------------------------------------------
/// Fetch Requests
///-------------------------------------------------
#pragma mark - Fetch Requests

- (NSFetchRequest *)_fetchImagesForIdentifier:(NSString *)identifier
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ImageEntity"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]];

    return request;
}

- (NSFetchRequest *)_fetchImagesForIdentifier:(NSString *)identifier sizeType:(PGImageSizeType)sizeType
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ImageEntity"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@ && sizeType == %@", identifier, sizeType]];

    return request;
}

@end
