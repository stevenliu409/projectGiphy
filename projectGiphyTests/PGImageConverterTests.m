//
//  PGImageConverterTests.m
//  projectGiphyTests
//
//  Created by Steven Liu on 2017-10-29.
//  Copyright © 2017 Steven Liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PGImageConverter.h"
#import "PGImage.h"

@interface PGImageConverterTests : XCTestCase
@property (nonatomic, strong) PGImageConverter *imageConverter;
@end

@implementation PGImageConverterTests

- (void)setUp {
    [super setUp];
    self.imageConverter = [[PGImageConverter alloc] init];
}

- (void)testImageFromJSON
{
    NSDictionary *json = [self _createSingleImageData];
    PGImage *image = [self.imageConverter imageFromJSON:json];

    XCTAssertTrue([image.webURL isEqualToString:@"www.google.com"]);
    XCTAssertEqual(image.width, 100);
    XCTAssertEqual(image.height, 200);
}

- (void)testImagesFromJSON
{
    NSDictionary *json = [self _createGIFData];
    NSDictionary *images = [self.imageConverter imagesFromJSON:json[@"images"] withIdentifier:json[@"id"]];

    XCTAssertEqual([[images allValues] count], 3);
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
