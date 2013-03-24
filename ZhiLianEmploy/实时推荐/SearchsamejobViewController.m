//
//  SearchsamejobViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-3-4.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "CompanyDetailInfoViewControllerzhx.h"
#import "SearchsamejobViewController.h"
#import "RealtimeRecommentCell.h"
@interface SearchsamejobViewController ()

@end

@implementation SearchsamejobViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.Source = [NSMutableArray array];
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myClass = [[MyClassUseOften alloc]init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self.tabBarController.view viewWithTag:3000] setFrame:CGRectMake(0, 480, 320, 480)];
    [self.tabBarController.view viewWithTag:3000].backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (self.Source.count!=0) {
        return self.Source.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RealtimeRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[RealtimeRecommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    // Configure the cell...
    [cell.accessoryImg removeFromSuperview];
    if (self.Source.count != 0) {
        cell.jobName.text = [myClass removeHeadAndTailWhitespaceAndNewlineCharacter:[[[myClass XMlResultWithArray:self.Source withKey:@"job_title"] objectAtIndex:indexPath.row] objectForKey:@"text"]];
        cell.post_ratio.text = [myClass removeHeadAndTailWhitespaceAndNewlineCharacter:[[[myClass XMlResultWithArray:self.Source withKey:@"company_name"] objectAtIndex:indexPath.row] objectForKey:@"text"]];
        cell.companyName.transform = CGAffineTransformMakeTranslation(200, 0);
        cell.companyName.text = [myClass removeHeadAndTailWhitespaceAndNewlineCharacter:[[[myClass XMlResultWithArray:self.Source withKey:@"job_city"] objectAtIndex:indexPath.row] objectForKey:@"text"]];
        cell.job_number = [myClass removeHeadAndTailWhitespaceAndNewlineCharacter:[[[myClass XMlResultWithArray:self.Source withKey:@"job_number"] objectAtIndex:indexPath.row] objectForKey:@"text"]];

    }
       
    return cell;
}
-(NSString *)stringWithIndexPath:(NSIndexPath *)aPAth withKey:(NSString *)key
{
    return nil;

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
    
    RealtimeRecommentCell *cell = (RealtimeRecommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.job_number.length != 0) {
        CompanyEntry *company = [[CompanyEntry alloc]initWithJob_number:cell.job_number];
        [company setresultWtihObject:^(id companyWithResult) {
            
            CompanyDetailInfoViewControllerzhx *Acompany = [[CompanyDetailInfoViewControllerzhx alloc]init];
            Acompany.Job_number  = cell.job_number;
            Acompany.uiuticket = self.utiket;
            Acompany.companyDetail = company;
            [self.navigationController pushViewController:Acompany animated:YES];
            [Acompany release];
            
        }];
        [company requestData];
        [company release];
        
        
        
    }




}

@end
