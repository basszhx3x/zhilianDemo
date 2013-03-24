//
//  SalarySearchBtnActionViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-25.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SalarySearchBtnActionViewController.h"
#import "ChangeCell.h"
#import "math.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchBtnMoreViewController.h"
#import "SalaryPushViewController.h"
#import "RequestData.h"
#import "SalaryQuerylist.h"
@interface SalarySearchBtnActionViewController ()
-(void)searchJob:(id)sender;
@end

@implementation SalarySearchBtnActionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.secondRowSource = [NSMutableDictionary dictionary];
        self.pointArray = [NSMutableArray array];
        self.comparePointArray = [NSMutableArray array];
    }
    return self;
}
-(void)dealloc
{
//    [self.maintableView release];
    self.maintableView = nil;
    [_secondIndexPath release];
    self.secondIndexPath = nil;
//    [self.secondRowSource release];
    self.secondRowSource = nil;
    drawImageView = nil;
    viewForLine = nil;
    [super dealloc];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    drawImageView = [[DrawImageView alloc]initWithParam:self.pointArray ExpectSalary:[[self.secondRowSource objectForKey:[NSString stringWithFormat:@"%d",6]] floatValue]Compare:NO];
    viewForLine = [drawImageView drawImageView];
    
    isEditStatus = NO;
    
    isCompareQuery = NO;
    self.secondRowChangeState = NO;
    self.maintableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44-20-49) style:UITableViewStylePlain] autorelease];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    [self.view addSubview:self.maintableView];
    self.title = @"薪酬比较";
    
    
    
    
}
-(void)searchJob:(id)sender
{
  
    
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
            [self.comparePointArray removeAllObjects];
            for (NSString *str in self.pointArray) {
                [self.comparePointArray addObject:str];
            }
            
            
            [self.comparePointArray addObject:[self resultForPointArray:@"low" WithDIc:aid]];
            [self.comparePointArray addObject:[self resultForPointArray:@"low-normal" WithDIc:aid]];
            [self.comparePointArray addObject:[self resultForPointArray:@"normal" WithDIc:aid]];
            [self.comparePointArray addObject:[self resultForPointArray:@"normal-high" WithDIc:aid]];
            [self.comparePointArray addObject:[self resultForPointArray:@"high" WithDIc:aid]];
//              NSLog(@"%@",self.comparePointArray);
            drawImageView = [[DrawImageView alloc]initWithParam:self.comparePointArray ExpectSalary:[[self.secondRowSource objectForKey:[NSString stringWithFormat:@"%d",6]] floatValue]Compare:YES];
            viewForLine = [drawImageView drawImageView];
            [self.maintableView reloadData];
        }
        else
            NSLog(@"没有符合该条件的薪资信息！");
        
    }];
    [request connect];

}
-(NSString *)resultForPointArray:(NSString *)aStr WithDIc:(NSDictionary *)aid
{
    NSString *str =[[[[aid objectForKey:@"root"] objectForKey:@"result"] objectForKey:aStr] objectForKey:@"text"];
    
    return str;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 && !isCompareQuery) {
        return 210.0f;
    }
    else if(indexPath.row == 3 && isCompareQuery)
    {
        return 239.0f;
    }
    if (indexPath.row == 1 && self.secondIndexPath == nil) {
        
        self.secondIndexPath = indexPath;
        return 0.0f;
    }
   if(indexPath.row == 1 && self.secondIndexPath != nil)
    {
         
        if (self.secondRowChangeState == YES) {
             return 150.0f;
       }
        else
        return 0.0f;
       
    }
    if (indexPath.row == 7) {
        
        return 80.0f;
    }
    return 30.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@key%d",@"cell",indexPath.row];
    ChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ChangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.CellLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    // Configure the cell...
    int targetRow = indexPath.row % 8;
    switch (targetRow) {
        case 0:
        {
            cell.PicLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
            cell.CellLabel.text = @"你的查询条件";

            break;
        }
        case 1:
        {
            [cell.PicLabel removeFromSuperview];
           
            if (self.secondRowChangeState == YES) {
                UIView *viewA = [self searchConditions];
                [cell addSubview:viewA];
            }
            else
            {
                for (UIView *aID in cell.subviews) {
                    [aID removeFromSuperview];
                }
            }
               
            
            
            
            
            break;
        }
        case 2:
        {
            [cell.PicLabel removeFromSuperview];
            cell.CellLabel.text = @"此类职位的市场起薪水平";
            break;
        }
        case 3:
        {
            [cell.PicLabel removeFromSuperview];
          
           // UIView *view = [drawImageView drawImageView];
            
            [cell addSubview:viewForLine];
            
            break;
        }
        case 4:
        {
            [cell.PicLabel removeFromSuperview];
            cell.CellLabel.text = @"薪酬比较";
        
            
            break;
        }
        case 5:
        {
            cell.CellLabel.text =@"我想比较:";
            if(!isEditStatus){
            
            cell.subLabel.text = @"请选择详细比较内容";
            }
            break;
        }
        case 6:
        {
            cell.CellLabel.text = @"继续比较:";
            if (!isEditStatus) {
                cell.subLabel.text = @"请选择详细比较内容";
                 sixlable = cell.subLabel;
            }
           
             break;
        }
        case 7:
        {
            [cell.PicLabel removeFromSuperview];
            UIButton * search=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            [search setBackgroundImage:[UIImage imageNamed:@"searchbtn.png"] forState:0];
            [search setTitle:@"比  较" forState:0];
            search.backgroundColor = [UIColor clearColor];
            search.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            search.titleLabel.textColor = [UIColor whiteColor];
            search.frame=CGRectMake(60, 5, 200, 40);
            [search addTarget:self action:@selector(searchJob:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:search];
            
            break;
        }
        default:
            break;
    }
    return cell;
}
-(UIView *)searchConditions
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)]autorelease];
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    for (int i = 0;i<6;i++) {
        UILabel *tmpLable  = [[[UILabel alloc]initWithFrame:CGRectMake(5, 150/6 * i, 320, 150/6)] autorelease];
        NSArray *subLableStr = [NSArray arrayWithObjects:@"地区:",@"行业:", @"企业性质:",@"职位类别:",@"职位级别:",@"期望月薪:",nil];
      //  NSLog(@"%@",self.secondRowSource);
       NSString *str1  = [self.secondRowSource objectForKey:[NSString stringWithFormat:@"%d",i+1]];
       // NSLog(@"%@",str1);
        NSString *str2 = [subLableStr objectAtIndex:i];
        tmpLable.text = [str2 stringByAppendingString:str1];
        tmpLable.font = [UIFont systemFontOfSize:14.0f];
        tmpLable.backgroundColor = [UIColor clearColor];
        [view addSubview:tmpLable];
    
    }
    
    view.tag = 5000;
    
    
    return view;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.row == 0 && self.secondRowChangeState == NO) {
        self.secondRowChangeState = YES;
        [tableView reloadData];
    }
    else
    {
        self.secondRowChangeState = NO;
        
        [tableView reloadData];
    }
       if (indexPath.row == 5) {
        SearchBtnMoreViewController *searchView = [[SearchBtnMoreViewController alloc]init];
           searchView.delegate = self;

        tmpIndexPath = indexPath;
       // SearchBtnMoreViewController *searchView = [[SearchBtnMoreViewController alloc]init];
        searchView.selectIndexPath = indexPath;
       // searchView.delegate =self;
        [self.navigationController pushViewController:searchView animated:YES];
        
        [searchView release];
    }
    //TODO:修改
    if (indexPath.row == 6 && isEditStatus) 
        
        {
            
            SearchBtnMoreViewController *searchView = [[SearchBtnMoreViewController alloc]init];
            searchView.delegate = self;
            
            //tmpIndexPath = indexPath;
            searchView.selectIndexPath = indexPath;
            ChangeCell *cell =(ChangeCell *) [tableView cellForRowAtIndexPath:tmpIndexPath];
            searchView.compareIndexString = cell.subLabel.text;
            // searchView.delegate =self;
            [self.navigationController pushViewController:searchView animated:YES];
            
            [searchView release];
            
        }
    
    
     
}
-(void)SearchBtnMoreViewController:(SearchBtnMoreViewController *)aViewController withSelectString:(NSString *)aStr withIndexPath:(NSIndexPath *)aPath withIndexPathRow:(int)aInt withIsEdit:(BOOL)aBool
{  if(aPath.row == 5 && aBool){
    ChangeCell *cell = (ChangeCell *)[self.maintableView cellForRowAtIndexPath:aPath];
    cell.subLabel.textColor = [UIColor blackColor];
    cell.subLabel.text = aStr;
    SalaryQuerylist *list = [SalaryQuerylist ShareSalaryQuerylist];
    NSArray *tmpArray = [NSArray arrayWithObjects:list.citys,list.industry,list.corpproperty,list.jobcat,list.joblevel, nil];
    sixlable.text = [[[[tmpArray objectAtIndex:aInt] objectAtIndex:0]objectForKey:@"name"] objectForKey:@"text"];
    [self querylistForIdThrough:aStr withID:[[[[tmpArray objectAtIndex:aInt] objectAtIndex:0]objectForKey:@"id"] objectForKey:@"text"]];
    sixlable.textColor = [UIColor blackColor];
   // [sixlable retain];
    isEditStatus = aBool;
}
    else
    {
        ChangeCell *cell = (ChangeCell *)[self.maintableView cellForRowAtIndexPath:aPath];
        cell.subLabel.textColor = [UIColor blackColor];
        cell.subLabel.text = aStr;
    }
   
}
-(void)SearchBtnMoreViewController:(SearchBtnMoreViewController *)aViewController withCompareIndexString:(NSString *)aStr withIndexPath:(NSIndexPath *)aPAth withIDString:(NSString *)aId
{
    [self querylistForIdThrough:aStr withID:aId];
    }
-(void)querylistForIdThrough:(NSString *)aStr withID:(NSString *)aId
{

    if (aStr.length != 0) {
        SalaryQuerylist *que = [SalaryQuerylist ShareSalaryQuerylist];
        NSArray *array = [NSArray arrayWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"职位级别",nil];
        int  row = [array indexOfObject:aStr];
        
        
        switch (row) {
            case 0:
            {
                que.cityid = aId;
                break;
            }
            case 1:
            {
                que.industryid = aId;
                break;
            }
            case 2:
            {
                que.corppropertyid = aId;
                break;
            }
            case 3:
            {
                que.jobcatid = aId;
                break;
            }
            case 4:
            {
                que.joblevelid = aId;
                break;
                
            }
            default:
                break;
        }
        
        
    }
    

}
@end
