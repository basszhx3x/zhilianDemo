//
//  LasteastJobViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "LasteastJobViewController.h"
#import "GetLastestJobCell.h"
#import "getLastestJobEntity.h"
#import "NSString+removeSaceAndEnter.h"
#import "CompanyDetailInfoViewController.h"
#import "RequestData.h"

@interface LasteastJobViewController ()

@end

@implementation LasteastJobViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        setRangeArr=[[NSMutableArray alloc] initWithObjects:@"不选择",@"1公里",@"3公里",@"5公里", nil];
        setRangeTitle =[[NSMutableArray alloc] init];
        self.dataArr=[[[NSMutableArray alloc] init] autorelease];
        chooseJob=[[NSMutableArray alloc] init];
        
        
     
        
    }
    return self;
}

-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(0, 0, 50, 30);
    [back setTitle:@"返回" forState:0];
    [back setTitleColor:[UIColor whiteColor] forState:0];
    back.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [back setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:back] autorelease];
    
    UIButton * apply=[UIButton buttonWithType:UIButtonTypeCustom];
    apply.frame=CGRectMake(0, 0, 50, 30);
    [apply setTitle:@"申请" forState:0];
    [apply setTitleColor:[UIColor whiteColor] forState:0];
    apply.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [apply setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [apply setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [apply addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:apply] autorelease];

    self.title=self.titleName;
    
    //设置当前范围
    UILabel * setRange=[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 150, 20)];
    setRange.text=@"设置当前位置范围:";
    setRange.backgroundColor=[UIColor clearColor];
    [self.view addSubview:setRange];
    [setRange release];
    
    setRangeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    setRangeBtn.frame=CGRectMake(200, 10, 60, 20);
    [setRangeBtn  setTitle:@"1公里" forState:0];
    [setRangeBtn addTarget:self action:@selector(setRange:) forControlEvents:UIControlEventTouchUpInside];
    [setRangeBtn setTitleColor:[UIColor blackColor] forState:0];
    setRangeBtn.backgroundColor=[UIColor clearColor];
    [self.view addSubview:setRangeBtn];
    
    self.myTableView=[[[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 480-49-20-44) style:UITableViewStylePlain] autorelease];
    self.myTableView.backgroundView.alpha=0;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.view addSubview:self.myTableView];
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
-(void)setRange:(UIButton *)sender
{
    self.myActionSheet = [[[UIActionSheet alloc]initWithTitle:nil
                                                    delegate:nil
                                           cancelButtonTitle:@"cancel"
                                      destructiveButtonTitle:@"OK"
                                           otherButtonTitles:@"1",@"2", nil] autorelease];
    
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    NSMutableArray * barsArray = [NSMutableArray array];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [barsArray addObject:spaceItem];
    [spaceItem release];
    
    UIBarButtonItem *twoItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pickerBarButton:)];
    twoItem.tag=sender.tag;
    [barsArray addObject:twoItem];
    [twoItem release];
    
    toolBar.items = barsArray;
    
    //加载拾取器：
    setRangeView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 220)];
    self.shouldGroupAccessibilityChildren = YES;
    setRangeView.delegate = self;
    setRangeView.dataSource = self;
    setRangeView.showsSelectionIndicator = YES;
    [self.myActionSheet addSubview:setRangeView];
    [setRangeView release];
    [self.myActionSheet addSubview:toolBar];
    [toolBar release];
    [self.myActionSheet showInView:self.view];


}
-(void)back:(UIButton *)sender
{
    NSArray * arr=self.navigationController.viewControllers;
    [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];

}

-(void)apply:(UIButton *)sender
{


}
#pragma mark -uipickViewDelegate-
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [setRangeArr count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [setRangeArr objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [setRangeTitle addObject:[setRangeArr objectAtIndex:row]];
        
}

-(void)pickerBarButton:(UIBarButtonItem *)sender
{
    if ([setRangeTitle count]==0) {
        [self.myActionSheet dismissWithClickedButtonIndex:1 animated:YES];
        
    }
    else
    {
        [setRangeBtn setTitle:[setRangeTitle objectAtIndex:([setRangeTitle count]-1)] forState:0];
        [self.myActionSheet dismissWithClickedButtonIndex:1 animated:YES];

    
    }

}

#pragma mark -tableViewDelegate-
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataArr count]==0) {
        return 1;
    }
    return [self.dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataArr  count]>0) {
        static NSString * cellIdentifier=@"cell";
        GetLastestJobCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell) {
            cell=[[[GetLastestJobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        getLastestJobEntity * data=[self.dataArr objectAtIndex:indexPath.row];
        cell.jobName.text=[data.job_title removeSpaceAndEnter:data.job_title];
        cell.companyName.text=[data.company_name removeSpaceAndEnter:data.company_name];
        cell.address.text=[data.job_city removeSpaceAndEnter:data.job_city];
        [cell.chooseImg addTarget:self action:@selector(saveHasImageCell:) forControlEvents:UIControlEventTouchUpInside ];
        cell.chooseImg.tag=indexPath.row;
        
        if ([chooseJob containsObject:indexPath])
        {
            [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_selected"] forState:UIControlStateNormal];
        }
        
        
        else
        {
            [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"search_result_unselected"] forState:UIControlStateNormal];
        }
        

        return cell;
    }
    else
    {
        static NSString * cellIdentifier1=@"cell1";
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell) {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        cell.textLabel.text=@"没有最新数据";
        cell.textLabel.font=[UIFont fontWithName:@"Arial" size:14];
        return cell;
    
    }
   

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CompanyDetailInfoViewController * root=[[CompanyDetailInfoViewController alloc] init];
    root.job_number=[((getLastestJobEntity *)[self.dataArr objectAtIndex:indexPath.row]).job_number removeSpaceAndEnter:((getLastestJobEntity *)[self.dataArr objectAtIndex:indexPath.row]).job_number];
    root.identifier=@"4";
//    root.company_number=[((getLastestJobEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_number removeSpaceAndEnter:((getLastestJobEntity *)[self.dataArr objectAtIndex:indexPath.row]).company_number];
    [self.navigationController pushViewController:root animated:YES];
    [root release];

}

-(void)saveHasImageCell:(UIButton *)sender
{
    if (![chooseJob containsObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:0];
        [chooseJob addObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        NSLog(@"%@",chooseJob);
        
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"search_result_unselected.png"] forState:0];
        [chooseJob removeObject:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
        
    }
}



@end
