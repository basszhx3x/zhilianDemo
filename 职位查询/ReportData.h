//
//  ReportData.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportData : NSObject


@property(nonatomic,copy)NSMutableDictionary *CityDic;
@property(nonatomic,copy)NSMutableDictionary *resultDic;
@property(nonatomic,copy)NSMutableDictionary *positonDic;
@property(nonatomic,copy)NSMutableDictionary *jobNumberDic;
@property(nonatomic,copy)NSMutableDictionary *CompNameDic;
@property(nonatomic,copy)NSMutableDictionary *CompNumberDic;
@property(nonatomic,copy)NSMutableString *job_titleStr;
@property(nonatomic,copy)NSMutableString *job_numberStr;

//-(id)init;



@end
