//
//  uticketSingleTon.h
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uticketSingleTon : NSObject
{
    NSString * _uticket;

}
+(uticketSingleTon *)share;
@property(nonatomic,retain)NSString * uticket; 

@end
