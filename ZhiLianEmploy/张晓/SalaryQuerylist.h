//
//  SalaryQuerylist.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalaryQuerylist : NSObject

@property(nonatomic,retain)NSArray *citys;
@property(nonatomic,retain)NSArray *corpproperty;//企业性质

@property(nonatomic,retain)NSArray *industry;//行业
@property(nonatomic,retain)NSArray *jobcat;//职位类别
@property(nonatomic,retain)NSArray *joblevel;//职位级别
@property(nonatomic,retain)NSArray *education;//教育程度

@property(nonatomic,retain)NSString *cityid;
@property(nonatomic,retain)NSString *industryid;
@property(nonatomic,retain)NSString *corppropertyid;
@property(nonatomic,retain)NSString *jobcatid;
@property(nonatomic,retain)NSString *salary;
@property(nonatomic,retain)NSString *joblevelid;
//@property(nonatomic,retain)NSString *cityid;
//@"cityid",@"industryid",@"corppropertyid",@"jobcatid",@"salary"


+(SalaryQuerylist *)ShareSalaryQuerylist;
@end
