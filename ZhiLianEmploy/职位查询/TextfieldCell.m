//
//  TextfieldCell.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "TextfieldCell.h"

@implementation TextfieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.CellLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 30)];
        self.CellLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.CellLabel];    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
