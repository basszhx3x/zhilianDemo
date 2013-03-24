//
//  EducationViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-2-27.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "EducationViewController.h"
#import "XMLReader.h"
@interface EducationViewController ()

@end
static NSDictionary *dic;
@implementation EducationViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = @"选择学历要求";
        self.educationArr = [NSMutableArray array];
        [self.educationArr retain];

    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self education];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)education
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"basedata" ofType:@"xml"];
    NSError *errors = [[NSError alloc] init];
    NSData *data = [NSData dataWithContentsOfFile:path];
    dic = [XMLReader dictionaryForXMLData:data error:&errors];
//    dic = [XMLReader dictionaryForXMLString:path error:&errors];
    NSMutableDictionary *rootDic = [NSMutableDictionary dictionary];
    rootDic = [dic valueForKey:@"root"];
    NSLog(@"rootdic--------------->%@",rootDic);
    NSMutableDictionary *basedataDic = [rootDic valueForKey:@"basedata"];
    NSLog(@"basedatadic--------------->%@",basedataDic);
    NSMutableDictionary *educationDic = [basedataDic valueForKey:@"education"];
    NSLog(@"educationDic--------------->%@",educationDic);
    NSMutableArray *ItemArr = [NSMutableArray array];
    ItemArr = [educationDic valueForKey:@"item"];
    for (NSMutableDictionary *ItemDic in ItemArr)
    {
        NSMutableString *codeStr = [ItemDic valueForKey:@"code"];
        NSMutableString *textStr = [ItemDic valueForKey:@"text"];
        NSArray *arrs = [NSArray array];
        arrs = [textStr componentsSeparatedByString:@" "];
        
        NSString *Newstr = [arrs objectAtIndex:[arrs count]-1];

        NSMutableArray *arr = [NSMutableArray arrayWithObjects:codeStr,Newstr, nil];
        [self.educationArr addObject:arr];
    }
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.educationArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.educationArr objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.*/
    if ([self.delegate respondsToSelector:@selector(EducationViewController:educationStr:educationID:)])
    {
        [self.delegate EducationViewController:self educationStr:[tableView cellForRowAtIndexPath:indexPath].textLabel.text educationID: [[self.educationArr objectAtIndex:indexPath.row] objectAtIndex:0]];
    }
     [self.navigationController popViewControllerAnimated:YES];
     
}

@end
