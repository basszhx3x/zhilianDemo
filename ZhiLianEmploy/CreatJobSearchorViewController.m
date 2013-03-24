//
//  CreatJobSearchorViewController.m
//  ZhiLianEmploy
//
//  Created by li jinyang on 13-2-24.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "CreatJobSearchorViewController.h"
#import "SearchDetailConditionViewController.h"
#import "ChangeCell.h"
#import "CanClickCell.h"
#import "HasTextCell.h"
#import "SalaryCell.h"
#import "CallBackCell.h"
#import "BaseData.h"
#import "NSString+removeSaceAndEnter.h"

@interface CreatJobSearchorViewController ()

@end

@implementation CreatJobSearchorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        titleArr1=[[NSMutableArray alloc] initWithObjects:@"选择职业:",@"选择行业:",@"选择地区:",@"",@"更多搜索条件:", nil];
        titleArr2=[[NSMutableArray alloc] initWithObjects:@"搜索器保存名称", nil];
        subTitleArr=[[NSMutableArray alloc] initWithObjects:@"请选择职位类型",@"请选择行业",@"请选择地区",@"",@"", nil];
        
        NSArray * objectArr=[NSArray arrayWithObjects:titleArr1,titleArr2, nil];
        
        NSArray * keyArr=[NSArray arrayWithObjects:@"a",@"b", nil];
        dic=[[NSDictionary alloc] initWithObjects:objectArr forKeys:keyArr];
        moreArr=[[NSMutableArray alloc] init];
        self.ADictionary=[[[NSMutableDictionary alloc] init] autorelease];
        self.backSubTitle=[[[NSMutableArray alloc] initWithObjects:@"请选择职位类型",@"请选择行业",@"请选择地区",@"",@"请选择发布时间",@"",@"请选择学历要求",@"请选择公司性质",@"请选择公司规模",@"不选择",@"", nil] autorelease];
        
        //获取月薪数据
        salaryDataArr=[[NSMutableArray alloc] init];
        BaseData * data=[BaseData getInstance];
        salaryArr=[data getSalary];

        for (NSArray* arr in salaryArr)
        {
            NSString * str=[arr objectAtIndex:1];
            [salaryDataArr addObject:[str removeSpaceAndEnter:str]];
        }
   
    }
    
    
    return self;
}

-(void)dealloc
{
    [_myScrollView release];
    [titleArr1 release];
    [titleArr2 release];
    [subTitleArr release];
    [salaryDataArr release];
    [moreArr release];
    [dic release];
    [_myTableView release];
    [super dealloc];

}

