//
//  scanResumeCompanyListCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-1.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "scanResumeCompanyListCell.h"

@implementation scanResumeCompanyListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.companyName=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 150, 20)];
        //        self.jobName.text=@"工程师";
        [self addSubview:self.companyName];
        
        self.scale=[[UILabel alloc] initWithFrame:CGRectMake(5, 25, 150, 15)];
        self.scale.textColor=[UIColor lightGrayColor];
        //        self.companyName.text=@"工程师";
        self.scale.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.scale];
        
        
        
        
        self.date=[[UILabel alloc] initWithFrame:CGRectMake(200, 5, 95, 20)];
        self.date.textColor=[UIColor lightGrayColor];
        self.date.textAlignment=NSTextAlignmentRight;
        self.date.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.date];
        
       
        
        self.accessoryImg = [[UIImageView alloc] initWithFrame:CGRectMake(320-15, 15, 14, 14)] ;
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow.png"];
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
