//
//  scanResumeCompanyInfoEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-1.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface scanResumeCompanyInfoEntity : NSObject
@property(nonatomic,retain)NSString *company_number;//公司编号
@property(nonatomic,retain)NSString *company_name;//公司名称
@property(nonatomic,retain)NSString *company_size;//公司规模
@property(nonatomic,retain)NSString *company_property;//公司性质
@property(nonatomic,retain)NSString *industry;//公司所属行业
@property(nonatomic,retain)NSString *address;//公司地址
@property(nonatomic,retain)NSString *company_desc;//公司描述

@property(nonatomic,retain)NSString *job_number;//职位编号
@property(nonatomic,retain)NSString *job_title;//职位名称
@end
