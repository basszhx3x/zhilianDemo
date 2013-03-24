//
//  ZhiLianManager.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ZhiLianManager.h"
#import "RequestData.h"
#import "loginReturnInfoEntity.h"
#import "jobSearchEntity.h"
#import "getLastestJobEntity.h"
#import "JobApplyRecord.h"
#import "jobCollectionEntity.h"
#import "managerOfferEntity.h"
#import "mailContentEntity.h"
#import "scanResumeCompanyListEntity.h"
#import "jobIntroduceAndCompanyIntroduceEntity.h"

@implementation ZhiLianManager

-(void)setfinishBlock:(ZhiLianBlock)aBlock
{
    finishBlock=[aBlock copy];

}

//登陆智联招聘反馈接口（我的智联-用户登录接口规范）
-(void)loginReturnInforequestDataWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    //网络请求，登陆更新页面数据

    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        NSDictionary * dic1=[aid valueForKey:@"root"];
        
       // NSLog(@"%@",[dic1 objectForKey:@"result"]);
       // NSLog(@"%@",[[dic1 objectForKey:@"result"] objectForKey:@"text"]);
       // NSLog(@"%@",[[dic1 objectForKey:@"result"] objectForKey:@"text"]);
        if ([[dic1 objectForKey:@"uticket"] objectForKey:@"text"]!=nil)
        {
            [arr2 addObject:[[dic1 objectForKey:@"uticket"] objectForKey:@"text"]];
            NSNotificationCenter * center=[NSNotificationCenter defaultCenter];
            //第三页
            [center postNotificationName:@"utiket" object:nil userInfo:[NSDictionary dictionaryWithObject:[[dic1 objectForKey:@"uticket"] objectForKey:@"text"] forKey:@"uticket"] ];
        }
        
        //对空格和回车进行处理
        NSString * str=[[dic1 objectForKey:@"result"] objectForKey:@"text"];
        NSArray * seperateArr=[str componentsSeparatedByString:@" "];
        if ([[seperateArr objectAtIndex:([seperateArr count]-1)] integerValue]==1)
        {
            //NSLog(@"%@",[dic1 objectForKey:@"resumelist"]);
            if ([[dic1 objectForKey:@"resumelist"] objectForKey:@"resume"]==nil) {
                [arr addObject:@""];
            }
            else
            {
                
                id aId = [[dic1 objectForKey:@"resumelist"] objectForKey:@"resume"];
                if ([aId isKindOfClass:[NSDictionary class]]) {
                    
               
                    NSDictionary * dic = aId ;
               
                    loginReturnInfoEntity * login=[[loginReturnInfoEntity alloc] init];

                    login.resume_id=[[dic objectForKey:@"resume_id"] objectForKey:@"text"];

                    login.resume_number=[[dic objectForKey:@"resume_number"] objectForKey:@"text"];
                    login.version_number=[[dic objectForKey:@"version_number"] objectForKey:@"text"];
                    login.resume_name=[[dic objectForKey:@"resume_name"] objectForKey:@"text"];
                    login.isdefaultflag=[[dic objectForKey:@"isdefaultflag"] objectForKey:@"text"];
                    login.show_count=[[dic objectForKey:@"show_count"] objectForKey:@"text"];
                
                    [arr addObject:login];
                    
                   }
            if ([aId isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dic  in aId) {
                    
                    
                    loginReturnInfoEntity * login=[[loginReturnInfoEntity alloc] init];
                    
                    login.resume_id=[[dic objectForKey:@"resume_id"] objectForKey:@"text"];
                    
                    login.resume_number=[[dic objectForKey:@"resume_number"] objectForKey:@"text"];
                    login.version_number=[[dic objectForKey:@"version_number"] objectForKey:@"text"];
                    login.resume_name=[[dic objectForKey:@"resume_name"] objectForKey:@"text"];
                    login.isdefaultflag=[[dic objectForKey:@"isdefaultflag"] objectForKey:@"text"];
                    login.show_count=[[dic objectForKey:@"show_count"] objectForKey:@"text"];
                    
                    [arr addObject:login];

                    
                }
            
            }
                

            }
            
            loginReturnInfoEntity * login=[[loginReturnInfoEntity alloc] init];
            login.result=[[dic1 objectForKey:@"result"]  objectForKey:@"text"];
            [arr1 addObject:login.result];
            login.no_read_hr_email_count=[[dic1 objectForKey:@"no_read_hr_email_count"]  objectForKey:@"text"];
            [arr1 addObject:login.no_read_hr_email_count];
            login.apply_count=[[dic1 objectForKey:@"apply_count"] objectForKey:@"text"];
            [arr1 addObject:login.apply_count];
            login.fav_count=[[dic1 objectForKey:@"fav_count"]  objectForKey:@"text"];
            [arr1 addObject:login.fav_count];
            login.job_searcher_count=[[dic1 objectForKey:@"job_searcher_count"]  objectForKey:@"text"];
            [arr1 addObject:login.job_searcher_count];
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }

        }
        
        else
        {   
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            return ;
        }
            }];
    
    [request connect];
}

