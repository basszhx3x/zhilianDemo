//
//  jobSearchEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jobSearchEntity : NSObject
@property(nonatomic,retain)NSString * alert_id;//搜索器编号
@property(nonatomic,retain)NSString * alert_name;//搜索器名称
@property(nonatomic,retain)NSString * send_interval;//邮件发送频率
@property(nonatomic,retain)NSString * today_update_job_count;//今日更新职位数
@end
