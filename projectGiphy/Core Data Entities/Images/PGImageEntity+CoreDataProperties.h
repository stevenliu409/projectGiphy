//
//  PGImageEntity+CoreDataProperties.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-11.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGImageEntity.h"


NS_ASSUME_NONNULL_BEGIN

@interface PGImageEntity (CoreDataProperties)

+ (NSFetchRequest<PGImageEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *identifier;
@property (nullable, nonatomic, copy) NSString *webURL;
@property (nullable, nonatomic, copy) NSString *fileURL;
@property (nonatomic) int64_t sizeType;
@property (nonatomic) float width;
@property (nonatomic) float height;

@end

NS_ASSUME_NONNULL_END
