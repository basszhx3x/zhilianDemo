//
//  ChangeCell.m
//  ZhiLianLQX
//
//  Created by tony J on 13-2-20.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ChangeCell.h"

@implementation ChangeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
      
            
            self.CellLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 30)] autorelease];
            self.CellLabel.backgroundColor = [UIColor clearColor];
            self.CellLabel.font=[UIFont fontWithName:@"Arial" size:14];
            [self addSubview:self.CellLabel];
            
            self.subLabel=[[[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 20)] autorelease];
            self.subLabel.backgroundColor = [UIColor clearColor];
            self.subLabel.font=[UIFont fontWithName:@"Arial" size:14];
            self.subLabel.textColor=[UIColor grayColor];
            self.subLabel.textAlignment=NSTextAlignmentRight;
            [self addSubview:self.subLabel];
            
            self.PicLabel = [[[UILabel alloc] initWithFrame:CGRectMake(320-30, 10, 10, 14)] autorelease];
            self.PicLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"accessoryArrow"]];
            [self addSubview:self.PicLabel];
            
        
                
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
