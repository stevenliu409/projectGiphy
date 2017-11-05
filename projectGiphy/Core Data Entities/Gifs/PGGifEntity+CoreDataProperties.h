//
//  PGGifEntity+CoreDataProperties.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-05.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGGifEntity.h"


NS_ASSUME_NONNULL_BEGIN

@interface PGGifEntity (CoreDataProperties)

+ (NSFetchRequest<PGGifEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *identifier;
@property (nonatomic) BOOL favourite;

@end

NS_ASSUME_NONNULL_END
