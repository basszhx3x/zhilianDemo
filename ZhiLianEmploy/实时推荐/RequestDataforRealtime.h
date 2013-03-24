//
//  RequestDataforRealtime.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "RequestData.h"

@interface RequestDataforRealtime : RequestData
+(RequestDataforRealtime *)requestDataWithURL:(NSString *)aurl withHttpMethod:(NSString *)ahttpMethod withParams:(NSMutableDictionary *)aDicwithParams;
-(void)connect;
@end
