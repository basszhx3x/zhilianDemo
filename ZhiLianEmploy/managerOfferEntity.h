//
//  managerOfferEntity.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface managerOfferEntity : NSObject
@property(nonatomic,retain)NSString * subject;//信件主题
@property(nonatomic,retain)NSString * company_name;//公司名称
@property(nonatomic,retain)NSString * date_posted;//接收时间
@property(nonatomic,retain)NSString * email_number;//信件编号
@property(nonatomic,retain)NSString * is_read;//是否已读

@end
