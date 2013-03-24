//
//  OtherJobCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-4.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "OtherJobCell.h"

@implementation OtherJobCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        for (UIView *v in self.subviews) {
            [v removeFromSuperview];
        }
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
        [self addSubview:view];
        self.CellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)] autorelease];
        self.CellLabel.backgroundColor = [UIColor clearColor];
        [view addSubview:self.CellLabel];
//        [self.CellLabel release];
        
        self.imageViewA = [[[UIImageView alloc]initWithFrame:CGRectMake(300, 5, 15, 15)]autorelease];
        self.imageViewA.backgroundColor = [UIColor clearColor];
        self.imageViewA.image = [UIImage imageNamed:@"accessoryArrow.png"];
        [view addSubview:self.imageViewA];
        [view release];
        
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
