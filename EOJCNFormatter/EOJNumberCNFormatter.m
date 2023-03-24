//
//  EOJNumberCNFormatter.m
//  EOJKit
//
//  Created by Joe on 2023-03-20.
//

#import "EOJNumberCNFormatter.h"

NSDictionary *map = @{
    @"0": @"零",
    @"1": @"壹",
    @"2": @"贰",
    @"3": @"叁",
    @"4": @"肆",
    @"5": @"伍",
    @"6": @"陆",
    @"7": @"柒",
    @"8": @"捌",
    @"9": @"玖",
};

NSString *vAlpha0 = @"0";
NSString *vCN0 = @"零";

NSString *vCNInt = @"整";

NSString *yuan = @"元";
NSArray *fraUnits = @[@"角", @"分", @"厘"];
NSArray *intUnits = @[@"", @"拾", @"佰", @"仟"];

NSUInteger vSegmentLen = 4;
NSArray *wUnits = @[@"", @"萬"];

NSUInteger vLevelLen = 8;
NSArray *eUnits = @[@"", @"亿"]; // TODO: 超过16位的，需要新的单位处理。目前不明确。


@interface EOJNumberCNFormatter ()

@end

@implementation EOJNumberCNFormatter
{
    NSString *_Nullable _financeCNString;
}

+ (NSString *)cnFinNumStringFromString:(NSString *)aString {
    EOJNumberCNFormatter *formmatter = [[EOJNumberCNFormatter alloc] init];
    formmatter.numString = aString;
    return [formmatter getFinCNFormatString];
}


- (void)setNumString:(NSString *)numString {
    if (_numString != numString) {
        _financeCNString = nil;
        
        if ([self checkInputNumStringAvailable:numString]) {
            _numString = numString;
        } else {
            _numString = nil;
        }
    }
}

/// 检查输入字符串的有效性
/// - Parameter aString: 输入数字字符串
- (BOOL)checkInputNumStringAvailable:(NSString *)aString {
    if (![aString isKindOfClass:[NSString class]]) {
        return false;
    }
    
    if ([aString length] == 0) {
        return false;
    }
    
    NSArray *strArr = [self getSeparatedByDotArrayFrom:aString];
    NSUInteger length = [strArr count];
    if (length > 2 || length == 0) {
        return false;
    }
    
    // 整数部分
    NSString *intPart = strArr.firstObject;
    if ([intPart length] > (vLevelLen * [eUnits count])) {
        return false;
    }
    
    // TODO: 将前置0全部去掉
    
    return true;
}

- (NSArray *)getSeparatedByDotArrayFrom:(NSString *)aString {
    if (![aString isKindOfClass:[NSString class]]) {
        return @[];
    }
    
    NSString *dot = @".";
    NSArray *strArr = [aString componentsSeparatedByString:dot];
    return strArr;
}

- (NSString *)getFinCNFormatString {
    if (!_financeCNString) {
        _financeCNString = [self finNumStringFromString:self.numString];
    }
    return _financeCNString;
}

