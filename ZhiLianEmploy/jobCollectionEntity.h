//
//  jobCollectionEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jobCollectionEntity : NSObject
@property(nonatomic,retain)NSString *job_number;
@property(nonatomic,retain)NSString *job_title;
@property(nonatomic,retain)NSString *job_city;
@property(nonatomic,retain)NSString *applied_count;//已申请人数
@property(nonatomic,retain)NSString *company_number;
@property(nonatomic,retain)NSString *company_name;
@property(nonatomic,retain)NSString *jobstatus;//职位状态

@end
