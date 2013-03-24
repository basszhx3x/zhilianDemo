//
//  getLastestJobEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getLastestJobEntity : NSObject
@property(nonatomic,retain)NSString * job_number;//职位编号
@property(nonatomic,retain)NSString * job_title;//职位名称
@property(nonatomic,retain)NSString * opening_date;//发布时间
@property(nonatomic,retain)NSString * job_city;//职位发布城市
@property(nonatomic,retain)NSString * job_city_region;//职位发布城市
@property(nonatomic,retain)NSString * company_number;//公司编号
@property(nonatomic,retain)NSString * company_name;//公司名称
@property(nonatomic,retain)NSString * important;//是否重要

@end
