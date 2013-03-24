//
//  JobApplyRecord.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobApplyRecord : NSObject
@property(nonatomic,retain)NSString * job_number;//职位编号
@property(nonatomic,retain)NSString * job_title;//职位名称
@property(nonatomic,retain)NSString * job_city;//职位发布城市
@property(nonatomic,retain)NSString * company_number;//公司编号
@property(nonatomic,retain)NSString * company_name;//公司名称
@property(nonatomic,retain)NSString * date_applied;//申请日期
@property(nonatomic,retain)NSString * applied_count;//已申请人数

@end
