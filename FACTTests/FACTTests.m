//
//  FACTTests.m
//  FACTTests
//
//  Created by Sowmya Srinivasan on 09/05/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkLayer.h"

@interface FACTTests : XCTestCase
@property NetworkLayer * networkLayer;
@property NSString * urlString1;
@property NSString * urlString2;

@end

@implementation FACTTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _networkLayer = [[NetworkLayer alloc] init];
    _urlString1 = @"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    _urlString1 = @"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
- (void) testDataDownload {
    [_networkLayer downloadDatacompletionBlock:^(BOOL succeeded, NSString * title, NSArray *details){
        XCTAssertTrue(succeeded,"Data Download Success");
        [[[XCUIApplication alloc] init].alerts[@"Network Error"].buttons[@"Ok"] tap];
        XCTAssertTrue(!succeeded,"Data Download failed");
        
    }];
}

- (void) testImageDownload1 {
    [_networkLayer downloadImage:_urlString1 completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertTrue(succeeded,"Image Download Success");
    }];
    
    [_networkLayer downloadImage:_urlString2 completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertTrue(!succeeded,"Image Download Failed");
    }];
}

@end
