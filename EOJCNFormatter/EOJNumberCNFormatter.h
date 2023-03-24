//
//  EOJNumberCNFormatter.h
//  EOJKit
//
//  Created by Joe on 2023-03-20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 金额中文处理. 目前支持最多16位整数+最多3小数。
/// 整数部分超过16位，不能正确获取到值
/// 小数部分超过3位，将只截取前3位，没有四舍五入
@interface EOJNumberCNFormatter : NSObject

/// 将金额字符串转换为中文传统金额字符串
/// - Parameter aString: 金额字符串
+ (NSString *)cnFinNumStringFromString:(NSString *)aString;


/// 数字字符串
@property(nonatomic,copy)NSString *numString;

/// 中文金额字符串
- (NSString *)getFinCNFormatString;

/// 中文数字分割字符串. 4位分割, 以英文逗号","区分；小数部分不变化
- (NSString *)cnNumFormatString;

/// 中文数字分割字符串. 4位分割, 以英文逗号","区分. 前面有人民币符号标志；小数部分不变化
- (NSString *)cnNumFullFormatString;


@end

NS_ASSUME_NONNULL_END
