# EOJCNFormatter

#### 介绍
金额的中文格式显示

#### 使用说明
1. 显示为中文传统金额描述格式
```
// @"432" -> @"肆佰叁拾贰元整"
NSString *result = [EOJNumberCNFormatter cnFinNumStringFromString:@"432"];

// @"7000000003002001" -> @"柒仟萬亿零叁佰萬贰仟零壹元整"
[EOJNumberCNFormatter cnFinNumStringFromString:@"7000000003002001"];

// @"5000.0041" -> @"伍仟元零肆厘"
EOJNumberCNFormatter *formatter = [[EOJNumberCNFormatter alloc] init];
formatter.numString = @"5000.0041";
NSString *result = [formatter getFinCNFormatString];

```

2. 按中文习惯分割显示数字字符串
```
EOJNumberCNFormatter *formatter = [[EOJNumberCNFormatter alloc] init];

// @"0.001" -> @"0.001"
formatter.numString = @"0.001";
NSString *result = [formatter cnNumFormatString];

// @"100.20" -> @"100.20"
formatter.numString = @"100.20";
NSString *result = [formatter cnNumFormatString];

// @"1000" -> @"1000"
formatter.numString = @"1000";
NSString *result = [formatter cnNumFormatString];

// @"1000000" -> @"100,0000"
formatter.numString = @"100,0000";
NSString *result = [formatter cnNumFormatString];
```

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request
