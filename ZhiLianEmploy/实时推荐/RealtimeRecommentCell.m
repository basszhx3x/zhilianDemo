//
//  RealtimeRecommentCell.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-28.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "RealtimeRecommentCell.h"
#define  KFRAME(x,y,w,h) CGRectMake(x,y,w,h)
@implementation RealtimeRecommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        self.chooseImg=[[[UIButton alloc] initWithFrame:CGRectMake(15, 20, 25, 25)] autorelease];
      //  [self.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [self.chooseImg setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
     
        [self addSubview:self.chooseImg];
      //  [self.chooseImg release];
        
        self.jobName=[[[UILabel alloc] initWithFrame:CGRectMake(50, 5, 170, 20)] autorelease];
        //        self.jobName.text=@"工程师";
        self.jobName.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self clearBackgroundColorForLable:self.jobName];
      //  self.jobName.backgroundColor = [UIColor redColor];
        [self addSubview:self.jobName];
        //[self.jobName release];
        
        self.companyName=[[[UILabel alloc] initWithFrame:CGRectMake(50, 25, 220, 15)] autorelease];
        self.companyName.textColor=[UIColor lightGrayColor];
        //        self.companyName.text=@"工程师";
        self.companyName.backgroundColor = [UIColor clearColor];
        self.companyName.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.companyName];
        //[self.companyName release];
        
        self.post_ratio = [[[UILabel alloc]initWithFrame:KFRAME(50, 45, 170, 15)] autorelease];
        self.post_ratio.textColor = [UIColor lightGrayColor];
        self.post_ratio.backgroundColor = [UIColor clearColor];
        self.post_ratio.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.post_ratio];
       // [self.post_ratio release];
        
        
                
        self.date=[[[UILabel alloc] initWithFrame:CGRectMake(220, 5, 95, 20)] autorelease];
        self.date.textColor=[UIColor lightGrayColor];
       // self.date.text=[dateFormatter1 stringFromDate:[NSDate date]];
        self.date.textAlignment=NSTextAlignmentRight;
        //        self.date.text=@"2012";
        [self clearBackgroundColorForLable:self.date];
        self.date.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.date];
        //[self.date release];
        
        self.address=[[[UILabel alloc] initWithFrame:CGRectMake(220, 40, 95, 20)] autorelease];
        self.address.textColor=[UIColor lightGrayColor];
        self.address.textAlignment=NSTextAlignmentRight;
        //        self.address.text=@"2012";
        [self clearBackgroundColorForLable:self.address];
        self.address.font=[UIFont fontWithName:@"Arial" size:12];
        [self addSubview:self.address];
        //[self.address release];
        
        self.accessoryImg = [[[UIImageView alloc] initWithFrame:CGRectMake(320-25, 20, 14, 14)] autorelease];
        self.accessoryImg.image=[UIImage imageNamed:@"accessoryArrow.png"];
        [self addSubview:self.accessoryImg];
        //[self.accessoryImg release];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)clearBackgroundColorForLable:(UILabel *)aLable
{
    aLable.backgroundColor = [UIColor clearColor];
    aLable.textAlignment = NSTextAlignmentLeft;

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)dealloc
{
    [_job_number release];_job_number = nil;
    [_company_number release];_company_number = nil;
    [_post_ratio release];_post_ratio = nil;
    [super dealloc];
}


@end
