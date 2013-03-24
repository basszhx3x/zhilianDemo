//
//  DrawLineView.h
//  ZLZP_CJW
//
//  Created by youngsing on 13-2-26.
//  Copyright (c) 2013年 youngsing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineView : UIView
{
    NSArray* pointArray;
    BOOL isCompareQuery;
}

- (void)drawLineWithParam: (NSArray* )array Compare: (BOOL)isCompare;

@end
