//
//  PGGifRepository.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-04.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import "PGGifRepository.h"
#import "PGGif.h"
#import "PGGifEntity.h"
#import "PGGifConverter.h"
#import "AppDelegate.h"
#import "PGImageRepository.h"

@interface PGGifRepository ()
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) PGGifConverter *gifConverter;
@property (nonatomic, strong) PGImageRepository *imageRepository;
@end

@implementation PGGifRepository

///-------------------------------------------------
/// Properties
///-------------------------------------------------
#pragma mark - Properties

- (NSManagedObjectContext *)mainContext
{
    if (_mainContext == nil)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _mainContext = appDelegate.persistentContainer.viewContext;
    }
    return _mainContext;
}

- (PGGifConverter *)gifConverter
{
    if (_gifConverter == nil)
    {
        _gifConverter = [[PGGifConverter alloc] init];
    }
    return _gifConverter;
}

- (PGImageRepository *)imageRepository
{
    return [PGImageRepository sharedRepository];
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

- (void)saveGif:(PGGif *)gif
{
    NSManagedObjectContext *currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    currentContext.parentContext = self.mainContext;

    PGGifEntity *gifEntity = [self _retrieveGifEntityWithIdentifier:gif.identifier];
    [self.gifConverter updateGifEntity:gifEntity withGif:gif];

    [self _saveContext:currentContext];
}

- (void)_saveContext:(NSManagedObjectContext *)context
{
    [context performBlock:^{
        NSError *error;
        if (![context save:&error])
        {
            NSLog(@"error = %@", [error localizedDescription]);
        }

        if (context.parentContext != nil)
        {
            [context.parentContext performBlock:^{
                NSError *error;
                if (![context.parentContext save:&error])
                {
                    NSLog(@"error = %@", [error localizedDescription]);
                }
            }];
        }
    }];
}

- (PGGif *)retrieveGifWithIdentifier:(NSString *)identifier
{
    PGGifEntity *gifEntity = [self _retrieveGifEntityWithIdentifier:identifier];
    NSDictionary *images = [self.imageRepository imagesForIdentifier:identifier];

    PGGif *gif = [[PGGif alloc] initWithIdentifier:identifier images:images];
    gif.favourite = gifEntity.favourite;

    return gif;
}

- (PGGifEntity *)_retrieveGifEntityWithIdentifier:(NSString *)identifier
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GifEntity"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]];
    NSError *error = nil;
    NSArray *results = [self.mainContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error fetching Gif objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }

    if ([results count] == 0)
    {
        return [self _createGifEntity];
    }

    return [results firstObject];
}

- (PGGifEntity *)_createGifEntity
{
    NSManagedObjectContext *currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    currentContext.parentContext = self.mainContext;

    PGGifEntity *gifEntity = [NSEntityDescription insertNewObjectForEntityForName:@"GifEntity"
                                                           inManagedObjectContext:currentContext];
    [self _saveContext:currentContext];

    return gifEntity;
}

- (NSArray<PGGif *> *)retrieveFavouriteGifs
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GifEntity"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"favourite == YES"]];
    NSError *error = nil;
    NSArray *results = [self.mainContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error fetching Gif objects: %@\n%@", [error localizedDescription], [error userInfo]);
    }

    return results;
}

@end
