//
//  BaseData.h
//  ZhiLianJYL
//
//  Created by Aaron on 13-2-19.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseData : NSObject
{
   
}
+(id)getInstance;
//获取职位名称
-(NSMutableArray *)getPositionName;
//获取职位
-(NSMutableArray *)getPosition;
//获取工作地点
-(NSMutableArray *)getPositionWork;
//获取地区
-(NSMutableArray *)getArea;
//获取城市
-(NSMutableArray *)getCity;
//获取行业类别
-(NSMutableArray *)getIndustryCategory;
//获取发布时间
-(NSMutableArray *)getPublishDate;
//获取工作经验
-(NSMutableArray *)getWorkExperience;
//获取学历要求
-(NSMutableArray *)getEducationBackground;
//获取公司性质
-(NSMutableArray *)getCompanyType;
//获取公司规模
-(NSMutableArray *)getCompanySize;
//获取月薪范围
-(NSMutableArray *)getSalary;
//获取定为范围
-(NSMutableArray *)getMap_range;

@end
