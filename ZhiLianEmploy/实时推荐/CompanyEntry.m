//
//  CompanyEntry.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-2.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
//<currentjob>http://wapinterface.zhaopin.co/iphone/job/showjobdetail.aspx
 #import "CompanyEntry.h"
#import "RequestData.h"
#import "MyClassUseOften.h"

@implementation CompanyEntry

-(CompanyEntry *)initWithJob_number:(NSString *)Job_number
{
    self =[super init];
    if (self) {
        self.job_number = Job_number;
        self.resultDictionary = [NSMutableDictionary dictionary];
        self.company = [NSMutableDictionary dictionary];
        self.currentjob = [NSMutableDictionary dictionary];
        self.joblist = [NSMutableArray array];
    }
    return self;
}


-(void)requestData
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.job_number forKey:@"Job_number"];
    
    [dic setObject:@"1" forKey:@"Page"];
    [dic setObject:@"10" forKey:@"Pagesize"];
    RequestData *request = [RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx" withHttpMethod:@"GET" withParams:dic];
    [request setResultData:^(id aid, NSError *error) {
        if (error) {
            NSLog(@"CompanyEntry-requestData-error == %@",[error description]);
        }
        else
        {
           // NSLog(@"%@",aid);
        [self.resultDictionary setDictionary:aid];
        MyClassUseOften *myClass = [[MyClassUseOften alloc]init];
        
        self.company = [myClass xMlResultDictionaryWithDic:aid withKey:@"company"];
        self.currentjob = [myClass xMlResultDictionaryWithDic:aid withKey:@"currentjob"];
        self.joblist = [myClass xMlResultDictionaryWithDic:aid withKey:@"job"];
          //  NSLog(@"%@",self.joblist);

        [self companyAttributeValueWithDic:self.company];
        [self currentjobAttributeValueWithDic:self.currentjob];
            
        [myClass release];
       //self.company_address =
        if (resultWtihObject) {
            resultWtihObject(self);
        }
            
        }
 
    }];
    [request connect];

}
-(void)setresultWtihObject:(resultBlock)block
{
    resultWtihObject = [block copy];

}
-(void)currentjobAttributeValueWithDic:(NSDictionary *)dictionary
{
    ///NSLog(@"currentjob---allKeys ==%@",[dictionary allKeys]);
    
    self.job_city = [self valueWithDIictionary:dictionary withKey:@"job_city"];
    self.job_title = [self valueWithDIictionary:dictionary withKey:@"job_title"];
   // NSLog(@"job_city == %@",self.job_city);
    self.job_latitude = [self valueWithDIictionary:dictionary withKey:@"latitude"];
    self.job_numberPerson = [self valueWithDIictionary:dictionary withKey:@"number"];
    self.job_opening_date = [self valueWithDIictionary:dictionary withKey:@"opening_date"];
    self.job_responsibility = [self valueWithDIictionary:dictionary withKey:@"responsibilty"];
    
    
   // NSLog(@"%@",self.job_responsibility);
    
    self.job_salary_range =[self valueWithDIictionary:dictionary withKey:@"salary_range"];
    self.job_working_exp = [self valueWithDIictionary:dictionary withKey:@"working_exp"];
    self.job_longitude = [self valueWithDIictionary:dictionary withKey:@"longitude"];
  
}
-(void)companyAttributeValueWithDic:(NSDictionary *)dictionary
{
    //NSLog(@"%@",[dictionary allKeys]);
    
    self.company_address =   [self valueWithDIictionary:dictionary withKey:@"address"];
    self.company_company_desc = [self valueWithDIictionary:dictionary withKey:@"company_desc"];
    self.company_industry = [self valueWithDIictionary:dictionary withKey:@"industry"];
    self.company_name = [self valueWithDIictionary:dictionary withKey:@"company_name"];
    self.company_number = [self valueWithDIictionary:dictionary withKey:@"company_number"];
    self.company_size = [self valueWithDIictionary:dictionary withKey:@"company_size"];
    self.company_property = [self valueWithDIictionary:dictionary withKey:@"company_property"];
   
    //<job_title >职位名称</job_title >
   // <opening_date >发布时间</ opening_date >
   // <job_city >职位发布城市</ job_city >
   // <working_exp>经验</ working_exp >
   // <salary_range >月薪</ salary_range >
   // <number>招聘人数</ number >
   // <responsibility >职位描述</ responsibility >
   // <longitude>经度</longitude>
   // <latitude	>纬度</ latitude>


}
-(NSString *)valueWithDIictionary:(NSDictionary *)aDictionary  withKey:(NSString *)key
{
    NSMutableString *str = [NSMutableString string];
    NSArray *keyArray = [aDictionary allKeys];
  //  NSLog(@"keyArray == %@",keyArray);
    if ([keyArray containsObject:key]) {
        [str setString:[[aDictionary objectForKey:key] objectForKey:@"text"]];
    }
    
    return str;
    
}


@end
