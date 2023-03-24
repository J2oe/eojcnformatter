//
//  EOJNumberCNFormatter_cnNumFormatStringTests.m
//  EOJKitTests
//
//  Created by Joe on 2023-03-23.
//

#import <XCTest/XCTest.h>
#import "EOJNumberCNFormatter.h"

@interface EOJNumberCNFormatter_cnNumFormatStringTests : XCTestCase
@property(nonatomic,strong)EOJNumberCNFormatter *formatter;

@property(nonatomic,copy)NSDictionary *originResultsMap;
@end

@implementation EOJNumberCNFormatter_cnNumFormatStringTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    EOJNumberCNFormatter *formatter = [[EOJNumberCNFormatter alloc] init];
    _formatter = formatter;
    
    _originResultsMap = @{
        @"0.0001": @"0.0001",
        @"0.001": @"0.001",
        @"0.01": @"0.01",
        @"0.1": @"0.1",
        @"0.0": @"0.0",
        @"0": @"0",
        @"10": @"10",
        @"100": @"100",
        @"1000": @"1000",
        @"10000": @"1,0000",
        @"100000": @"10,0000",
        @"1000000": @"100,0000",
        @"10000000": @"1000,0000",
        @"100000000": @"1,0000,0000",
        @"1000000000": @"10,0000,0000",
        @"10000000000": @"100,0000,0000",
        @"100000000000": @"1000,0000,0000",
        @"1000000000000": @"1,0000,0000,0000",
        @"10000000000000": @"10,0000,0000,0000",
        @"100000000000000": @"100,0000,0000,0000",
        @"1000000000000000": @"1000,0000,0000,0000",
        
        @"10000000000000000": @"",
        
        @"100.01": @"100.01",
        @"100.20": @"100.20",
        @"100000000000.01": @"1000,0000,0000.01"
    };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _formatter = nil;
    
    _originResultsMap = nil;
}

- (void)test0 {
    NSString *string = @"0";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test10 {
    NSString *string = @"10";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test1000 {
    NSString *string = @"1000";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test10000 {
    NSString *string = @"10000";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test1000000 {
    NSString *string = @"1000000";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test100000000000 {
    NSString *string = @"100000000000";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test0_0 {
    NSString *string = @"0.0";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test100_01 {
    NSString *string = @"100.01";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test100000000000_01 {
    NSString *string = @"100000000000.01";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}

- (void)test10000000000000000 {
    NSString *string = @"10000000000000000";
    self.formatter.numString = string;
    
    NSString *result = [self.formatter cnNumFormatString];
    XCTAssertTrue([result isEqualToString:self.originResultsMap[string]]);
}



@end
