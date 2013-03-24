//
//  JobSearchorCell1.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "JobSearchorCell1.h"

@implementation JobSearchorCell1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        // Initialization code
        // Initialization code
        self.lastestPositionNum=[[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 99, 30)] autorelease] ;
        [self.lastestPositionNum setTitleColor:[UIColor orangeColor] forState:0];
        //        self.lastestPositionNum.font=[UIFont fontWithName:@"Arial" size:14];
        //        self.lastestPositionNum.textAlignment=NSTextAlignmentCenter;
        self.lastestPositionNum.backgroundColor=[UIColor clearColor];
        [self addSubview:self.lastestPositionNum];
        
        UILabel * label1=[[UILabel alloc] initWithFrame:CGRectMake(10, 35, 99, 20)];
        label1.text=@"最新职位";
        label1.font=[UIFont fontWithName:@"Arial" size:12];
        label1.backgroundColor=[UIColor clearColor];
        label1.textAlignment=NSTextAlignmentCenter;
        [self addSubview:label1];
        [label1 release];
        
        
        UIView * aView=[[UIView alloc]initWithFrame:CGRectMake(110, 2, 1, 46)];
        aView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:aView];
        [aView release];
        
        self.modify=[[[UIButton alloc] initWithFrame:CGRectMake(145, 5, 25, 30)] autorelease];
        [self.modify setBackgroundImage:[UIImage imageNamed:@"searcherModify.png"] forState:0];
        [self addSubview:self.modify];
        
        
        UILabel * label2=[[UILabel alloc] initWithFrame:CGRectMake(111, 35, 90, 20)];
        label2.text=@"修改";
        label2.textAlignment=NSTextAlignmentCenter;
        label2.backgroundColor=[UIColor clearColor];
        label2.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:label2];
        [label2 release];
        
        UIView * bView=[[UIView alloc]initWithFrame:CGRectMake(110+90+1, 2, 1, 46)];
        bView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:bView];
        [bView release];
        //
        self.takeDaysView=[[[UIButton alloc] initWithFrame:CGRectMake(200+40, 10, 30, 20)] autorelease];
        [self.takeDaysView setBackgroundImage:[UIImage imageNamed:@"searcherSubscribe.png"] forState:0];
        //        self.takeDaysView.image=[UIImage  imageNamed:@"searcherSubscribe.png"];
        [self addSubview:self.takeDaysView];
        //
        self.takeDays=[[[UILabel alloc] initWithFrame:CGRectMake(201, 35, 110, 20)] autorelease];
        self.takeDays.textAlignment=NSTextAlignmentCenter;
        self.takeDays.backgroundColor=[UIColor clearColor];
        self.takeDays.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.takeDays];
        
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
