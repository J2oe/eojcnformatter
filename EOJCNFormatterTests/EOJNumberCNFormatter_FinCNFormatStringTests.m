//
//  EOJNumberCNFormatter_FinCNFormatStringTests.m
//  EOJKitTests
//
//  Created by Joe on 2023-03-16.
//

#import <XCTest/XCTest.h>
#import "EOJNumberCNFormatter.h"

@interface EOJNumberCNFormatter_FinCNFormatStringTests : XCTestCase

@end

@implementation EOJNumberCNFormatter_FinCNFormatStringTests

// MARK: - 非法值

- (void)testNil {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:nil];
    XCTAssertEqualObjects(result, @"");
}

- (void)testNull {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:[NSNull null]];
    XCTAssertEqualObjects(result, @"");
}

- (void)testEmptyStr {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@""];
    XCTAssertEqualObjects(result, @"");
}

- (void)test54_0_1 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"54.0.1"];
    XCTAssertEqualObjects(result, @"");
}

// MARK: - 前置0

//- (void)test0032 {
//    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"0032"];
//    XCTAssertEqualObjects(result, @"叁拾贰元整");
//}

// MARK: - 最多4位数整数 + 最多3位小数

- (void)test0 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"0"];
    XCTAssertEqualObjects(result, @"零元整");
}

- (void)test2 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"2"];
    XCTAssertEqualObjects(result, @"贰元整");
}

- (void)test32 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"32"];
    XCTAssertEqualObjects(result, @"叁拾贰元整");
}

- (void)test432 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"432"];
    XCTAssertEqualObjects(result, @"肆佰叁拾贰元整");
}

- (void)test5432 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5432"];
    XCTAssertEqualObjects(result, @"伍仟肆佰叁拾贰元整");
}

- (void)test541__0 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"541.0"];
    XCTAssertEqualObjects(result, @"伍佰肆拾壹元整");
}

- (void)test541__2 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"541.2"];
    XCTAssertEqualObjects(result, @"伍佰肆拾壹元贰角");
}

- (void)test541__08 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"541.08"];
    XCTAssertEqualObjects(result, @"伍佰肆拾壹元零捌分");
}

- (void)test5432__18 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5432.18"];
    XCTAssertEqualObjects(result, @"伍仟肆佰叁拾贰元壹角捌分");
}

- (void)test541__234 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"541.234"];
    XCTAssertEqualObjects(result, @"伍佰肆拾壹元贰角叁分肆厘");
}

- (void)test541__004 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"541.004"];
    XCTAssertEqualObjects(result, @"伍佰肆拾壹元零肆厘");
}

- (void)test5000__004 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5000.004"];
    XCTAssertEqualObjects(result, @"伍仟元零肆厘");
}

- (void)test5000__0041 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5000.0041"];
    XCTAssertEqualObjects(result, @"伍仟元零肆厘");
}

- (void)test10 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"10"];
    XCTAssertEqualObjects(result, @"壹拾元整");
}

- (void)test200 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"200"];
    XCTAssertEqualObjects(result, @"贰佰元整");
}

- (void)test3000 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"3000"];
    XCTAssertEqualObjects(result, @"叁仟元整");
}

- (void)test5402 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5402"];
    XCTAssertEqualObjects(result, @"伍仟肆佰零贰元整");
}

- (void)test5002 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"5002"];
    XCTAssertEqualObjects(result, @"伍仟零贰元整");
}

// MARK: - 5 ~ 8 位整数部分

- (void)test5_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"54321"];
    XCTAssertEqualObjects(result, @"伍萬肆仟叁佰贰拾壹元整");
}

- (void)test65_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"654321"];
    XCTAssertEqualObjects(result, @"陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"7654321"];
    XCTAssertEqualObjects(result, @"柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"87654321"];
    XCTAssertEqualObjects(result, @"捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test5_0004 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"50004"];
    XCTAssertEqualObjects(result, @"伍萬零肆元整");
}

- (void)test5_0014 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"50014"];
    XCTAssertEqualObjects(result, @"伍萬零壹拾肆元整");
}

- (void)test5_0104 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"50104"];
    XCTAssertEqualObjects(result, @"伍萬零壹佰零肆元整");
}

- (void)test50_1234 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"501234"];
    XCTAssertEqualObjects(result, @"伍拾萬壹仟贰佰叁拾肆元整");
}

- (void)test51_0234 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"510234"];
    XCTAssertEqualObjects(result, @"伍拾壹萬零贰佰叁拾肆元整");
}


// MARK: - 9 ~ 13 位整数部分. 亿
- (void)test9_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"987654321"];
    XCTAssertEqualObjects(result, @"玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test19_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"1987654321"];
    XCTAssertEqualObjects(result, @"壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"21987654321"];
    XCTAssertEqualObjects(result, @"贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test3219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"321987654321"];
    XCTAssertEqualObjects(result, @"叁仟贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test9_8005_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"980054321"];
    XCTAssertEqualObjects(result, @"玖亿捌仟零伍萬肆仟叁佰贰拾壹元整");
}

- (void)test9_8000_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"980004321"];
    XCTAssertEqualObjects(result, @"玖亿捌仟萬肆仟叁佰贰拾壹元整");
}

- (void)test9_8000_0321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"980000321"];
    XCTAssertEqualObjects(result, @"玖亿捌仟萬零叁佰贰拾壹元整");
}

- (void)test9_8050_0321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"980500321"];
    XCTAssertEqualObjects(result, @"玖亿捌仟零伍拾萬零叁佰贰拾壹元整");
}

// MARK: - 万亿

- (void)test4_3219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"4321987654321"];
    XCTAssertEqualObjects(result, @"肆萬叁仟贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test54_3219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"54321987654321"];
    XCTAssertEqualObjects(result, @"伍拾肆萬叁仟贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test654_3219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"654321987654321"];
    XCTAssertEqualObjects(result, @"陆佰伍拾肆萬叁仟贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整");
}

- (void)test7654_3219_8765_4321 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"7654321987654321"];
    XCTAssertTrue([result isEqualToString:@"柒仟陆佰伍拾肆萬叁仟贰佰壹拾玖亿捌仟柒佰陆拾伍萬肆仟叁佰贰拾壹元整"]);
}

- (void)test7000_0000_0000_0001 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"7000000000000001"];
    XCTAssertTrue([result isEqualToString:@"柒仟萬亿零壹元整"]);
}

- (void)test120_0000_0000_0000 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"120000000000000"];
    XCTAssertTrue([result isEqualToString:@"壹佰贰拾萬亿元整"]);
}

- (void)test7000_0000_0001 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"700000000001"];
    XCTAssertTrue([result isEqualToString:@"柒仟亿零壹元整"]);
}

- (void)test7000_0000_0000_2001 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"7000000000002001"];
    XCTAssertTrue([result isEqualToString:@"柒仟萬亿零贰仟零壹元整"]);
}

- (void)test7000_0000_0300_2001 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"7000000003002001"];
    XCTAssertTrue([result isEqualToString:@"柒仟萬亿零叁佰萬贰仟零壹元整"]);
}

// MARK: - > 16位
- (void)test7_0000_0000_0300_2001 {
    NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"70000000003002001"];
    XCTAssertTrue([result isEqualToString:@""]);
}

@end
