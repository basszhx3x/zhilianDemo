//
//  MyHistoryView.m
//  ZhiLianLQX
//
//  Created by tony J on 13-2-19.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MyHistoryView.h"
#import "PushHistoryViewController.h"
@implementation MyHistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 150, 30)];
        firstLabel.backgroundColor = [UIColor clearColor];
        firstLabel.text = @"我的历史搜索";
        [firstLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:firstLabel];
        [firstLabel release];
        
        self.HistoryTableView = [[[UITableView alloc] initWithFrame:CGRectMake(5, 35, 310, 230) style:(UITableViewStyleGrouped)] autorelease];
        self.HistoryTableView.backgroundView.alpha = 0.0f;
        self.HistoryTableView.dataSource = self;
        self.HistoryTableView.delegate = self;
        [self addSubview:self.HistoryTableView];
    }
    return self;
}






//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


-(void)changeliner_height
{
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    PushHistoryViewController *pushHistoryVC = [[PushHistoryViewController alloc] init];
//    pushHistoryVC.navigationController
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
