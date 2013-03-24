//
//  MoreDetailConditionViewController.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "MoreDetailConditionViewController.h"
#import "ASearchJobCell.h"
#import "BaseData.h"
#import "NSString+removeSaceAndEnter.h"

@interface MoreDetailConditionViewController ()

@end

@implementation MoreDetailConditionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        chooseCityDataArr=[[NSMutableArray alloc] init];
        chooseCityBack=[[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc
{
    [_myTableView release];
    [_indexpath release];
    [_identifier release];
    [chooseCityDataArr release];
    [chooseCityBack release];
    [super dealloc];
}

-(void)loadView
{
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 50, 30);
    [back setTitle:@"返回" forState:0];
    [back setTitleColor:[UIColor whiteColor] forState:0];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:back] autorelease];
    
    self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-49-20-44)] autorelease];
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
    
    if ([self.identifier1  isEqualToString:@"1"]) {
        [chooseCityBack addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    if (self.indexpath.row==0)
    {
         self.title=@"选择职业";
        BaseData * data=[BaseData getInstance];
        //不需要初始化了，如果初始化，会造成过度释放
        chooseCityArr=[data getPosition];
        if ([self.identifier  isEqualToString:@"-1"])
        {
            [chooseCityDataArr addObject:@"不限"];
            return;
        }

        for (NSArray* arr in chooseCityArr)
        {
            if ([((NSString *)[arr objectAtIndex:2]) isEqualToString:self.identifier])
            {
                                   
               
                NSString * str=[arr objectAtIndex:1];
                [chooseCityDataArr addObject:[str removeSpaceAndEnter:str]];
            }
            
     
 
        }
        
     [chooseCityDataArr removeObjectAtIndex:0];

       
    }
    
    if (self.indexpath.row==2) {
        
        BaseData * data=[BaseData getInstance];
        
        //不需要初始化了，如果初始化，会造成过度释放
        chooseCityArr=[data getCity];
        for (NSArray* arr in chooseCityArr)
        {
            if ([((NSString *)[arr objectAtIndex:2]) isEqualToString:self.identifier]) {
                 NSString * str=[arr objectAtIndex:1];
                 [chooseCityDataArr addObject:[str removeSpaceAndEnter:str]];
                }

        }
        self.title=@"选择城市";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chooseCityDataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier=@"cell";
    ASearchJobCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil==cell) {
        cell=[[[ASearchJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.titleLabel.text=[chooseCityDataArr objectAtIndex:indexPath.row];
    [cell.headImg addTarget:self action:@selector(saveHasImageCell:) forControlEvents:UIControlEventTouchUpInside];

    cell.headImg.tag=indexPath.row;
    
    if ([chooseCityBack containsObject:indexPath])
    {
        [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.headImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected"] forState:UIControlStateNormal];
    }
    cell.accessoryImg.hidden=YES;
    return cell;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -selffunc-
-(void)back:(UIButton *)sender
{
    //清空数据
    [chooseCityDataArr removeAllObjects];
    NSArray * arr=[self navigationController].viewControllers;
    [self.navigationController popToViewController:[arr objectAtIndex:3] animated:YES];

}

-(void)saveHasImageCell:(UIButton *)sender
{
    if (![chooseCityBack containsObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
        [chooseCityBack addObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [chooseCityBack removeObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    }
}
@end