-(void)jobSearchWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    //网络请求，登陆更新页面数据
    
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"jobalertlist"];
        NSLog(@"%@",[dic objectForKey:@"alert"]);
        if ([[dic objectForKey:@"alert"] count]>=1&&[[dic objectForKey:@"alert"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"alert"];
            for (NSDictionary * dic1 in seachor) {
                jobSearchEntity * data=[[jobSearchEntity alloc] init];
                NSLog(@"%@",[dic1 objectForKey:@"alert_id"]);
                data.alert_id=[[dic1 objectForKey:@"alert_id"] objectForKey:@"text"];
                data.alert_name=[[dic1 objectForKey:@"alert_name"] objectForKey:@"text"];
                data.send_interval=[[dic1 objectForKey:@"send_interval"] objectForKey:@"text"];
                data.today_update_job_count=[[dic1 objectForKey:@"today_update_job_count"] objectForKey:@"text"];
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                return ;
                
            }

            }
        
        if ([[dic objectForKey:@"alert"] count]>=1&&[[dic objectForKey:@"alert"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * seachor=[dic objectForKey:@"alert"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {       jobSearchEntity * data=[[jobSearchEntity alloc] init];
                NSLog(@"%@",[seachor objectForKey:@"alert_id"]);
                data.alert_id=[[seachor objectForKey:@"alert_id"] objectForKey:@"text"];
                data.alert_name=[[seachor objectForKey:@"alert_name"] objectForKey:@"text"];
                data.send_interval=[[seachor objectForKey:@"send_interval"] objectForKey:@"text"];
                data.today_update_job_count=[[seachor objectForKey:@"today_update_job_count"] objectForKey:@"text"];
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                return ;
                
            }

        }
        
        
    }];
    [request connect];
}

//获取今日最新职位表
-(void)getLastestJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary *)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"joblist"];
        if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"job"];
            for (NSDictionary * dic1 in seachor) {
                getLastestJobEntity * data=[[getLastestJobEntity alloc] init];
                data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[dic1 objectForKey:@"company_number"] objectForKey:@"text"];
                data.important=[[dic1 objectForKey:@"important"] objectForKey:@"text"];
                data.job_city=[[dic1 objectForKey:@"job_city"] objectForKey:@"text"];
                data.job_city_region=[[dic1 objectForKey:@"job_city_region"] objectForKey:@"text"];
                data.job_number=[[dic1 objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[dic1 objectForKey:@"job_title"] objectForKey:@"text"];
                data.opening_date=[[dic1 objectForKey:@"opening_date"] objectForKey:@"text"];
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                return ;
                
            }
            
        }
        
         if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary * seachor=[dic objectForKey:@"job"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {       getLastestJobEntity * data=[[getLastestJobEntity alloc] init];
                data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[seachor objectForKey:@"company_number"] objectForKey:@"text"];
                data.important=[[seachor objectForKey:@"important"] objectForKey:@"text"];
                data.job_city=[[seachor objectForKey:@"job_city"] objectForKey:@"text"];
                data.job_city_region=[[seachor objectForKey:@"job_city_region"] objectForKey:@"text"];
                data.job_number=[[seachor objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[seachor objectForKey:@"job_title"] objectForKey:@"text"];
                data.opening_date=[[seachor objectForKey:@"opening_date"] objectForKey:@"text"];
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                return ;
                
            }}
        
    }];
    [request connect];



}

-(void)JobApplyRecordJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"applylist"];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"apply"] count]>1&&[[dic objectForKey:@"apply"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"apply"];
            for (NSDictionary * dic1 in seachor) {
                JobApplyRecord * data=[[JobApplyRecord alloc] init];
                data.applied_count=[[dic1 objectForKey:@"applied_count"] objectForKey:@"text"];
                data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[dic1 objectForKey:@"company_number"] objectForKey:@"text"];
                data.date_applied=[[dic1 objectForKey:@"date_applied"] objectForKey:@"text"];
                data.job_city=[[dic1 objectForKey:@"job_city"] objectForKey:@"text"];
                data.job_number=[[dic1 objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[dic1 objectForKey:@"job_title"] objectForKey:@"text"];
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }
            
        }
        
        if ([[dic objectForKey:@"apply"] count]>1&&[[dic objectForKey:@"apply"] isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary * seachor=[dic objectForKey:@"apply"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {       JobApplyRecord * data=[[JobApplyRecord alloc] init];
                data.applied_count=[[seachor objectForKey:@"applied_count"] objectForKey:@"text"];
                data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[seachor objectForKey:@"company_number"] objectForKey:@"text"];
                data.date_applied=[[seachor objectForKey:@"date_applied"] objectForKey:@"text"];
                data.job_city=[[seachor objectForKey:@"job_city"] objectForKey:@"text"];
                data.job_number=[[seachor objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[seachor objectForKey:@"job_title"] objectForKey:@"text"];

                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }}
        
    }];
    [request connect];
    


}

