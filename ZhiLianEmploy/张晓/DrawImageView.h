//
//  DrawImageView.h
//  ZLZP_CJW
//
//  Created by youngsing on 13-2-25.
//  Copyright (c) 2013年 youngsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawImageView : UIView
{
    NSArray* paramArray;
    
    BOOL isCompareQuery;
    CGFloat salaryQuery;
    CGFloat maxFloat;
    CGFloat minFloat;
    
    NSMutableArray* pointArray;
    
    UIImageView *feedbackImageView;
}

@property (retain, nonatomic) NSString* salary;

- (id)initWithParam: (NSArray* )salaryParam ExpectSalary: (float)salary Compare: (BOOL)isCompare;
- (UIView* )drawImageView;

@end
