//
//  loginOutCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "loginOutCell.h"

@implementation loginOutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.img=[[[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 10, 10)] autorelease];
        
        [self addSubview:self.img];
//        [self.img release];
        
        self.title=[[[UILabel alloc] initWithFrame:CGRectMake(60, 8, 100, 30)] autorelease];
        self.title.font=[UIFont fontWithName:@"Arial" size:14];
        self.title.backgroundColor=[UIColor clearColor];
        self.title.textAlignment=NSTextAlignmentLeft;
        [self addSubview:self.title];

        
        self.info=[[[UILabel alloc] initWithFrame:CGRectMake(140, 8, 130, 30)] autorelease];
        self.info.font=[UIFont fontWithName:@"Arial" size:14];
        self.info.backgroundColor=[UIColor clearColor];
        self.info.textAlignment=NSTextAlignmentRight;
        self.info.textColor=[UIColor blueColor];
        [self addSubview:self.info];

        
       self. accessoryView=[[[UIImageView alloc] initWithFrame:CGRectMake(320-30, 8, 20, 20)] autorelease];
        self.accessoryView.image=[UIImage imageNamed:@"accessoryArrow.png"];
        [self addSubview:self.accessoryView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