- (NSString *)finNumStringFromString:(NSString *)aString {
    if (![aString isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    NSArray *strArr = [self getSeparatedByDotArrayFrom:aString];
    NSUInteger length = [strArr count];
    
    NSMutableArray *mConvertedArr = [NSMutableArray arrayWithCapacity:length];
    
    // 整数部分
    NSString *intPart = strArr.firstObject;
    NSString *convertedIntPart = [self _cnIntStringFromString:intPart];
    [mConvertedArr addObject:[convertedIntPart stringByAppendingString:yuan]];
    
    if (length == 2) {
        // 小数部分. 最多3位，超过则截取
        NSString *fraPart = @"";
        if ([strArr.lastObject length] > 3) {
            fraPart = [strArr.lastObject substringToIndex:3];
        } else {
            fraPart = strArr.lastObject;
        }
        NSString *convertedFraPart = [self _cnFraStringFromString:fraPart];
        if ([convertedFraPart length] != 0) {
            [mConvertedArr addObject:convertedFraPart];
        } else {
            [mConvertedArr addObject:vCNInt];
        }
    } else {
        [mConvertedArr addObject:vCNInt];
    }
    
    return [mConvertedArr componentsJoinedByString:@""];
}

/// 转换小数部分
/// - Parameter aString: <#aString description#>
- (NSString *)_cnFraStringFromString:(NSString *)aString {
    if ([aString integerValue] == 0) {
        return @"";
    }
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:[aString length]];
    
    NSUInteger length = [aString length];
    for (int index = 0; index < length; index++) {
        NSString *sub = [aString substringWithRange:NSMakeRange(index, 1)];
        
        if ([sub isEqualToString:vAlpha0]) {
            if (![mArr.firstObject isEqualToString:vCN0]) {
                NSString *value = map[sub];
                [mArr addObject:value];
            }
            
        } else {
            NSString *value = map[sub];
            NSString *unit = fraUnits[index];
            NSString *elementValue = [value stringByAppendingString:unit];
            [mArr addObject:elementValue];
        }
    }
    
    NSString *retStr = [mArr componentsJoinedByString:@""];
    return retStr;
}

/// 转换整数部分
/// - Parameter aString: <#aString description#>
- (NSString *)_cnIntStringFromString:(NSString *)aString {
    NSLog(@"%s. aString: %@", __PRETTY_FUNCTION__, aString);
    
    NSArray *mSubArr = [self getDescendingSegmentsArray:aString withSegmentLength:vLevelLen];
    NSLog(@"%s. mSubArr: %@", __PRETTY_FUNCTION__, mSubArr);
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:[mSubArr count]];
    for (int index=0; index<[mSubArr count]; index++) {
        NSString *element = [mSubArr objectAtIndex:index];
        NSString *value = [self _cn8IntStringFromString:element];
        NSString *unit = [eUnits objectAtIndex:index];
        NSString *unitValue = [value stringByAppendingString:unit];
        [mArr addObject:unitValue];
    }
    
    return [self getStrAfterSortingDescendingArr:[mArr copy] withJoinStr:nil];
}

/// 处理8位分段
/// - Parameter aString: <#aString description#>
- (NSString *)_cn8IntStringFromString:(NSString *)aString {
    NSLog(@"%s. aString: %@", __PRETTY_FUNCTION__, aString);
    
    NSArray *mSubArr = [self getDescendingSegmentsArray:aString withSegmentLength:vSegmentLen];
    NSLog(@"%s. mSubArr: %@", __PRETTY_FUNCTION__, mSubArr);
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:[mSubArr count]];
    for (int index=0; index<[mSubArr count]; index++) {
        NSString *element = [mSubArr objectAtIndex:index];
        NSString *value = [self _cn4IntStringFromString:element];
        if ([value length] > 0) {
            NSString *unit = [wUnits objectAtIndex:index];
            NSString *unitValue = [value stringByAppendingString:unit];
            [mArr addObject:unitValue];
        } else {
            // 值为0时，当前栈顶存在值，且值非“零”，才入栈”零“。 因mSubArr 为倒序，栈顶在 mArr 尾部。
            NSString *lastItem = mArr.lastObject;
            if (lastItem && ![vCN0 isEqualToString:[lastItem substringToIndex:1]]) {
                [mArr addObject:vCN0];
            }
        }
    }
    
    return [self getStrAfterSortingDescendingArr:[mArr copy] withJoinStr:nil];
}

