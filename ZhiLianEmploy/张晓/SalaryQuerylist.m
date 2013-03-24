//
//  SalaryQuerylist.m
//  ZhiLianEmploy,//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SalaryQuerylist.h"
static SalaryQuerylist *salary = nil;
@implementation SalaryQuerylist

+(SalaryQuerylist *)ShareSalaryQuerylist
{
    
    if (!salary) {
        salary = [[SalaryQuerylist alloc]init];
    }

    return salary;
}


@end
