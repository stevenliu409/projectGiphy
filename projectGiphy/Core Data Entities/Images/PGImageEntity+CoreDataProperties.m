//
//  PGImageEntity+CoreDataProperties.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGImageEntity+CoreDataProperties.h"

@implementation PGImageEntity (CoreDataProperties)

+ (NSFetchRequest<PGImageEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ImageEntity"];
}

@dynamic url;
@dynamic width;
@dynamic height;
@dynamic identifier;

@end
