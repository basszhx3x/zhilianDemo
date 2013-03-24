//
//  HasTextCell.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-24.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "HasTextCell.h"

@implementation HasTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.titleLabel=
        
        self.titleLabel=[[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 30)] autorelease];
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
        self.titleLabel.backgroundColor=[UIColor clearColor];
       
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:self.titleLabel];
        
        self.text = [[[UITextField alloc] initWithFrame:CGRectMake(310-200+20, 2, 180+10-20, 25)] autorelease];
        self.text.backgroundColor=[UIColor whiteColor];
        self.text.placeholder=@"请点击输入";
        self.text.font=[UIFont fontWithName:@"Arial" size:14];
        self.text.delegate=self;
        [self.text  setTextAlignment:NSTextAlignmentRight];
        self.text.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.text];
        
    }
    return self;
}

-(void)dealloc
{
    [_titleLabel release];
    [_text release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

@end