-(void)FavorJobWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"joblist"];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"job"];
            for (NSDictionary * dic1 in seachor) {
                jobCollectionEntity * data=[[jobCollectionEntity alloc] init];
                data.job_number=[[dic1 objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[dic1 objectForKey:@"job_title"] objectForKey:@"text"];
                data.job_city=[[dic1 objectForKey:@"job_city"] objectForKey:@"text"];
                data.applied_count=[[dic1 objectForKey:@"applied_count"] objectForKey:@"text"];
                data.job_city=[[dic1 objectForKey:@"job_city"] objectForKey:@"text"];
                data.company_number=[[dic1 objectForKey:@"company_number"] objectForKey:@"text"];
                data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
                data.jobstatus=[[dic1 objectForKey:@"jobstatus"] objectForKey:@"text"];
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }
            
        }
        
        if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary * seachor=[dic objectForKey:@"job"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {       jobCollectionEntity * data=[[jobCollectionEntity alloc] init];
                data.job_number=[[seachor objectForKey:@"job_number"] objectForKey:@"text"];
                data.job_title=[[seachor objectForKey:@"job_title"] objectForKey:@"text"];
                data.job_city=[[seachor objectForKey:@"job_city"] objectForKey:@"text"];
                data.applied_count=[[seachor objectForKey:@"applied_count"] objectForKey:@"text"];
                data.job_city=[[seachor objectForKey:@"job_city"] objectForKey:@"text"];
                data.company_number=[[seachor objectForKey:@"company_number"] objectForKey:@"text"];
                data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
                data.jobstatus=[[seachor objectForKey:@"jobstatus"] objectForKey:@"text"];
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }}
        
    }];
    [request connect];
}


-(void)managerOfferWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"emaillist"];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"email"] count]>1&&[[dic objectForKey:@"email"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"email"];
            for (NSDictionary * dic1 in seachor) {
                managerOfferEntity * data=[[managerOfferEntity alloc] init];
                data.subject=[[dic1 objectForKey:@"subject"] objectForKey:@"text"];
                data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
                data.date_posted=[[dic1 objectForKey:@"date_posted"] objectForKey:@"text"];
                data.email_number=[[dic1 objectForKey:@"email_number"] objectForKey:@"text"];
                data.is_read=[[dic1 objectForKey:@"is_read"] objectForKey:@"text"];
             
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }
            
        }
        
        if ([[dic objectForKey:@"email"] count]>1&&[[dic objectForKey:@"email"] isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary * seachor=[dic objectForKey:@"email"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {  
                managerOfferEntity * data=[[managerOfferEntity alloc] init];
                data.subject=[[seachor objectForKey:@"subject"] objectForKey:@"text"];
                data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
                data.date_posted=[[seachor objectForKey:@"date_posted"] objectForKey:@"text"];
                data.email_number=[[seachor objectForKey:@"email_number"] objectForKey:@"text"];
                data.is_read=[[seachor objectForKey:@"is_read"] objectForKey:@"text"];
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }}
        
    }];
    [request connect];

}

-(void)getMailContentWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"mail"];
        NSLog(@"%@",dic);
        NSDictionary * seachor=dic;
        NSLog(@"%@",seachor);
        if ([seachor  count]>=1)
        {
            mailContentEntity * data=[[mailContentEntity alloc] init];
            data.subject=[[seachor objectForKey:@"subject"] objectForKey:@"text"];
            data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
            data.date_posted=[[seachor objectForKey:@"date_posted"] objectForKey:@"text"];
            data.mail_body=[[seachor objectForKey:@"mail_body"] objectForKey:@"text"];
            [arr addObject:data];
            
        }
        
        if (finishBlock) {
            finishBlock(arr,arr1,arr2);
        }
        else
        {
            NSLog(@"请求出错") ;
            
        }
        
    }];
    [request connect];
}

