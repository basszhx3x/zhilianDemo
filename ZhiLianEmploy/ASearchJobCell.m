//
//  ASearchJobCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ASearchJobCell.h"

@implementation ASearchJobCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        change=YES;
        // Initialization code
        self.headImg=[[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 25, 25)] autorelease];
        [self.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [self addSubview:self.headImg];
        
        self.titleLabel=[[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 120, 30)] autorelease];
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
      
        
        self.accessoryImg = [[[UIImageView alloc] initWithFrame:CGRectMake(320-25, 10, 14, 14)] autorelease];
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow.png"];
        [self addSubview:self.accessoryImg];
        
        
    }
    return self;
}

-(void)dealloc
{
    [_identifier release];
    [_headImg release];
    [_titleLabel release];
    [_accessoryImg release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
