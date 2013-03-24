//
//  Salarypush.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "Salarypush.h"

@implementation Salarypush


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
             self.CellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 30)] autorelease];
            self.CellLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:self.CellLabel];
     }
    return self;
}


@end
