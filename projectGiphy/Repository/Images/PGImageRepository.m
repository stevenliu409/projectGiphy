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
    return nil;
}

- (void)saveImage:(PGImage *)image
{
    PGImageEntity *imageEntity = [self _retrieveImageWithIdentifier:image.identifier];
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

- (PGImageEntity *)_retrieveImageWithIdentifier:(NSString *)identifier
{
    NSManagedObjectContext *currentContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ImageEntity"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", identifier]];
    NSError *error = nil;
    NSArray *results = [currentContext executeFetchRequest:request error:&error];
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



@end
