//
//  ReportJobDataManage.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ReportJobDataManage.h"

@implementation ReportJobDataManage
-(void)readDataWithURL:(NSString *)url Params:(NSMutableDictionary *)params
{
    RequestData *reData = [RequestData requestDataWithURL:url
                                           withHttpMethod:@"GET"
                                               withParams:params];
    [reData setResultData:^(id aid, NSError *error) 
     {
         if (error)
         {
             NSLog(@"error===%@",[error debugDescription]);
         }
         
     }];
}

@end