/// 将字符串分段后的数组. 数组元素为倒序。
/// - Parameters:
///   - aString: 原字符串
///   - aSegmentLength: 分段基数. <= 0，返回数组，原数组为唯一数组元素。
- (NSArray *)getDescendingSegmentsArray:(NSString *)aString withSegmentLength:(NSUInteger)aSegmentLength {
    NSLog(@"%s. aString: %@, aSegmentLength: %lu", __PRETTY_FUNCTION__, aString, (unsigned long)aSegmentLength);
    if (aSegmentLength <= 0) {
        return @[aString];
    }
    
    NSUInteger segmentsCount = [aString length] / aSegmentLength;
    NSMutableArray *mSegmentsArr = [NSMutableArray arrayWithCapacity:segmentsCount];
    for (int i=0; i<segmentsCount; i++) {
        NSInteger loc = [aString length] - aSegmentLength * (i + 1);
        NSRange range = NSMakeRange(loc, aSegmentLength);
        NSString *sub = [aString substringWithRange:range];
        [mSegmentsArr addObject:sub];
    }
    
    NSInteger restLen = [aString length] - segmentsCount * aSegmentLength;
    if (restLen > 0) {
        NSRange range = NSMakeRange(0, restLen);
        NSString *sub = [aString substringWithRange:range];
        [mSegmentsArr addObject:sub];
    }
    NSLog(@"%s. mSegmentsArr: %@", __PRETTY_FUNCTION__, mSegmentsArr);
    return [mSegmentsArr copy];;
}

/// 合并转换后金额分段数组为字符串
/// - Parameter aDescendingArr: 转换后金额分段数组
/// - Parameter aJoinStr: 连接符
- (NSString *)getStrAfterSortingDescendingArr:(NSArray *)aDescendingArr withJoinStr:(nullable NSString *)aJoinStr {
    NSLog(@"%s. aDescendingArr: %@, aJoinStr: %@", __PRETTY_FUNCTION__, aDescendingArr, aJoinStr);
    
    NSArray *sortedArr = [aDescendingArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return NSOrderedDescending;
    }];
    
    NSString *joinStr = (aJoinStr ? aJoinStr : @"");
    
    NSString *retStr = [sortedArr componentsJoinedByString:joinStr];
    NSLog(@"%s. sortedArr joined str: %@", __PRETTY_FUNCTION__, retStr);
    return retStr;
}

/// 处理4位分段
/// - Parameter aString: <#aString description#>
- (NSString *)_cn4IntStringFromString:(NSString *)aString {
    NSLog(@"%s. aString: %@", __PRETTY_FUNCTION__, aString);
    
    NSUInteger length = [aString length];
    
    if (length == 1) {
        NSString *value = map[aString];
        return value;
    }
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:length];
    for (NSInteger index = length - 1; index >= 0; index--) {
        NSString *sub = [aString substringWithRange:NSMakeRange(index, 1)];
        if ([sub isEqualToString:vAlpha0]) {
            // 值为0时，当前栈顶存在值，且值非“零”，才入栈”零“. 因 aString 为正序，栈顶在 mArr 头部。
            NSString *stackTopValue = mArr.firstObject;
            if (stackTopValue && ![stackTopValue isEqualToString:vCN0]) {
                NSString *value = map[sub];
                [mArr insertObject:value atIndex:0];
            }
            
        } else {
            NSString *value = map[sub];
            NSString *unit = [intUnits objectAtIndex:(length - 1 - index)];
            NSString *elementValue = [value stringByAppendingString:unit];
            [mArr insertObject:elementValue atIndex:0];
        }
        
    }
    
    NSString *retStr = [mArr componentsJoinedByString:@""];
    NSLog(@"%s. retStr: %@", __PRETTY_FUNCTION__, retStr);
    return retStr;
}


- (NSString *)cnNumFormatString {
    NSArray *strArr = [self getSeparatedByDotArrayFrom:self.numString];
    NSString *intPartStr = strArr.firstObject;
    NSArray *descendingArr = [self getDescendingSegmentsArray:intPartStr withSegmentLength:vSegmentLen];
    NSString *acendingStr = [self getStrAfterSortingDescendingArr:descendingArr withJoinStr:@","];
    NSString *retStr = @"";
    if ([strArr count] > 1) {
        NSArray *arr = @[acendingStr, strArr.lastObject];
        retStr = [arr componentsJoinedByString:@"."];
    } else {
        retStr = acendingStr;
    }
    return retStr;
}

- (NSString *)cnNumFullFormatString {
    NSString *str = [self cnNumFormatString];
    NSString *curSymbol = @"¥";
    NSString *retStr = [curSymbol stringByAppendingString:str];
    return retStr;
}

@end
