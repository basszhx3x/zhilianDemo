//
//  ReportDataManage.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ReportDataManage.h"
#import "ReportData.h"
@implementation ReportDataManage

@synthesize CityDic = _CityDic;
@synthesize resultDic = _resultDic;
@synthesize positonDic = _positonDic;
@synthesize jobNumberDic = _jobNumberDic;
@synthesize CompNameDic = _CompNameDic;
@synthesize CompNumberDic = _CompNumberDic;
@synthesize job_titleDic = _job_titleDic;
@synthesize company_short_nameDic = _company_short_nameDic;



-(id)init
{
    if (self = [super init])
    {
        self.CityDic = [NSMutableDictionary dictionary];
        self.resultDic = [NSMutableDictionary dictionary];
        self.positonDic = [NSMutableDictionary dictionary];
        self.jobNumberDic = [NSMutableDictionary dictionary];
        self.CompNameDic = [NSMutableDictionary dictionary];
        self.CompNumberDic = [NSMutableDictionary dictionary];
        self.job_titleDic = [NSMutableDictionary dictionary];
        self.company_short_nameDic = [NSMutableDictionary dictionary];
        self.city_idDic = [NSMutableDictionary dictionary];
        self.Allarr = [NSMutableArray array];

    }
    return self;
}

-(void)setfinishBlock:(ReportDataBlock)aBlock
{
    finishBlock = aBlock;
}

-(void)readDataWithURL:(NSString *)url withHttpMethod:(NSString *)method Params:(NSMutableDictionary *)params
{
    RequestData *reData = [RequestData requestDataWithURL:url
                                           withHttpMethod:method
                                               withParams:params];
    ReportData *reportDataClass = [[ReportData alloc] init];
    [reData setResultData:^(id aid, NSError *error) 
    {
        if (error)
        {
            NSLog(@"error===%@",[error debugDescription]);
        }

        if ([aid isKindOfClass:[NSMutableDictionary class]])
        {
            NSLog(@"aidd ------------>%@",aid);
            
            self.CityDic = [aid valueForKey:@"root"];
            self.resultDic = [self.CityDic valueForKey:@"joblist"];
            NSLog(@"joblist-------->%@",self.resultDic);
            if ([[self.resultDic objectForKey:@"job"] isKindOfClass:[NSMutableDictionary class]]) 
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                
                self.job_titleDic = [dic valueForKey:@"job_title"];
                reportDataClass.job_titleStr = [self.job_titleDic valueForKey:@"text"];
                self.jobNumberDic = [dic valueForKey:@"job_number"];
                NSLog(@"job_number --->%@",self.jobNumberDic);
                reportDataClass.job_numberStr = [self.jobNumberDic valueForKey:@"text"];
                    
                NSMutableArray * arr1 = [NSMutableArray arrayWithObjects:reportDataClass.job_titleStr , reportDataClass.job_numberStr, nil];
                [self.Allarr addObject:arr1];

            }
            
            else
            {

                NSMutableArray *positionArr = [NSMutableArray array];
                positionArr = [self.resultDic valueForKey:@"job"];
                NSLog(@"positionArr---------->%@",positionArr);
                
                for (NSMutableDictionary *dic in positionArr)
                {
                    self.job_titleDic = [dic valueForKey:@"job_title"];
                    reportDataClass.job_titleStr = [self.job_titleDic valueForKey:@"text"];
                    self.jobNumberDic = [dic valueForKey:@"job_number"];
                    NSLog(@"job_number --->%@",self.jobNumberDic);
                    reportDataClass.job_numberStr = [self.jobNumberDic valueForKey:@"text"];
//                    NSMutableDictionary *d = [NSMutableDictionary dictionary];
//                    d = [dic valueForKey:@"job_number"];
//                    NSString *ds = nil;
//                    ds = [d valueForKey:@"text"];
//                    NSArray *dsarr = [ds componentsSeparatedByString:@" "];
//                    NSString *dsstrs = nil;
//                    dsstrs = [dsarr objectAtIndex:dsarr.count-1];
//                    NSMutableDictionary *JobDic = [NSMutableDictionary dictionary];
//                    [JobDic setObject:dsstrs forKey:@"Job_number"];
//                    [self.DicArr addObject:JobDic];
                    
                    
                    
                    
//                    NSMutableDictionary *dics = [NSMutableDictionary dictionary];
//                    dics = [dic valueForKey:@"city_id"];
//                    NSString *dicStr = [dics valueForKey:@"text"];
//                    
//                    NSMutableDictionary *CompNamedic = [NSMutableDictionary dictionary];
//                    CompNamedic = [dic valueForKey:@"company_name"];
//                    NSString *CompNamedicS = [CompNamedic valueForKey:@"text"];
//                    NSArray *arrx = [CompNamedicS componentsSeparatedByString:@" "];
//                    NSString *CompNamedicStr = [arrx objectAtIndex:arrx.count-1];
//                    
//                    
//                    NSMutableDictionary *CompNumberDic = [NSMutableDictionary dictionary];
//                    CompNumberDic = [dic valueForKey:@"company_number"];
//                    NSString *CompNumberDicS = [CompNumberDic valueForKey:@"text"];
//                    NSArray *arrx1 = [CompNumberDicS componentsSeparatedByString:@" "];
//                    NSString *CompNumberDicStr = [arrx1 objectAtIndex:arrx1.count-1];
//                    
//                    NSMutableDictionary *job_titledic = [NSMutableDictionary dictionary];
//                    job_titledic = [dic valueForKey:@"job_title"];
//                    NSString *job_titledicS = [job_titledic valueForKey:@"text"];
//                    NSArray *arrx2 = [job_titledicS componentsSeparatedByString:@" "];
//                    
//                    NSString *job_titledicStr = [arrx2 objectAtIndex:arrx2.count-1];
//                    
//                    NSMutableDictionary *company_short_namedic = [NSMutableDictionary dictionary];
//                    company_short_namedic = [dic valueForKey:@"company_short_name"];
//                    NSString *company_short_namedicStr = [company_short_namedic valueForKey:@"text"];
//                    
                    NSMutableArray * arr1 = [NSMutableArray arrayWithObjects:reportDataClass.job_titleStr , reportDataClass.job_numberStr, nil];
                    [self.Allarr addObject:arr1];
                    //            company_short_name
                }
                //        NSLog(@"%@",dics);
                
            }
            
            
            
        }
        //    [dic1 isKindOfClass:[NSDictionary class]];
        
        if (finishBlock)
        {
            finishBlock(self.Allarr,@"112");
        }
        NSLog(@"%@",self.Allarr);

        
    }];
    
    [reData connect];
    
}

@end

