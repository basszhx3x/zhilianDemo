//
//  myAnnotation.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "myAnnotation.h"

@implementation myAnnotation
//-(id) initWithCoordinate:(CLLocationCoordinate2D) coords
//{
//    if (self = [super init]) {
//        self.coordinate = coords;
//        //_coordinate = coords;
//    }
//    return self;
//}
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;

}
-(NSString *) title
{
    return @"北京大学";
}

-(NSString *) subtitle
{
    return @"你所查寻的位置";
}
@end
