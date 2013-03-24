//
//  NSString+removeSaceAndEnter.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "NSString+removeSaceAndEnter.h"

@implementation NSString (removeSaceAndEnter)

-(NSString *)removeSpaceAndEnter:(NSString *)sender
{
  
    NSArray * arr=[sender componentsSeparatedByString:@" "];
    if ([arr count]>1) {
        NSString * str=[arr objectAtIndex:([arr count]-1)];
        return str;
    }
    if ([arr count]==1) {
        NSArray * arr1=[sender componentsSeparatedByString:@"\n"];
        NSString * str=[arr1 objectAtIndex:([arr1 count]-1)];
        
        return str;
    }

return nil;

}
@end
