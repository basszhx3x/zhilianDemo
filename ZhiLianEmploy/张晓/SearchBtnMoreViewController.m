//
//  SearchBtnMoreViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-26.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "SearchBtnMoreViewController.h"
#import "Salarypush.h"
@interface SearchBtnMoreViewController ()

@end

@implementation SearchBtnMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(void)dealloc
{
    self.delegate = nil;
    [_mainTableView release];_mainTableView = nil;
    [super dealloc];
}
-(void)loadView
{
    self.view=[[[UIView alloc]initWithFrame:CGRectMake(100, 100, 220, 380)]autorelease];
    self.view.backgroundColor=[UIColor whiteColor];
    
    
//    NSLog(@"%@",self.compareIndexString);
    
    if (self.selectIndexPath.row == 5) {
        self.cellLableStr = [NSArray arrayWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"职位级别",nil];
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 160) style:UITableViewStylePlain];
    }
   else
   {    SalaryQuerylist *list = [SalaryQuerylist ShareSalaryQuerylist];
         NSArray *tmpArray = [NSArray arrayWithObjects:list.citys,list.industry,list.corpproperty,list.jobcat,list.joblevel, nil];
        NSArray *array = [NSArray arrayWithObjects:@"地区",@"行业",@"企业性质",@"职位类别",@"职位级别",nil];
       self.cellLableStr = [tmpArray objectAtIndex:[array indexOfObject:self.compareIndexString]];
       _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
       
   }
    
    
    
    _mainTableView.delegate=self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    [_mainTableView release];
    
    /*citys;
     @property(nonatomic,retain)NSArray *corpproperty;//企业性质
     
     @property(nonatomic,retain)NSArray *industry;//行业
     @property(nonatomic,retain)NSArray *jobcat;//职位类别
     @property(nonatomic,retain)NSArray *joblevel;//职位级别
     @property(nonatomic,retain)NSArray *education;*/
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellLableStr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cell";
    Salarypush *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[Salarypush alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
    }
    if (self.selectIndexPath.row == 5) {
        cell.CellLabel.text = [self.cellLableStr objectAtIndex:indexPath.row];

    }
    else
    {
        cell.CellLabel.text = [[[self.cellLableStr objectAtIndex:indexPath.row] objectForKey:@"name"] objectForKey:@"text"];
    }
    
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Salarypush *cell =(Salarypush *) [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(SearchBtnMoreViewController:withSelectString:withIndexPath:withIndexPathRow:withIsEdit:)]) {
        [self.delegate SearchBtnMoreViewController:self withSelectString:cell.CellLabel.text withIndexPath:self.selectIndexPath withIndexPathRow:indexPath.row withIsEdit:YES];
        
    }
    if ([self.delegate respondsToSelector:@selector(SearchBtnMoreViewController:withCompareIndexString:withIndexPath:withIDString:)] && self.selectIndexPath.row == 6) {
        NSString *idString = [[[self.cellLableStr objectAtIndex:indexPath.row] objectForKey:@"id"] objectForKey:@"text"];
        [self.delegate SearchBtnMoreViewController:self withCompareIndexString:self.compareIndexString withIndexPath:indexPath withIDString:idString];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
