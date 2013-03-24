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
        
        
        for (int i = 0;i<6;i++)
        {   
            
            self.CellLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 30)];
            self.CellLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:self.CellLabel];
            
            self.subLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 5, 240, 20)];
            self.subLabel.backgroundColor = [UIColor clearColor];
            self.subLabel.font=[UIFont fontWithName:@"Arial" size:14];
            self.subLabel.textColor=[UIColor grayColor];
            self.subLabel.textAlignment=NSTextAlignmentRight;
            [self addSubview:self.subLabel];
            
            self.PicLabel = [[UILabel alloc] initWithFrame:CGRectMake(310-30, 10, 10, 14)];
            self.PicLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"accessoryArrow"]];
            [self addSubview:self.PicLabel];
            
        }
                
    }
    return self;
}

-(void)addcell
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
