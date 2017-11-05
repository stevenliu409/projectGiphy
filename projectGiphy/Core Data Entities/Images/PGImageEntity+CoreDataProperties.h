//
//  PGImageEntity+CoreDataProperties.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGImageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PGImageEntity (CoreDataProperties)

+ (NSFetchRequest<PGImageEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic) float width;
@property (nonatomic) float height;
@property (nullable, nonatomic, copy) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
