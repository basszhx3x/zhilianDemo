//
//  CanClickCell.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-24.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "CanClickCell.h"

@implementation CanClickCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel=[[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 30)] autorelease];
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        self.titleLabel.textColor=[UIColor lightGrayColor];
        [self addSubview:self.titleLabel];
        
        self.accessoryImg = [[[UIImageView alloc] initWithFrame:CGRectMake(320-30, 10, 10, 14)] autorelease];
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow"];
        [self addSubview:self.accessoryImg];
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
