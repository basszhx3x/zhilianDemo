//
//  CallBackCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "CallBackCell.h"

@implementation CallBackCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 30)] autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor=[UIColor lightGrayColor];
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
        [self addSubview:self.titleLabel];
        
        self.accessoryImg = [[[UIImageView alloc] initWithFrame:CGRectMake(320-35, 10, 14, 10)] autorelease];
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow-2.png"];
        [self addSubview:self.accessoryImg];

    }
    return self;
}

-(void)dealloc
{
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
