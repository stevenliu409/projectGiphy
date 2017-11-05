//
//  PGImage.h
//  projectGiphy
//
//  Created by Steven Liu on 2017-10-28.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGImage : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

@end
