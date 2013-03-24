//
//  SalarySearchViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SalarySearchViewController.h"
#import "ChangeCell.h"
#import "SalarySearchBtnActionViewController.h"
#import "RequestData.h"
static NSMutableDictionary *SearchBtnSendInfor = nil;
static NSMutableString *textFieldText = nil;
@interface SalarySearchViewController ()
-(void)searchJob:(id)sender;
@end

@implementation SalarySearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
   
    _tableView = nil;
    SearchBtnSendInfor = nil;
    textFieldText = nil;
    [super dealloc];
}
-(void)loadView
{
    SearchBtnSendInfor = [[NSMutableDictionary alloc]initWithCapacity:0];
    textFieldText = [[NSMutableString alloc]initWithCapacity:0];
    self.textField1 = [[[UITextField alloc] initWithFrame:CGRectMake(310-200, 2, 180+10, 25)] autorelease];
    
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)]autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    self.title = @"薪酬查询";
    
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped]autorelease];
    //self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView.alpha = 0.0f;
    //[self.tableView.backgroundView removeFromSuperview];

    [self.view addSubview:self.tableView];
    
    UIButton * search=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [search setBackgroundImage:[UIImage imageNamed:@"searchbtn.png"] forState:0];
    [search setTitle:@"查 询" forState:0];
    search.backgroundColor = [UIColor clearColor];
    search.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    search.titleLabel.textColor = [UIColor whiteColor];
    search.frame=CGRectMake(60, 280, 200, 40);
    [search addTarget:self action:@selector(searchJob:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:search];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)searchJob:(id)sender
{
//    SalarySearchBtnActionViewController *searchAction = [[[SalarySearchBtnActionViewController alloc]init] autorelease];
    //TODO:传值至薪酬比较
    SalaryQuerylist *que = [SalaryQuerylist ShareSalaryQuerylist];
    
    if (self.textField1.text.length != 0) {
        [SearchBtnSendInfor setObject:self.textField1.text forKey:[NSString stringWithFormat:@"%d",6]];
        que.salary = self.textField1.text;
 
    }
    
    NSString *str = nil;
    NSArray *tmpArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    NSArray *subLableStr = [NSArray arrayWithObjects:@"请选择地区",@"请选择行业", @"请选择企业性质",@"请选择职位类别",@"请选择职位级别",@"请输入期望月薪",nil];
    
    if (SearchBtnSendInfor.count < 6 && SearchBtnSendInfor.count != 0) {
        NSArray *keyArray = [[SearchBtnSendInfor keyEnumerator] allObjects];
       str = [self compareTwoArrays:tmpArray withSecond:keyArray];
    }

    if (SearchBtnSendInfor.count < 6 || SearchBtnSendInfor.count == 0) {
        
        UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(160-40, 240-120, 120, 40)] ;
        view.backgroundColor = [UIColor grayColor];
        if (SearchBtnSendInfor.count == 0) {
           view.text = [subLableStr objectAtIndex:0];
        }
        else view.text = [subLableStr objectAtIndex:[str intValue]-1];
        
        view.textAlignment = NSTextAlignmentCenter;
        [UIView animateWithDuration:3.0 animations:^{
            
            view.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
            //[view release];
        }];
        
        
        
        [self.view addSubview:view];
        
    }

    
    
    if (SearchBtnSendInfor.count == 6) {
        
        SalaryQuerylist *queList = [SalaryQuerylist ShareSalaryQuerylist];
        NSMutableDictionary *tmpDIc = [NSMutableDictionary dictionary];
        
        [tmpDIc setObject:@"1" forKey:@"experience"];
        [tmpDIc setObject:queList.cityid forKey:@"cityid"];
        [tmpDIc setObject:queList.industryid forKey:@"industryid"];
        [tmpDIc setObject:queList.corppropertyid forKey:@"corppropertyid"];
        [tmpDIc setObject:queList.jobcatid forKey:@"jobcatid"];
        [tmpDIc setObject:queList.salary forKey:@"salary"];
        [tmpDIc setObject:queList.joblevelid forKey:@"joblevelid"];
        
        // NSLog(@"%@",tmpDIc);
        
        RequestData *request = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/payquery/query.service" withHttpMethod:@"GET" withParams:tmpDIc];
        [request setResultData:^(id aid, NSError *error) {
           
            if (![[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:@"text"]isEqualToString: @"0"]) {
                  SalarySearchBtnActionViewController *searchAction = [[SalarySearchBtnActionViewController alloc]init];
               // NSLog(@"%@",aid);
//                NSLog(@"%@",SearchBtnSendInfor);
                [searchAction.secondRowSource setDictionary:SearchBtnSendInfor];
                [searchAction.pointArray addObject:[self resultForPointArray:@"low" WithDIc:aid]];
                [searchAction.pointArray addObject:[self resultForPointArray:@"low-normal" WithDIc:aid]];
                [searchAction.pointArray addObject:[self resultForPointArray:@"normal" WithDIc:aid]];
                [searchAction.pointArray addObject:[self resultForPointArray:@"normal-high" WithDIc:aid]];
                [searchAction.pointArray addObject:[self resultForPointArray:@"high" WithDIc:aid]];
               // NSLog(@"%@",searchAction.pointArray);
                [self.navigationController pushViewController:searchAction animated:YES];
                [searchAction release];
            }
            else
                NSLog(@"没有符合该条件的薪资信息！");
            
        }];
        [request connect];

        
        

    }
    
  //  [SearchBtnSendInfor release];
    
    
}
-(NSString *)resultForPointArray:(NSString *)aStr WithDIc:(NSDictionary *)aid
{
    NSString *str =[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:aStr] objectForKey:@"text"];

    return str;
}
-(NSString *)compareTwoArrays:(NSArray *)firstArray withSecond:(NSArray *)secondArray
{
    for (NSString *str1 in firstArray) {
        for (NSString *str2 in secondArray) {
            if ([str1 isEqualToString:str2]) {
                break;
            }
            if ([str2 isEqualToString:[secondArray lastObject]]) {
                if ([str2 isEqualToString:str1]) {
                    break;
                }
                else
                {
                    return str1;
                }
                
            }
        
        }
    }

    return nil;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.tableView reloadData];
    
    
}
#pragma mark --tableview method--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *firstLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)]autorelease];
    //firstLabel.textAlignment = NSTextAlignmentRight;
    firstLabel.font=[UIFont fontWithName:@"Arial" size:16];
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.text = @"   选择薪酬查询条件";
    [firstLabel setTextColor:[UIColor whiteColor]];
   // [tableView addSubview:firstLabel];
    
    return firstLabel;
 }
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(60, 220, 200, 40)];
//    view.backgroundColor = [UIColor redColor];
//    [tableView addSubview:view];
//    return view;
//    
//}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
   
    return 60;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    
    ChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[ChangeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    cell.CellLabel.font=[UIFont fontWithName:@"Arial" size:14];
    cell.CellLabel.text = [self getStringForIndexpath:indexPath];
    if (indexPath.row == 0) {
        
        [cell.subLabel removeFromSuperview];
        [cell.PicLabel removeFromSuperview];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(320-45, 5, 30, 25);
        [button setImage:[UIImage imageNamed:@"select_icon"] forState:0];//select_icon
        [button setImage:[UIImage imageNamed:@"unselect_icon"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        [cell addSubview:button];
        
        
        
    }
    else if (indexPath.row > 0 && indexPath.row < 6) {
        cell.subLabel.text = [self getSubLableStringWithIndexpath:indexPath];
    }
    else if (indexPath.row == 6)
    {
        [cell.subLabel removeFromSuperview];
        [cell.PicLabel removeFromSuperview];
        
        
        self.textField1.backgroundColor=[UIColor whiteColor];
        self.textField1.placeholder=@"请点击输入";
        self.textField1.font=[UIFont fontWithName:@"Arial" size:14];
        self.textField1.delegate=self;
       // [textField1  setTextAlignment:NSTextAlignmentLeft];
       self.textField1.borderStyle = UITextBorderStyleRoundedRect;
        [cell addSubview:self.textField1];

    }
   
    
    return cell;


}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
-(void)buttonAction:(UIButton *)sender
{
    if (sender.currentImage == [UIImage imageNamed:@"select_icon"]) {
        
        [sender setImage:[UIImage imageNamed:@"unselect_icon"] forState:0];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"select_icon"] forState:0];
    
    }
    

}
-(NSString *)getStringForIndexpath:(NSIndexPath *)aIndexPath
{
    NSArray *cellLableStr = [NSArray arrayWithObjects:@"我有工作经验",@"地区:",@"行业:",@"企业性质:",@"职位类别:",@"职位级别:",@"期望月薪:",nil];
    
    return [cellLableStr objectAtIndex:aIndexPath.row];
}
-(NSString *)getSubLableStringWithIndexpath:(NSIndexPath *)aIndexPath
{
     NSArray *subLableStr = [NSArray arrayWithObjects:@"请选择地区",@"请选择行业", @"请选择企业性质",@"请选择职位类别",@"请选择职位级别",nil];
        if (aIndexPath.row > 0 && aIndexPath.row < 6) {
        return [subLableStr objectAtIndex:aIndexPath.row-1];
        }

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0 && indexPath.row <6) {
        SalaryPushViewController *tmpPushcontroller = [[SalaryPushViewController alloc]init];
        tmpPushcontroller.delegate = self;
        ChangeCell *cellk = (ChangeCell *)[tableView cellForRowAtIndexPath:indexPath];
        tmpPushcontroller.indexTarget = cellk.CellLabel.text ;
        tmpPushcontroller.aindexPath = indexPath;
        [self.navigationController pushViewController:tmpPushcontroller animated:YES];
        [tmpPushcontroller release];
        cellk.selected = NO;
    }
}
-(void)SalaryPushViewController:(SalaryPushViewController *)aViewCOntroller withTargetString:(NSString *)aStr withIndexPath:(NSIndexPath *)aIndexPath
{
    //NSLog(@"%@",aIndexPath);
    ChangeCell *Kcell = (ChangeCell *)[self.tableView cellForRowAtIndexPath:aIndexPath];
    Kcell.subLabel.textColor = [UIColor blackColor];
    Kcell.subLabel.text = aStr;
    
    [SearchBtnSendInfor setObject:aStr forKey:[NSString stringWithFormat:@"%d",aIndexPath.row]];
    SalaryQuerylist *que = [SalaryQuerylist ShareSalaryQuerylist];
   
    que.citys = aViewCOntroller.salaryQuelist.citys;
    que.industry = aViewCOntroller.salaryQuelist.industry;
    que.corpproperty = aViewCOntroller.salaryQuelist.corpproperty;
    que.jobcat = aViewCOntroller.salaryQuelist.jobcat;
    que.joblevel = aViewCOntroller.salaryQuelist.joblevel;
    

}
-(void)SalaryPushViewController:(SalaryPushViewController *)aViewCOntroller withIdIndex:(NSString *)aID withINdexPath:(NSIndexPath *)aIndex
{
    SalaryQuerylist *que = [SalaryQuerylist ShareSalaryQuerylist];
    
    switch (aIndex.row) {
        case 1:
        {
            que.cityid = aID;
            break;
        }
        case 2:
        {
            que.industryid = aID;
            break;
        }
        case 3:
        {
            que.corppropertyid = aID;
            break;
        }
        case 4:
        {
            que.jobcatid = aID;
            break;
        }
            case 5:
        {
            que.joblevelid = aID;
            break;
        
        }
        default:
            break;
    }
    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
