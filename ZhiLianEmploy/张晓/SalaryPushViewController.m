//
//  SalaryPushViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-22.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "Salarypush.h"
#import "SalaryPushViewController.h"
#import "RequestData.h"
#import "SalarySearchViewController.h"
#import "ChangeCell.h"
@interface SalaryPushViewController ()

@end

@implementation SalaryPushViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.sourceDataDictionary = [NSMutableDictionary dictionary];
        self.sourcData = [NSMutableArray array];
        self.salaryQuelist = [[[SalaryQuerylist alloc]init] autorelease];
    }
    return self;
}
-(void)dealloc
{
    [_sourceDataDictionary release];
    [_sourcData release];
//    [self.salaryQuelist release];
    self.delegate = nil;
    self.salaryQuelist = nil;
    [super dealloc];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.bounces = NO;
     NSArray *cellLableStr = [NSArray arrayWithObjects:@"地区:",@"行业:",@"企业性质:",@"职位类别:",@"职位级别:",nil];
    self.index =  [cellLableStr indexOfObject:self.indexTarget];
    if ([self loadDatafromFile].count > 0) {
        [self resuleData:[self loadDatafromFile]];
    }
    
    //NSLog(@"%d",self.aindexPath.row);
    
    RequestData *request = [RequestData requestDataWithURL:@"http://mobileinterface.zhaopin.com/iphone/payquery/querylist.service" withHttpMethod:nil withParams:nil];
    [request setResultData:^(id aid, NSError *error) {
        if (self.sourcData.count == 0) {
             [self resuleData:aid];
        }
       
        [self saveDataTofile:aid];
        
        [self.tableView reloadData];  //citys = 0,
        //industry,//行业
       // corpproperty,//企业性质
       // jobcat,//职位类别
       // joblevel,//职位级别
       // education
    }];
    [request connect];
        

}
-(void)resuleData:(NSDictionary *)aid
{

   
    [self.sourceDataDictionary setDictionary:aid];
    //NSLog(@"%@",aid);
    self.salaryQuelist.citys = [[[self.sourceDataDictionary objectForKey:@"root"] objectForKey:@"citys"] objectForKey:@"city"];
  
    self.salaryQuelist.industry = [[[self.sourceDataDictionary objectForKey:@"root"] objectForKey:@"industrys"] objectForKey:@"industry"];
    self.salaryQuelist.corpproperty = [[[self.sourceDataDictionary objectForKey:@"root"] objectForKey:@"corppropertys"] objectForKey:@"corpproperty"];
    
    self.salaryQuelist.jobcat = [[[self.sourceDataDictionary objectForKey:@"root"] objectForKey:@"jobcats"] objectForKey:@"jobcat"];
    self.salaryQuelist.joblevel = [[[self.sourceDataDictionary objectForKey:@"root"] objectForKey:@"joblevels"] objectForKey:@"joblevel"];
  // NSLog(@"%@",self.salaryQuelist);
    NSArray *tmpArray = [NSArray arrayWithObjects:self.salaryQuelist.citys, self.salaryQuelist.industry,self.salaryQuelist.corpproperty,self.salaryQuelist.jobcat,self.salaryQuelist.joblevel,nil];
   // NSLog(@"%@",tmpArray);
    [self.sourcData setArray:[tmpArray objectAtIndex:self.index]];
    
}
-(void)saveDataTofile:(NSMutableDictionary *)aDic
{
    NSString *homeStr = NSHomeDirectory();
    NSString *sourcePath = [homeStr stringByAppendingPathComponent:@"Documents/salaryQuelist"];
    NSFileManager *file = [NSFileManager defaultManager];
    if (![file fileExistsAtPath:sourcePath]) {
        [file createFileAtPath:sourcePath contents:nil attributes:nil];
    }
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc]initForWritingWithMutableData:data]autorelease];
    [archiver encodeObject:aDic forKey:@"quelist"];
    [archiver finishEncoding];
    [data writeToFile:sourcePath atomically:YES];
    

}
-(NSDictionary *)loadDatafromFile
{
    NSString *homeStr = NSHomeDirectory();
    NSString *sourcePath = [homeStr stringByAppendingPathComponent:@"Documents/salaryQuelist"];
    NSData *data = [NSData dataWithContentsOfFile:sourcePath];
    
    NSKeyedUnarchiver *unArch = [[[NSKeyedUnarchiver alloc]initForReadingWithData:data]autorelease];
    NSMutableDictionary *resultDic = [unArch decodeObjectForKey:@"quelist"];
    [unArch finishDecoding];
  
    return resultDic;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.sourcData.count > 0) {
        return self.sourcData.count;
    }
    
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Salarypush *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[Salarypush alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.CellLabel.text = @"nil";
    
    // Configure the cell...
    
    if (self.sourcData.count > 0) {
        cell.CellLabel.text = [[[self.sourcData objectAtIndex:indexPath.row]objectForKey:@"name"] objectForKey:@"text"];
    }
    
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
  //  NSLog(@"%d",self.aindexPath.row);
    
    
    Salarypush *push = (Salarypush *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *idIndex = [[[self.sourcData objectAtIndex:indexPath.row] objectForKey:@"id"] objectForKey:@"text"];
    
    if ([self.delegate respondsToSelector:@selector(SalaryPushViewController:withTargetString:withIndexPath:)]) {
        [self.delegate SalaryPushViewController:self withTargetString:push.CellLabel.text withIndexPath:self.aindexPath];
    }
    if ([self.delegate respondsToSelector:@selector(SalaryPushViewController:withIdIndex:withINdexPath:)]) {
        [self.delegate SalaryPushViewController:self withIdIndex:idIndex withINdexPath:self.aindexPath];
    }
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
   
}

@end
