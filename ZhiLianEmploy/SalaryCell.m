//
//  SalaryCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SalaryCell.h"

@implementation SalaryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, 30)] autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
        [self addSubview:self.titleLabel];
        
        self.subLabel=[[[UILabel alloc] initWithFrame:CGRectMake(30, 5, 240, 20)] autorelease];
        self.subLabel.backgroundColor = [UIColor clearColor];
        self.subLabel.font=[UIFont fontWithName:@"Arial" size:14];
        self.subLabel.textColor=[UIColor grayColor];
        self.subLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:self.subLabel];
        
        self.accessoryImg = [[[UIImageView alloc] initWithFrame:CGRectMake(320-35, 10, 14, 10)] autorelease];
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow-1.png"];
        [self addSubview:self.accessoryImg];


    }
    return self;
}
-(void)dealloc
{
    [_titleLabel release];
    [_subLabel release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
