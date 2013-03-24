//
//  MyClassUseOften.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-2.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClassUseOften : NSObject
-(NSString *)removeHeadAndTailWhitespaceAndNewlineCharacter:(NSString *)aStr;//移出首空格和尾换行符
-(NSString *)removeStringAllWhitespaceAndNewlineCharacter:(NSString *)aStr; //移出所有空格和换行
-(id)xMlResultDictionaryWithDic:(const NSDictionary *)dic withKey:(const NSString *)keyStr;//字典取值
-(id)XMlResultWithArray:(const NSArray *)aArray withKey:(const NSString *)key;//数组取值
+(MyClassUseOften *)ShareMyClassUseOften;
-(void)showTip:(NSString *)tipInfor withPosition:(CGRect)framePosition withSuperView:(UIView *)fatherView;//提示View
//数据序列化  即归档
-(BOOL)writeResultDataToLibraryPath:(id)resultId withFileName:(NSString *)filename;
-(id)loadResultDataFromLibraryCachesWithFilename:(NSString *)filename;
//lable自适应高度
-(CGRect)LableSizeFitsAdapt:(UILabel *)aLable withFontName:(NSString *)name withFontSize:(CGFloat)width;

@end
