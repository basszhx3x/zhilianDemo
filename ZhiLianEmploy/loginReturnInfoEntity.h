//
//  loginReturnInfoEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginReturnInfoEntity : NSObject
@property(nonatomic,retain)NSString * result;//搜索出来的结果数
@property(nonatomic,retain)NSString * resume_id;//简历ID
@property(nonatomic,retain)NSString * resume_number;//简历编号
@property(nonatomic,retain)NSString * version_number;//简历版本号
@property(nonatomic,retain)NSString * resume_name;//简历名称
@property(nonatomic,retain)NSString * isdefaultflag;//默认简历语言
@property(nonatomic,retain)NSString * show_count;//浏览数
@property(nonatomic,retain)NSString * no_read_hr_email_count;//未读人事来信数
@property(nonatomic,retain)NSString * apply_count;//职位申请数
@property(nonatomic,retain)NSString * fav_count;//职位收藏数
@property(nonatomic,retain)NSString * job_searcher_count;//搜索订阅器数量
@end
