//
//  DrawImageView.m
//  ZLZP_CJW
//
//  Created by youngsing on 13-2-25.
//  Copyright (c) 2013年 youngsing. All rights reserved.
//

#import "DrawImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawLineView.h"

@implementation DrawImageView

- (id)initWithParam: (NSArray* )salaryParam ExpectSalary:(float)salary Compare: (BOOL)isCompare
{
    if (self = [super init])
    {
        if (isCompare)
            self.frame = CGRectMake(0, 0, 320, 239);
        else
            self.frame = CGRectMake(0, 0, 320, 206);
        self.backgroundColor = [UIColor whiteColor];
        
        paramArray = [[NSArray alloc] initWithArray:salaryParam];
        pointArray = [[NSMutableArray alloc] init];
        isCompareQuery = isCompare;
        salaryQuery = salary;
        
        UIView* topView = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        topView.backgroundColor = [UIColor clearColor];
        [self addSubview:topView];
        
        UIImageView* formTitleImageView = [[[UIImageView alloc] initWithFrame:CGRectMake((320 - 304) / 2, 5, 304, 33)] autorelease];
        formTitleImageView.image = [UIImage imageNamed:@"form_title.png"];
        [topView addSubview:formTitleImageView];
        
        UIImageView* formQueryImageView1 = [[[UIImageView alloc] initWithFrame:CGRectMake((320 - 304) / 2, 38, 304, 33)] autorelease];
        formQueryImageView1.image = [UIImage imageNamed:@"form_query.png"];
        [topView addSubview:formQueryImageView1];
        
        UILabel* salaryLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 304, 33)] autorelease];
        salaryLabel1.text = [NSString stringWithFormat:@" 月薪  ￥%@    ￥%@     ￥%@     ￥%@   ￥%@",
                             [salaryParam objectAtIndex:0],
                             [salaryParam objectAtIndex:1],
                             [salaryParam objectAtIndex:2],
                             [salaryParam objectAtIndex:3],
                             [salaryParam objectAtIndex:4]];
        salaryLabel1.backgroundColor = [UIColor clearColor];
        salaryLabel1.font = [UIFont fontWithName:@"Helvetica" size:12];
        [formQueryImageView1 addSubview:salaryLabel1];
        
        if (isCompare)
        {
            topView.frame = CGRectMake(0, 0, 320, 104);
            
            salaryLabel1.text = [NSString stringWithFormat:@" 首次  ￥%@    ￥%@     ￥%@     ￥%@   ￥%@",
                                 [salaryParam objectAtIndex:0],
                                 [salaryParam objectAtIndex:1],
                                 [salaryParam objectAtIndex:2],
                                 [salaryParam objectAtIndex:3],
                                 [salaryParam objectAtIndex:4]];
            
            UIImageView* formQueryImageView2 = [[[UIImageView alloc] initWithFrame:CGRectMake((320 - 304) / 2, 71, 304, 33)] autorelease];
            formQueryImageView2.image = [UIImage imageNamed:@"form_compare.png"];
            [topView addSubview:formQueryImageView2];
            
            UILabel* salaryLabel2 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 304, 33)] autorelease];
            salaryLabel2.text = [NSString stringWithFormat:@" 比较  ￥%@    ￥%@     ￥%@     ￥%@   ￥%@",
                                 [salaryParam objectAtIndex:5],
                                 [salaryParam objectAtIndex:6],
                                 [salaryParam objectAtIndex:7],
                                 [salaryParam objectAtIndex:8],
                                 [salaryParam objectAtIndex:9]];
            salaryLabel2.backgroundColor = [UIColor clearColor];
            salaryLabel2.font = [UIFont fontWithName:@"Helvetica" size:12];
            [formQueryImageView2 addSubview:salaryLabel2];
            
            minFloat = MIN([[salaryParam objectAtIndex:0] floatValue], [[salaryParam objectAtIndex:5] floatValue]);
            maxFloat = MAX([[salaryParam objectAtIndex:4] floatValue], [[salaryParam objectAtIndex:9] floatValue]);
        }
        else
        {
            topView.frame = CGRectMake(0, 0, 320, 71);
            minFloat = [[salaryParam objectAtIndex:0] floatValue];
            maxFloat = [[salaryParam lastObject] floatValue];
        }
        
        minFloat = (int)minFloat / 400 * 400;
        
        if ((int)maxFloat % 400 != 0)
            maxFloat = ((int)maxFloat / 400 + 1) * 400;
        else
            maxFloat = (int)maxFloat / 400 * 400;
        
        NSUInteger plusInt = (maxFloat - minFloat) / 4;
        
        UIView* bottomView = [[[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height + 5, 320, 125)] autorelease];
        bottomView.backgroundColor = [UIColor clearColor];
        
        UIImageView* backgroundImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(320 - 8 - 265, 0, 265, 100)] autorelease];
        backgroundImageView.image = [UIImage imageNamed:@"chartBg"];
        [bottomView addSubview:backgroundImageView];
        [bottomView sendSubviewToBack:backgroundImageView];
        
        UILabel* tipsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(320 - 8 - 265, 105, 265, 20)] autorelease];
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.text = @"  低端      中低端    中端     中高端     高端";
        tipsLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        [bottomView addSubview:tipsLabel];
        
        UILabel* intLabel1 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 35, 15)] autorelease];
        intLabel1.backgroundColor = [UIColor clearColor];
        intLabel1.textAlignment = NSTextAlignmentRight;
        intLabel1.font = [UIFont fontWithName:@"Helvetica" size:12];
        intLabel1.text = [NSString stringWithFormat:@"%d", (int)maxFloat];
        [bottomView addSubview:intLabel1];
        
        UILabel* intLabel2 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20 * 1, 35, 15)] autorelease];
        intLabel2.backgroundColor = [UIColor clearColor];
        intLabel2.textAlignment = NSTextAlignmentRight;
        intLabel2.font = [UIFont fontWithName:@"Helvetica" size:12];
        intLabel2.text = [NSString stringWithFormat:@"%d", (int)maxFloat - plusInt];
        [bottomView addSubview:intLabel2];
        
        UILabel* intLabel3 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20 * 2, 35, 15)] autorelease];
        intLabel3.backgroundColor = [UIColor clearColor];
        intLabel3.textAlignment = NSTextAlignmentRight;
        intLabel3.font = [UIFont fontWithName:@"Helvetica" size:12];
        intLabel3.text = [NSString stringWithFormat:@"%d", (int)maxFloat - plusInt * 2];
        [bottomView addSubview:intLabel3];
        
        UILabel* intLabel4 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20 * 3, 35, 15)] autorelease];
        intLabel4.backgroundColor = [UIColor clearColor];
        intLabel4.textAlignment = NSTextAlignmentRight;
        intLabel4.font = [UIFont fontWithName:@"Helvetica" size:12];
        intLabel4.text = [NSString stringWithFormat:@"%d", (int)maxFloat - plusInt * 3];
        [bottomView addSubview:intLabel4];
        
        UILabel* intLabel5 = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20 * 4, 35, 15)] autorelease];
        intLabel5.backgroundColor = [UIColor clearColor];
        intLabel5.textAlignment = NSTextAlignmentRight;
        intLabel5.font = [UIFont fontWithName:@"Helvetica" size:12];
        intLabel5.text = [NSString stringWithFormat:@"%d", (int)maxFloat - plusInt * 4];
        [bottomView addSubview:intLabel5];
        
        [self addSubview:bottomView];
        [self sendSubviewToBack:bottomView];
    
    }
    return self;
}

