//
//  ReportJobDataManage.h
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestData.h"

@interface ReportJobDataManage : NSObject
-(void)readDataWithURL:(NSString *)url Params:(NSMutableDictionary *)params;

@end
