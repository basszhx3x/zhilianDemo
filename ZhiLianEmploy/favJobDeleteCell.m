//
//  favJobDeleteCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "favJobDeleteCell.h"

@implementation favJobDeleteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Initialization code
        self.chooseImg=[[UIButton alloc] initWithFrame:CGRectMake(5, 10, 25, 25)];
        [self.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [self addSubview:self.chooseImg];
        
        
        self.jobName=[[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
        [self addSubview:self.jobName];
        
        self.companyName=[[UILabel alloc] initWithFrame:CGRectMake(35, 25, 150, 15)];
        self.companyName.textColor=[UIColor lightGrayColor];
        //        self.companyName.text=@"工程师";
        self.companyName.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.companyName];
        
        self.address=[[UILabel alloc] initWithFrame:CGRectMake(200, 23, 95, 20)];
        self.address.textColor=[UIColor lightGrayColor];
        self.address.textAlignment=NSTextAlignmentRight;
        //        self.address.text=@"2012";
        self.address.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.address];
        
        self.accessoryImg = [[UIImageView alloc] initWithFrame:CGRectMake(320-15, 15, 14, 14)] ;
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow.png"];
        [self addSubview:self.accessoryImg];
        self.deleteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.deleteBtn.frame=CGRectMake(290, 10, 30, 30);
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"searchItem_del.png"] forState:0];
        [self addSubview:self.deleteBtn];


    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
