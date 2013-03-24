//
//  Positionlist.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Positionlist : NSObject

@property(nonatomic,retain)NSString *position;
@property(nonatomic,retain)NSString *job_title;
@property(nonatomic,retain)NSString *job_city;
@property(nonatomic,retain)NSString *job_city_region;
@property(nonatomic,retain)NSString *company_number;
@property(nonatomic,retain)NSString *company_name;
@property(nonatomic,retain)NSString *post_ratio;
@property(nonatomic,retain)NSString *applyjob_jobtitle;

@property(nonatomic,retain)NSArray *applyjob_jobtitles;
@property(nonatomic,retain)NSMutableArray *positions;
//@property(nonatomic,retain)NSArray *applyjob_jobtitles;
//@property(nonatomic,retain)NSArray *applyjob_jobtitles;
//@property(nonatomic,retain)NSArray *applyjob_jobtitles;


@end