-(void)loadView
{
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
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
    self.title=@"创建职位搜索器";
    
    self.myScrollView =[[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    
    [self.view addSubview:self.myScrollView];
    
    self.myTableView=[[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped] autorelease];
    self.myTableView.delegate=self;
    self.myTableView.backgroundView.alpha=0;
    self.myTableView.dataSource=self;
//    self.myTableView.sectionHeaderHeight=25;
    [self.myScrollView addSubview:self.myTableView];
    
    UILabel * SectionTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    SectionTitle.text=@"搜索条件";
    SectionTitle.textColor=[UIColor whiteColor];
    SectionTitle.font=[UIFont fontWithName:@"Arial" size:16];
    SectionTitle.backgroundColor=[UIColor clearColor];
    [self.myTableView addSubview:SectionTitle];
    [SectionTitle release];
    
    save=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [save setBackgroundImage:[UIImage imageNamed:@"searchbtn.png"] forState:0];
    [save setTitle:@"保存" forState:0];
    [save setTitleColor:[UIColor whiteColor] forState:0];
    save.titleLabel.font=[UIFont fontWithName:@"Arial" size:18];
    [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myTableView addSubview:save];
    
    //为更多抖索条件添加点击事件
    moreView=[[UIView alloc] initWithFrame:CGRectMake(0, 151, 320, 31)];
    moreView.userInteractionEnabled=YES;
    moreView.backgroundColor=[UIColor clearColor];
    [self.myTableView addSubview:moreView];
    [moreView release];
    
    UITapGestureRecognizer * moreTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [moreView addGestureRecognizer:moreTap];
    [moreTap release];
    
    //添加月薪选择器
    salaryPick=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 300-49)];
    salaryPick.dataSource=self;
    salaryPick.delegate=self;
    salaryPick.showsSelectionIndicator=YES;
    [self.view addSubview:salaryPick];
    [salaryPick release];
    
    self.myActionSheet=[[[UIActionSheet alloc]init] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -tableViewFunc-
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
     return @"";  
      
    }
    
    else
    {
    return @"";
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section==0) {
        tableView.sectionHeaderHeight=30;
    
    }
    
    else
    {
        tableView.sectionHeaderHeight=5;
    }
    
    return tableView.sectionHeaderHeight;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row>5)
    {
        self.myScrollView.contentSize=CGSizeMake(320, 600);
    }
    else
    {
        self.myScrollView.contentSize=CGSizeMake(320, 200);
        
    }
    
    save.frame=CGRectMake(60, 30+10+([titleArr1 count]+1)*30+30, 200, 40);
    return 30;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
   
        
        return [titleArr1 count];
    }
    
    if (section==1) {
         return 1;
    }
    else
        return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section==0)
        {
            if (indexPath.row<3)
            {
        static NSString * cellIdentifier=@"cell";
        ChangeCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (nil==cell)
        {
            cell=[[[ChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
         
        cell.CellLabel.text=[titleArr1 objectAtIndex:indexPath.row];
        cell.subLabel.text=[self.backSubTitle objectAtIndex:indexPath.row];
        if (self.backSubTitle!=nil)
        {
            NSString * str=[self.backSubTitle objectAtIndex:indexPath.row];
            if ([str length]>3) {
                NSRange p=NSMakeRange(0, 3);
                NSString * str1=[str substringWithRange:p];
//                NSLog(@"%@",str1);
                if ([str1 isEqualToString:@"请选择"]||[str1 isEqualToString:@"不选择"]) {
                    
                    return cell;
                }
                else
                {
                    cell.subLabel.textColor=[UIColor blackColor];
                    return cell;
                }

            }
           
        }
               
        
        if ( cell.subLabel.textColor==[UIColor blackColor])
        {
            cell.subLabel.textColor=[UIColor lightGrayColor];
        }
   
             return cell;
            }
    
        if (indexPath.row==3)
        {
            static NSString * cellIdentifier1=@"cell1";
            HasTextCell* cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (nil==cell)
            {
                cell=[[[HasTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
            }
            
            cell.titleLabel.text=@"关键字:";
            return cell;
      
            
        }
            
        
    if (indexPath.row>=4)
            {
        if ([titleArr1 count]==5) {
            static NSString * cellIdentifier1=@"cell2";
            CanClickCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
            if (nil==cell)
            {
                cell=[[[CanClickCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
            }
            
            cell.titleLabel.text=@"更多搜索条件";
            return cell;

        }
                
        if (indexPath.row<9) {
                static NSString * cellIdentifier=@"cell";
                ChangeCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (nil==cell)
                {
                    cell=[[[ChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
                }
                
                cell.CellLabel.text=[titleArr1 objectAtIndex:indexPath.row];
                cell.subLabel.text=[self.backSubTitle objectAtIndex:indexPath.row];
            
            if (self.backSubTitle!=nil) {
                NSString * str=[self.backSubTitle objectAtIndex:indexPath.row];
                //保证nsrange不会出错
                if ([str length]>3) {
//                    NSLog(@"%@",str);
                    NSRange p=NSMakeRange(0, 3);
                    NSString * str1=[str substringWithRange:p];
//                    NSLog(@"%@",str1);
                    
                    if ([str1 isEqualToString:@"请选择"]||[str1 isEqualToString:@"不选择"])
                    {
                        
                        return cell;
                    }
                    else
                    {
                        cell.subLabel.textColor=[UIColor blackColor];
                        return cell;
                    }

                }
                
            }

                if ( cell.subLabel.textColor==[UIColor blackColor])
                {
                    cell.subLabel.textColor=[UIColor lightGrayColor];
                }
                
                return cell;
            }
        
        if (indexPath.row==9)
        {
            static NSString * cellIdentifier2=@"cell3";
            SalaryCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (nil==cell)
            {
                cell=[[[SalaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
            }
            cell.titleLabel.text=[titleArr1 objectAtIndex:indexPath.row];
            cell.subLabel.text=[self.backSubTitle objectAtIndex:indexPath.row];
            
            if (self.backSubTitle!=nil)
            {
                NSString * str=[self.backSubTitle objectAtIndex:indexPath.row];
                if ([str length]>3) {
                    NSRange p=NSMakeRange(0, 3);
                    NSString * str1=[str substringWithRange:p];
//                    NSLog(@"%@",str1);
                    if ([str1 isEqualToString:@"请选择"]||[str1 isEqualToString:@"不选择"]) {
                        
                        return cell;
                    }
                    else
                    {
                        cell.subLabel.textColor=[UIColor blackColor];
                        return cell;
                    }
                    
                }
            }
            return cell;
            
        }
                
        if (indexPath.row==10) 
        {
            static NSString * cellIdentifier3=@"cell4";
            CallBackCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
            if (nil==cell)
            {
                cell=[[[CallBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3] autorelease];
            }
                
            cell.titleLabel.text=[titleArr1 objectAtIndex:indexPath.row];
            return cell;
        }
        
        }
        
}
      
    if (indexPath.section==1)
    {
        static NSString * cellIdentifier1=@"cell1";
         HasTextCell* cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (nil==cell)
        {
            cell=[[[HasTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
      
        cell.titleLabel.text=@"搜索器保存名称:";
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row==3)
        {
            HasTextCell* cell=(HasTextCell*)[tableView cellForRowAtIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return;
        }
        
        if (indexPath.row==4&&[titleArr1 count]==5)
        {
        
                return;
        }
        
        if (indexPath.row==9) {
            SalaryCell* cell=(SalaryCell*)[tableView cellForRowAtIndexPath:indexPath];
//            NSLog(@"%@",NSStringFromCGRect(cell.frame));
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return;
        }
        
        if (indexPath.row==10) {
            CallBackCell * cell=(CallBackCell *)[tableView cellForRowAtIndexPath:indexPath];
            if ([cell.titleLabel.text isEqualToString:@"收起搜索条件"]) {
                return;
            }
            
        }
            SearchDetailConditionViewController * root=[[SearchDetailConditionViewController alloc] init];
            root.indexpath=indexPath;
            root.delegate=self;
            root.indexPathDic=self.ADictionary;
            [self.navigationController pushViewController:root animated:YES];
            [root release];
       }
    
    if (indexPath.section==1) {
        HasTextCell* cell=(HasTextCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
  
}

#pragma mark-selffunc-
-(void)back:(UIButton *)sender
{
    
    NSArray * arr=self.navigationController.viewControllers;
    
    [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];

}

//保存
-(void)save:(UIButton *)sender
{
    //数据校验
    //选择职业类型
    ChangeCell * cell=(ChangeCell * )[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    if ([cell.subLabel.text  isEqualToString:@"请选择职位类型"]||[cell.subLabel.text  isEqualToString:@""])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"请选择职业类型" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    //选择行业
    ChangeCell * cell1=(ChangeCell * )[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    if ([cell1.subLabel.text  isEqualToString:@"请选择行业"]||[cell.subLabel.text  isEqualToString:@""])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"请选择行业" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    //选择城市
    ChangeCell * cell2=(ChangeCell * )[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
    if ([cell2.subLabel.text  isEqualToString:@"请选择地区"]||[cell.subLabel.text  isEqualToString:@""])
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"请选择城市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    HasTextCell * cell3=( HasTextCell * )[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    if (cell3.text.text==nil)
    {
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"请输入搜索器名称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }

    //获取关键字的参数
//    HasTextCell * cell=( HasTextCell * )[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];

    
    
}


//显示更多条件
-(void)tap:(UITapGestureRecognizer *)sender
{
    [moreView removeFromSuperview];    
        NSArray * arr=[NSArray arrayWithObjects:@"选择职业:",@"选择行业:",@"选择地区:",@"",@"发布时间:",@"工作经验:",@"学历要求:",@"公司性质:"
                       ,@"公司规模:",@"月薪范围:",@"收起搜索条件",nil];
        [titleArr1 removeAllObjects];
        [titleArr1 addObjectsFromArray:arr];
        [subTitleArr removeAllObjects];
        [subTitleArr addObjectsFromArray:self.backSubTitle];
        [self.myTableView reloadData];
    
    callBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 331, 320, 31)];
    callBackView.userInteractionEnabled=YES;
    callBackView.backgroundColor=[UIColor clearColor];
    [self.myTableView addSubview:callBackView];
    [callBackView release];
    
    UITapGestureRecognizer * callBackTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callBackTap:)];
    [callBackView addGestureRecognizer:callBackTap];
    [callBackTap release];
    
    salaryView=[[UIView alloc] initWithFrame:CGRectMake(0, 301, 320, 30)];
    salaryView.userInteractionEnabled=YES;
    salaryView.backgroundColor=[UIColor clearColor];
    [self.myTableView addSubview:salaryView];
    [salaryView release];
    
    UITapGestureRecognizer * salaryTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(salaryTap:)];
    [salaryView addGestureRecognizer:salaryTap];
    [salaryTap release];
}

//收起搜索条件
-(void)callBackTap:(UITapGestureRecognizer *)sender
{
    [callBackView removeFromSuperview];
    [salaryView removeFromSuperview];
    NSArray * arr=[NSArray arrayWithObjects:@"选择职业:",@"选择行业:",@"选择地区:",@"",@"更多搜索条件",nil];
    [titleArr1 removeAllObjects];
    [titleArr1 addObjectsFromArray:arr];
    
    NSArray * arr1=[NSArray arrayWithObjects:[self.backSubTitle objectAtIndex:0],[self.backSubTitle objectAtIndex:1],[self.backSubTitle objectAtIndex:2],[self.backSubTitle objectAtIndex:3],[self.backSubTitle objectAtIndex:4],nil];
    [subTitleArr removeAllObjects];
    [subTitleArr addObjectsFromArray:arr1];
    [self.myTableView reloadData];
    
    moreView=[[UIView alloc] initWithFrame:CGRectMake(0, 151, 320, 31)];
    moreView.userInteractionEnabled=YES;
    moreView.backgroundColor=[UIColor clearColor];
    [self.myTableView addSubview:moreView];
    [moreView release];
    
    UITapGestureRecognizer * moreTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [moreView addGestureRecognizer:moreTap];
    [moreTap release];
    
}

//月薪点击事件
-(void)salaryTap:(UITapGestureRecognizer *)sender
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
    [barsArray addObject:twoItem];
    [twoItem release];
    
    toolBar.items = barsArray;
    
    //加载拾取器：
    salaryPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, 320, 220)];
    self.shouldGroupAccessibilityChildren = YES;
    salaryPick.delegate = self;
    salaryPick.dataSource = self;
    salaryPick.showsSelectionIndicator = YES;
    [self.myActionSheet addSubview:salaryPick];
    [salaryPick release];
    [self.myActionSheet addSubview:toolBar];
    [toolBar release];
    [self.myActionSheet showInView:self.view];
    

}

#pragma mark -uipickViewDelegate-
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [salaryDataArr count];

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [salaryDataArr objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.backSubTitle removeObjectAtIndex:9];
    [self.backSubTitle insertObject:[salaryDataArr objectAtIndex:row]  atIndex:9];
    [self.myTableView reloadData];

}

-(void)pickerBarButton:(UIBarButtonItem *)sender
{
    [self.myActionSheet dismissWithClickedButtonIndex:1 animated:YES];
    
}


//自定义代理
-(void)transferSearchJobCondition:(SearchDetailConditionViewController *)aViewController withCondition:(NSString *)aStr withIndexpath:(NSIndexPath *)indexpath withNsdictionary:(NSMutableDictionary *)dictionary
{
    ChangeCell * cell=(ChangeCell *)[self.myTableView cellForRowAtIndexPath:indexpath];
    cell.subLabel.text=aStr;
    cell.subLabel.textColor=[UIColor blackColor];
    [self.ADictionary  setObject:[dictionary objectForKey:indexpath] forKey:indexpath];
    
    //根据传过来的数据，修改数据源
    [self.backSubTitle removeObjectAtIndex:indexpath.row];
    [self.backSubTitle insertObject:aStr atIndex:indexpath.row];
}

@end