-(void)dealloc
{
    [paramArray release];   paramArray = nil;
    [pointArray release];   pointArray = nil;
    [super dealloc];
}

- (UIView *)drawImageView
{
    CGFloat height;
    
    if (isCompareQuery)
    {
        for (int i = 0; i != 2; ++i)
        {
            for (int j = 0; j != 5; ++j)
            {
                height = 104 + 5 + (maxFloat - [[paramArray objectAtIndex:i * 5 + j] floatValue]) / maxFloat * 100;
                CGPoint point = CGPointMake(73.5 + 53 * j, height);
                [pointArray addObject:[NSValue valueWithCGPoint:point]];
                
                UIImageView* queryPointImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(point.x - 3, point.y - 3, 6, 6)] autorelease];
                if (i == 0)
                    queryPointImageView.image = [UIImage imageNamed:@"queryPoint.png"];
                else
                    queryPointImageView.image = [UIImage imageNamed:@"comparePoint.png"];
                [self addSubview:queryPointImageView];
            }
        }
    }
    else
    {
        for (int i = 0; i != 5; ++i)
        {
            height = 71.0f + 5.0f + (maxFloat - [[paramArray objectAtIndex:i] floatValue]) / maxFloat * 100;
            CGPoint point = CGPointMake(73.5 + 53 * i, height);
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            
            UIImageView* queryPointImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(point.x - 3, point.y - 3, 6, 6)] autorelease];
            queryPointImageView.image = [UIImage imageNamed:@"queryPoint.png"];
            [self addSubview:queryPointImageView];
        }
    }
    
    
    
    //    [self setNeedsDisplay];
    
    DrawLineView* aView = [[[DrawLineView alloc] initWithFrame:CGRectMake(0, 0, 320, 234)] autorelease];
    [aView drawLineWithParam:pointArray Compare:isCompareQuery];
    [self addSubview:aView];
    
    CGFloat x;
    CGFloat y;
    if (isCompareQuery)
    {
        if (salaryQuery > maxFloat)
        {
            x = 310.0f;
            y = 104.0f;
        }
        else if (salaryQuery < minFloat)
        {
            x = 47.0f;
            y = 104.0f + 5.0f + 100.0f;
        }
        else
        {
            x = 47.0f + salaryQuery / maxFloat * 265;
            y = 104.0f + 5.0f + (maxFloat - salaryQuery) / maxFloat * 100;
            
        }
    }
    else
    {
        if (salaryQuery > maxFloat)
        {
            x = 310.0f;
            y = 76.0f;
        }
        else if (salaryQuery < minFloat)
        {
            x = 47.0f;
            y = 71.0f + 5.0f + 100.0f;
        }
        else
        {
            x = 47.0f + salaryQuery / maxFloat * 265;
            y = 71.0f + 5.0f + (maxFloat - salaryQuery) / maxFloat * 100;
            
        }
    }
    
    
    UIImageView* queryFlagImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(x - 12.5, y - 27, 25, 27)] autorelease];
    queryFlagImageView.image = [UIImage imageNamed:@"queryFlag.png"];
    [self addSubview:queryFlagImageView];
    
    //    [self screenshotAction:CGRectMake(0, 0, 320, isCompareQuery ? (104 + 5 + 125) : (71 + 5 + 125))];
    
    
    
    return self;
}

- (void)screenshotAction: (CGRect)rect
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *tmpScreenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef tmpCGImageRef =  CGImageCreateWithImageInRect(tmpScreenshotImage.CGImage, rect);
    UIImage *screenshotImage = [UIImage imageWithCGImage: tmpCGImageRef];
    feedbackImageView = [[UIImageView alloc] initWithImage:screenshotImage];
    CGImageRelease(tmpCGImageRef);
}

@end
