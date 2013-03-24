//
//  MyClassUseOften.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-2.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MyClassUseOften.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyClassUseOften
-(void)dealloc
{
    [super dealloc];
}
+(MyClassUseOften *)ShareMyClassUseOften
{
    static MyClassUseOften *share = nil;
    if (!share) {
        share =[[MyClassUseOften alloc]init];
    }
    return share;

}
#pragma mark --提示信息view--
-(void)showTip:(NSString *)tipInfor withPosition:(CGRect)framePosition withSuperView:(UIView *)fatherView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:framePosition]; //CGRectMake(160-100, (480-44-20-49)/2-40, 200, 40)屏幕中心
    lable.text = tipInfor;
    lable.layer.borderColor = [UIColor blackColor].CGColor;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor orangeColor];
    lable.layer.borderWidth = 1.0f;
    lable.layer.cornerRadius = 5.0f;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.numberOfLines = 2;
    lable.backgroundColor = [UIColor grayColor];
    [fatherView addSubview:lable];
    [UIView animateWithDuration:2.0 animations:^{
        lable.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [lable removeFromSuperview];
        [lable release];
//        
//        if (isFirstShow) {
//            self.tabBarController.selectedIndex = 1;
//            UIView * view = [ self.tabBarController.view viewWithTag:3000];
//            
//            UIButton * btn1 = [view viewWithTag:1001];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"btn" object:nil userInfo:[NSDictionary dictionaryWithObject:btn1 forKey:@"btn1"]];
//        }
//        
        
        
    }];
    
    
}
#pragma mark --字典或数组根据key取相应的值
-(id)xMlResultDictionaryWithDic:(const NSDictionary *)dic withKey:(const NSString *)keyStr
{
    // NSMutableArray *tmpdic = [NSMutableArray array];
    NSArray *arry = [dic allKeys];
    if ([arry containsObject:keyStr]) {
        
        id tmpID = [dic objectForKey:keyStr];
        return tmpID;
    }
    else
    {
        for (NSString * key in arry) {
            id tmpID = [dic objectForKey:key];
            if ([tmpID isKindOfClass:[NSDictionary class]]) {
                id secId = [self xMlResultDictionaryWithDic:tmpID withKey:keyStr];
                if (secId) {
                    return secId;
                }
            }
            if ([tmpID isKindOfClass:[NSArray class]]) {
                // NSLog(@"%@",tmpID);
                id secId = [self XMlResultWithArray:tmpID withKey:keyStr];
                if (secId) {
                    return  secId;
                    
                }
            }
        }
    }
    return nil;
    
}
-(id)XMlResultWithArray:(const NSArray *)aArray withKey:(const NSString *)key
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (id aID in aArray) {
        // NSLog(@"%@",aID);
        if ([aID isKindOfClass:[NSString class]]) {
            return nil;
            
        }
        if ([aID isKindOfClass:[NSDictionary class]]) {
            id secId = [self xMlResultDictionaryWithDic:aID withKey:key];
            if (secId) {
                [tmpArray addObject:secId];
            }
            
            // [tmpArray addObject:[self xMlResultDictionaryWithDic:aID withKey:key]];
        }
        if ([aID isKindOfClass:[NSArray class]]) {
            id secID = [self XMlResultWithArray:aID withKey:key];
            if ([(NSArray *)secID count] != 0) {
                return secID;
            }
        }
    }
    if (tmpArray .count != 0) {
        return tmpArray;
    }
    return nil;
}

#pragma mark --移除字符串首和尾的空格或回车--
-(NSString *)removeHeadAndTailWhitespaceAndNewlineCharacter:(NSString *)aStr
{
    NSMutableString *str = [NSMutableString string];
    [str setString:aStr];
    [str setString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return str;
}
-(NSString *)removeStringAllWhitespaceAndNewlineCharacter:(NSString *)aStr
{
    NSString *string = [self removeHeadAndTailWhitespaceAndNewlineCharacter:aStr];
    NSMutableString *str = [NSMutableString string];
    [str setString:string];
    NSArray *strArray = [string componentsSeparatedByString:@" "];
   // NSLog(@"%@",strArray);
    NSMutableArray *str2Array = [NSMutableArray array];
    for (NSString *str  in strArray) {
        if (str.length != 0) {
            [str2Array addObject:[self removeHeadAndTailWhitespaceAndNewlineCharacter:str]];
        }
    }
    NSString *target = [str2Array componentsJoinedByString:@""];
    
   // NSLog(@"%@",target);
    return target;

}
#pragma mark --序列化数据--
-(BOOL)writeResultDataToLibraryPath:(id)resultId withFileName:(NSString *)filename
{
    BOOL resutl = NO;
    NSString *homePath = NSHomeDirectory();
    NSString *targetPath = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",filename]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:targetPath]) {
        [fileManager createFileAtPath:targetPath contents:nil attributes:nil];
    }
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:resultId forKey:filename];
    [archiver finishEncoding];
    resutl = [data writeToFile:targetPath atomically:YES];
    [archiver release];
    
    return resutl;
  
}
-(id)loadResultDataFromLibraryCachesWithFilename:(NSString *)filename
{
    NSString *homePath = NSHomeDirectory();
    NSString *targetPath = [homePath stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@",filename]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:targetPath]) {
         NSLog(@"不存在名称为%@该数据文件",filename);
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:targetPath];
    NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc]initForReadingWithData:data]autorelease];
    id resultObject = [unarchiver decodeObjectForKey:filename];
    
    [unarchiver finishDecoding];
    return resultObject;
}

-(CGRect)LableSizeFitsAdapt:(UILabel *)aLable withFontName:(NSString *)name withFontSize:(CGFloat)width
{
    aLable.numberOfLines=0;
    aLable.font = [UIFont fontWithName:name size:width];
    CGSize size = [aLable sizeThatFits:CGSizeMake(aLable.frame.size.width, 0)];
    [aLable.text sizeWithFont:[UIFont fontWithName:name size:width] constrainedToSize:size];
    aLable.lineBreakMode=NSLineBreakByWordWrapping;
    
    CGRect rect = aLable.frame;
    rect.size.height = size.height;
    return rect;
}

@end
