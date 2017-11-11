//
//  PGImageEntity+CoreDataProperties.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-11.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGImageEntity.h"

@implementation PGImageEntity (CoreDataProperties)

+ (NSFetchRequest<PGImageEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ImageEntity"];
}

@dynamic height;
@dynamic identifier;
@dynamic url;
@dynamic width;
@dynamic sizeType;

@end
