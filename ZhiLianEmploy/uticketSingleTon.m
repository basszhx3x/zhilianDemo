//
//  uticketSingleTon.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-6.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "uticketSingleTon.h"
#import "ZhiLianManager.h"
static uticketSingleTon * share;
@implementation uticketSingleTon
@synthesize uticket=_uticket;

+(uticketSingleTon *)share
{
    if (nil==share) {
        share=[[uticketSingleTon alloc]init];
        
    }
    
  

    
    return share;
}

@end
