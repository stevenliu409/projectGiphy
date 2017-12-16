//
//  PGImageEntity+CoreDataProperties.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-11.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGImageEntity+CoreDataProperties.h"

@implementation PGImageEntity (CoreDataProperties)

+ (NSFetchRequest<PGImageEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ImageEntity"];
}

@dynamic identifier;
@dynamic sizeType;
@dynamic webURL;
@dynamic width;
@dynamic height;
@dynamic fileURL;

@end
