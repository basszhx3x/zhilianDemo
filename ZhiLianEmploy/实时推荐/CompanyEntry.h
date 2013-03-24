//
//  CompanyEntry.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-2.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
/*<job_number>职位编号</JobNumber >
 <job_title >职位名称</job_title >
 <opening_date >发布时间</ opening_date >
 <job_city >职位发布城市</ job_city >
 <working_exp>经验</ working_exp >
 <salary_range >月薪</ salary_range >
 <number>招聘人数</ number >
 <responsibility >职位描述</ responsibility >
 <longitude>经度</longitude>
 <latitude	>纬度</ latitude>
 </currentjob>
 <company>
 <company_number>公司编号</company_number>
 <company_name>公司名称</company_name>
 <company_size>公司规模</company_size>
 <company_property>公司性质</company_property>
 <industry>公司所属行业</industry>
 <address>公司地址</address>
 <company_desc>公司描述</company_desc>
 </company>
 <joblist>
 <job>
 <job_number>职位编号</job_number>
 <job_title>职位名称</job_title>
 </job>
 </joblist>
 </root>
 
 */
typedef void(^ resultBlock) (id companyWithResult);

#import <Foundation/Foundation.h>

@interface CompanyEntry : NSObject
{
    resultBlock resultWtihObject;

}
@property(nonatomic,retain)NSMutableDictionary *resultDictionary;

@property(nonatomic,retain)NSMutableDictionary *company;
@property(nonatomic,retain)NSString *company_number;    //公司编号;
@property(nonatomic,retain)NSString *company_name;  //名字
@property(nonatomic,retain)NSString *company_size; //规模
@property(nonatomic,retain)NSString *company_property; //性质
@property(nonatomic,retain)NSString *company_industry; //行业
@property(nonatomic,retain)NSString *company_address; //地址
@property(nonatomic,retain)NSString *company_company_desc; //公司描述
//@property(nonatomic,retain)NSString *company_property;

@property(nonatomic,retain)NSMutableDictionary *currentjob;
@property(nonatomic,retain)NSString *job_number;
@property(nonatomic,retain)NSString *job_title;
@property(nonatomic,retain)NSString *job_city;//职位发布城市
@property(nonatomic,retain)NSString *job_opening_date; //发布时间
@property(nonatomic,retain)NSString *job_working_exp; //经验
@property(nonatomic,retain)NSString *job_salary_range;//月薪
@property(nonatomic,retain)NSString *job_numberPerson;//招聘人数
@property(nonatomic,retain)NSString *job_responsibility;//职位描述
@property(nonatomic,retain)NSString *job_longitude;//经度
@property(nonatomic,retain)NSString *job_latitude;//纬度



@property(nonatomic,retain)NSMutableArray *joblist;
-(void)setresultWtihObject:(resultBlock)block;
-(CompanyEntry *)initWithJob_number:(NSString *)Job_number;
-(void)requestData;
@end
