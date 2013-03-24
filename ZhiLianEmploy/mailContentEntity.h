//
//  mailContentEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mailContentEntity : NSObject
@property(nonatomic,retain)NSString * subject;//主题
@property(nonatomic,retain)NSString * date_posted;//接收时间
@property(nonatomic,retain)NSString * company_name;//公司名称
@property(nonatomic,retain)NSString * mail_body;//信件正文

@end
