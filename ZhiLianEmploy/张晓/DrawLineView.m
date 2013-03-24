//
//  DrawLineView.m
//  ZLZP_CJW
//
//  Created by youngsing on 13-2-26.
//  Copyright (c) 2013年 youngsing. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawLineWithParam:(NSArray *)array Compare:(BOOL)isCompare
{
    
    pointArray = [[NSArray alloc] initWithArray:array];
    isCompareQuery = isCompare;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(currentContext, 1.0f);
    
    if (isCompareQuery)
    {
        for (int i = 0; i != 2; ++i)
        {
            CGContextMoveToPoint(currentContext, [[pointArray objectAtIndex:i * 5] CGPointValue].x, [[pointArray objectAtIndex:i * 5] CGPointValue].y);
            for (int j = 0; j != 5; ++j)
            {
                if (i == 1 && j == 0)
                {
                    CGContextSetStrokeColorWithColor(currentContext, [UIColor redColor].CGColor);
                }
                CGContextAddLineToPoint(currentContext, [[pointArray objectAtIndex:i * 5 + j] CGPointValue].x, [[pointArray objectAtIndex:i * 5 + j] CGPointValue].y);
            }
            CGContextStrokePath(currentContext);
        }
    }
    else
    {
        CGContextMoveToPoint(currentContext, [[pointArray objectAtIndex:0] CGPointValue].x, [[pointArray objectAtIndex:0] CGPointValue].y);
        for (int i = 0; i != 5; ++i)
        {
            CGContextAddLineToPoint(currentContext, [[pointArray objectAtIndex:i] CGPointValue].x, [[pointArray objectAtIndex:i] CGPointValue].y);
        }
        CGContextStrokePath(currentContext);
    }
}

@end