-(void)getScanResumeCompanyListWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"joblist"];
        
        if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSArray class]]) {
            NSArray * seachor=[dic objectForKey:@"job"];
            for (NSDictionary * dic1 in seachor) {
               
                scanResumeCompanyListEntity * data=[[scanResumeCompanyListEntity alloc] init];
                data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[dic1 objectForKey:@"company_number"] objectForKey:@"text"];
                data.company_size=[[dic1 objectForKey:@"company_size"] objectForKey:@"text"];
                data.date_show=[[dic1 objectForKey:@"date_show"] objectForKey:@"text"];
                
                
                
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }
            
        }
        
        if ([[dic objectForKey:@"job"] count]>1&&[[dic objectForKey:@"job"] isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary * seachor=[dic objectForKey:@"job"];
            NSLog(@"%@",seachor);
            if ([seachor  count]>=1)
            {
                
                scanResumeCompanyListEntity * data=[[scanResumeCompanyListEntity alloc] init];
                data.company_name=[[seachor objectForKey:@"company_name"] objectForKey:@"text"];
                data.company_number=[[seachor objectForKey:@"company_number"] objectForKey:@"text"];
                data.company_size=[[seachor objectForKey:@"company_size"] objectForKey:@"text"];
                data.date_show=[[seachor objectForKey:@"date_show"] objectForKey:@"text"];
                [arr addObject:data];
                
            }
            
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }}
        
    }];
    [request connect];
   
}


-(void)getScanResumeCompanyInfoWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{

}



-(void)getJobApplyDetailInfoWithURL:(NSString *)aUrl withHttpMethod:(NSString *)aHttpMethod withParams:(NSMutableDictionary*)aParams
{
    RequestData * request=[RequestData requestDataWithURL:aUrl withHttpMethod:aHttpMethod withParams:aParams];
    [request setResultData:^(id aid, NSError *error) {
        NSLog(@"%@",aid);
        //进行数据分析和处理，提取有用信息
        NSMutableArray * arr=[NSMutableArray array];
        NSMutableArray * arr1=[NSMutableArray array];
        NSMutableArray * arr2=[NSMutableArray array];
        
        //如果返回一个搜索器，就是一个字典，如果返回两个搜索器就是一个数组
        NSDictionary * dic=[[aid objectForKey:@"root"] objectForKey:@"currentjob"];
        NSLog(@"%@",dic);
        NSDictionary * dic1=[[aid objectForKey:@"root"] objectForKey:@"company"];
//        NSString * dic2=[[[aid objectForKey:@"root"] objectForKey:@"joblist"] objectForKey:@"job"];

        
        jobIntroduceAndCompanyIntroduceEntity * data=[[jobIntroduceAndCompanyIntroduceEntity alloc] init];
        data.job_number=[[dic objectForKey:@"job_number"] objectForKey:@"text"];
        data.job_title=[[dic objectForKey:@"job_title"] objectForKey:@"text"];
        data.opening_date=[[dic objectForKey:@"opening_date"] objectForKey:@"text"];
        data.job_city=[[dic objectForKey:@"job_city"] objectForKey:@"text"];
        data.working_exp=[[dic objectForKey:@"working_exp"] objectForKey:@"text"];
        data.salary_range=[[dic objectForKey:@"salary_range"] objectForKey:@"text"];
        data.number=[[dic objectForKey:@"number"] objectForKey:@"text"];
        data.responsibility=[[dic objectForKey:@"responsibilty"] objectForKey:@"text"];
         data.longitude=[[dic objectForKey:@"longitude"] objectForKey:@"text"];
         data.latitude=[[dic objectForKey:@"latitude"] objectForKey:@"text"];
        
        
         data.company_number=[[dic1 objectForKey:@"company_number"] objectForKey:@"text"];
         data.company_name=[[dic1 objectForKey:@"company_name"] objectForKey:@"text"];
         data.company_size=[[dic1 objectForKey:@"company_size"] objectForKey:@"text"];
         data.company_property=[[dic1 objectForKey:@"company_property"] objectForKey:@"text"];
         data.industry=[[dic1 objectForKey:@"industry"] objectForKey:@"text"];
         data.address=[[dic1 objectForKey:@"address"] objectForKey:@"text"];
         data.company_desc=[[dic1 objectForKey:@"company_desc"] objectForKey:@"text"];
        
        
//         data.job_number1=[[dic2 objectForKey:@"job_number"] objectForKey:@"text"];
//         data.job_title1=[[dic2 objectForKey:@"job_title"] objectForKey:@"text"];
        
                
                
        [arr addObject:data];
                

        
            if (finishBlock) {
                finishBlock(arr,arr1,arr2);
            }
            else
            {
                NSLog(@"请求出错") ;
                
            }
            
        }];
    [request connect];
}

@end
