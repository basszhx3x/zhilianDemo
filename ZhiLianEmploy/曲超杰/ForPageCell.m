//
//  ForPageCell.m
//  ZhiLianLQX
//
//  Created by tony J on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ForPageCell.h"

@implementation ForPageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {

        self.CellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30)] autorelease];
        self.CellLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.CellLabel];
        
        self.PicCellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(310-30, 10, 10, 14)] autorelease];
        self.PicCellLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"accessoryArrow"]];
        [self addSubview:self.PicCellLabel];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
