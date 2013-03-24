//
//  OtherJobChristopherViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-4.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "CompanyDetailInfoViewControllerzhx.h"
#import "CompanyEntry.h"
#import "OtherJobChristopherViewController.h"
#import "OtherJobCell.h"
@interface OtherJobChristopherViewController ()

@end

@implementation OtherJobChristopherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.jobsArray = [NSMutableArray array];
    }
    return self;
}
-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)]autorelease];
    self.view.backgroundColor=[UIColor whiteColor];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self.tabBarController.view viewWithTag:3000] setFrame:CGRectMake(0, 480, 320, 480)];
    [self.tabBarController.view viewWithTag:3000].backgroundColor = [UIColor clearColor];
    
    
    if (self.jobsArray.count != 0) {
        mtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.jobsArray.count*30) style:UITableViewStylePlain];
        mtableView.delegate = self;
        mtableView.dataSource = self;
        mtableView.rowHeight = 30.0f;
        [self.view addSubview:mtableView];
        [mtableView release];
    }
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    OtherJobCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (!cell) {
        cell = [[[OtherJobCell alloc]initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    }
    cell.CellLabel.text = [[[self.jobsArray objectAtIndex:indexPath.row] objectForKey:@"job_title"] objectForKey:@"text"];
    cell.Job_number = [[[self.jobsArray objectAtIndex:indexPath.row] objectForKey:@"job_number"] objectForKey:@"text"];
   // NSLog(@"%@",cell.Job_number);
    return cell;

}
-(void)viewDidDisappear:(BOOL)animated
{

}

-(void)setPopValue:(popValueForSelectResultBlock)block;
{
    [popValue release];
    popValue = [block copy];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherJobCell *cell =(OtherJobCell *)[tableView cellForRowAtIndexPath:indexPath];
    //[self.navigationController popViewControllerAnimated:YES];
    if (cell.Job_number.length != 0) {
        CompanyEntry *company = [[CompanyEntry alloc]initWithJob_number:[cell.Job_number stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        [company setresultWtihObject:^(id companyWithResult) {
           
           // NSArray *arr = self.navigationController.viewControllers;
           // CompanyDetailInfoViewControllerzhx *Acompany = [arr objectAtIndex:1];
           // Acompany.companyDetail = company;
            if ([self.delegate respondsToSelector:@selector(OtherJobChristopherViewController:withcompany:withIsOtherJob:)]) {
                [self.delegate OtherJobChristopherViewController:self withcompany:company withIsOtherJob:YES];
            }
            [self.navigationController popViewControllerAnimated:YES];
         //   [Acompany release];
            
        }];
        [company requestData];
        [company release];
        
        
        
    }


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
