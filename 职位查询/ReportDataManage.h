//
//  ReportDataManage.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestData.h"
typedef void (^ReportDataBlock)(id result,id result1);
@interface ReportDataManage : NSObject
{
    ReportDataBlock finishBlock;
}

@property(nonatomic,retain)NSMutableDictionary *CityDic;
@property(nonatomic,retain)NSMutableDictionary *resultDic;
@property(nonatomic,retain)NSMutableDictionary *positonDic;
@property(nonatomic,retain)NSMutableDictionary *jobNumberDic;
@property(nonatomic,retain)NSMutableDictionary *CompNameDic;
@property(nonatomic,retain)NSMutableDictionary *CompNumberDic;
@property(nonatomic,retain)NSMutableDictionary *job_titleDic;
@property(nonatomic,retain)NSMutableDictionary *company_short_nameDic;
@property(nonatomic,retain)NSMutableDictionary *city_idDic;
@property(nonatomic,retain)NSMutableArray *Allarr;

-(void)setfinishBlock:(ReportDataBlock)aBlock;

-(void)readDataWithURL:(NSString *)url withHttpMethod:(NSString *)method Params:(NSMutableDictionary *)params;
@end
