//
//  PGGifConverterTests.m
//  projectGiphyTests
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PGGifConverter.h"
#import "PGGif.h"
#import "PGImage.h"

@interface PGGifConverterTests : XCTestCase
@property (nonatomic, strong) PGGifConverter *gifConverter;
@end

@implementation PGGifConverterTests

- (void)setUp {
    [super setUp];
    self.gifConverter = [[PGGifConverter alloc] init];
}

- (void)testGifFromJSON
{
    NSDictionary *gifDict = [self _createGIFData];

    PGGif *gif = [self.gifConverter createGifFromJSON:gifDict];

    XCTAssertTrue([gif.identifier isEqualToString:@"l2R072qHOAH9YceZ2"]);
    XCTAssertEqual([[gif.images allValues] count], 3);
}

- (NSDictionary *)_createGIFData
{
    NSMutableDictionary *example = [[NSMutableDictionary alloc] init];
    [example setValue:@"l2R072qHOAH9YceZ2" forKey:@"id"];

    NSDictionary *imagesJSON = [self _createImagesData];
    [example setObject:imagesJSON forKey:@"images"];

    return example;
}

- (NSDictionary *)_createImagesData
{
    NSMutableDictionary *example = [[NSMutableDictionary alloc] init];

    NSDictionary *imageJSON = [self _createSingleImageData];
    [example setObject:imageJSON forKey:@"preview_gif"];
    [example setValue:imageJSON forKey:@"fixed_width"];
    [example setValue:imageJSON forKey:@"downsized"];

    return example;
}

- (NSDictionary *)_createSingleImageData
{
    NSMutableDictionary *example = [[NSMutableDictionary alloc] init];
    [example setValue:@"www.google.com" forKey:@"url"];
    [example setValue:@"100" forKey:@"width"];
    [example setValue:@"200" forKey:@"height"];

    return example;
}


@end
