//
//  BaseData.m
//  ZhiLianJYL
//
//  Created by Aaron on 13-2-19.
//  Copyright (c) 2013年 Aaron. All rights reserved.
//

#import "BaseData.h"
#import "XMLReader.h"

static id baseData=nil;
static NSDictionary *dict;
@implementation BaseData
+(id)getInstance
{
    if (baseData==nil) {
        baseData=[[self alloc] init];
        
    }
    NSString *path=[[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"];
    NSData *dataxml=[NSData dataWithContentsOfFile:path];
    NSError *error=[[[NSError alloc] init] autorelease];
    dict=[XMLReader dictionaryForXMLData:dataxml error:&error];

    
    return baseData;
}

-(NSMutableArray *)getPositionName
{
    
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *jobtype=[basedata valueForKey:@"jobtype"];
    NSArray *itemArr=[jobtype valueForKey:@"item"];
    NSMutableArray *positionNameArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [positionNameArr addObject:item];
    }

    return positionNameArr;

}
-(NSMutableArray *)getPosition
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *small_Job_type=[basedata valueForKey:@"small_Job_type"];
    NSArray *itemArr=[small_Job_type valueForKey:@"item"];
    
    NSMutableArray *positionNameArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"],[itemDic valueForKey:@"categoryid"], nil];
        [positionNameArr addObject:item];
    }
    return positionNameArr;
}


-(NSMutableArray *)getPositionWork
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *city=[basedata valueForKey:@"city"];
    NSDictionary *firstLevel=[city valueForKey:@"firstLevel"];
    NSArray *itemArr=[firstLevel valueForKey:@"item"];

    NSMutableArray *positionWorkArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [positionWorkArr addObject:item];
    }
    
 
    return positionWorkArr;
    
    
}

-(NSMutableArray *)getArea
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *city=[basedata valueForKey:@"city"];
    NSDictionary *secondLevel=[city valueForKey:@"firstLevel"];
    NSArray *itemArr=[secondLevel valueForKey:@"item"];
    NSLog(@"%@",itemArr);
    NSMutableArray *areaArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"],[itemDic valueForKey:@"parent"], nil];
        [areaArr addObject:item];
    }
    NSLog(@"%@",areaArr);
    return areaArr;
}

-(NSMutableArray *)getCity
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *city=[basedata valueForKey:@"city"];
    NSDictionary *secondLevel=[city valueForKey:@"secondLevel"];
    NSArray *itemArr=[secondLevel valueForKey:@"item"];
    NSLog(@"%@",itemArr);
    
    NSMutableArray *cityArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"],[itemDic valueForKey:@"parent"], nil];
        [cityArr addObject:item];
    }
    

    return cityArr;

}

-(NSMutableArray *)getIndustryCategory
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *industry=[basedata valueForKey:@"industry"];
    NSArray *itemArr=[industry valueForKey:@"item"];
    
    NSMutableArray *industryArr=[NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [industryArr addObject:item];
    }
    return industryArr;
    
}

-(NSMutableArray *)getPublishDate
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *publishDate=[basedata valueForKey:@"publishDate"];
    NSArray *itemArr=[publishDate valueForKey:@"item"];
    
    NSMutableArray *publishDataArr = [NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [publishDataArr addObject:item];
    }

    return publishDataArr;
    
}
-(NSMutableArray *)getWorkExperience
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *workExperience=[basedata valueForKey:@"workEXP"];
    NSArray *itemArr=[workExperience valueForKey:@"item"];
    
    NSMutableArray *workExperienceArr = [NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [workExperienceArr addObject:item];
    }

    return workExperienceArr;
    
}
-(NSMutableArray *)getEducationBackground
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *educationBackground=[basedata valueForKey:@"education"];
    NSArray *itemArr=[educationBackground valueForKey:@"item"];
    
    NSMutableArray *educationBackgroundArr = [NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],
                       [itemDic valueForKey:@"text"],nil];
        [educationBackgroundArr addObject:item];
    }

    return educationBackgroundArr;
    
}
-(NSMutableArray *)getCompanyType
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata = [root valueForKey:@"basedata"];
    NSDictionary *companyType=[basedata valueForKey:@"comptype"];
    NSArray *itemArr=[companyType valueForKey:@"item"];
    
    NSMutableArray *CompanyTypeArr = [NSMutableArray arrayWithCapacity:100];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],
                       [itemDic valueForKey:@"text"],nil];
        [CompanyTypeArr addObject:item];
    }

    return CompanyTypeArr;
    
}
-(NSMutableArray *)getCompanySize
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *companySize=[basedata valueForKey:@"compsize"];
    NSArray *itemArr=[companySize valueForKey:@"item"];
    
    NSMutableArray *companySizeArr = [NSMutableArray arrayWithCapacity:7];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"],nil];
        [companySizeArr addObject:item];
    }
      return companySizeArr;
    
}
-(NSMutableArray *)getSalary
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *salary=[basedata valueForKey:@"salary"];
    NSArray *itemArr=[salary valueForKey:@"item"];
    
    NSMutableArray *salaryArr = [NSMutableArray arrayWithCapacity:11];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [salaryArr addObject:item];
    }
    
    return salaryArr;
}
-(NSMutableArray *)getMap_range
{
    NSDictionary *root=[dict valueForKey:@"root"];
    NSDictionary *basedata=[root valueForKey:@"basedata"];
    NSDictionary *map_range=[basedata valueForKey:@"map_range"];
    NSArray *itemArr=[map_range valueForKey:@"item"];
    
    NSMutableArray *map_rangeArr = [NSMutableArray arrayWithCapacity:3];
    for (NSDictionary *itemDic in itemArr) {
        NSArray *item=[NSArray arrayWithObjects:[itemDic valueForKey:@"code"],[itemDic valueForKey:@"text"], nil];
        [map_rangeArr addObject:item];
    }
    
    return map_rangeArr;
}
@end
