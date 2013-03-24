//
//  managerOfferCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "managerOfferCell.h"

@implementation managerOfferCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.senderImg=[[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 25, 25)];
        self.senderImg.image=[UIImage imageNamed:@"reader_flag.png"];
        [self addSubview:self.senderImg];
        
        
        self.offerName=[[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
        [self addSubview:self.offerName];
        
        self.companyName=[[UILabel alloc] initWithFrame:CGRectMake(35, 25, 150, 15)];
        self.companyName.textColor=[UIColor lightGrayColor];
        //        self.companyName.text=@"工程师";
        self.companyName.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.companyName];
        
        self.date=[[UILabel alloc] initWithFrame:CGRectMake(200, 23, 95, 20)];
        self.date.textColor=[UIColor lightGrayColor];
        self.date.textAlignment=NSTextAlignmentRight;
        //        self.address.text=@"2012";
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
