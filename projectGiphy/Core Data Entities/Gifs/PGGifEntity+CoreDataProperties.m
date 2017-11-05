//
//  PGGifEntity+CoreDataProperties.m
//  projectGiphy
//
//  Created by Steven Liu on 2017-11-05.
//  Copyright © 2017 Steven Liu. All rights reserved.
//
//

#import "PGGifEntity+CoreDataProperties.h"

@implementation PGGifEntity (CoreDataProperties)

+ (NSFetchRequest<PGGifEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GifEntity"];
}

@dynamic identifier;
@dynamic favourite;

@end
