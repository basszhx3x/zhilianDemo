//
//  InstanceRecommendViewController.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//
#import "CompanyDetailInfoViewControllerzhx.h"
#import "CompanyEntry.h"
#define KFRAME(x,y,width,height) CGRectMake(x,y,width,height)
#import "RealtimeRecommentCell.h"
#import "InstanceRecommendViewController.h"
#import "RequestDataforRealtime.h"
#import <QuartzCore/QuartzCore.h>
#import "CompanyDetailInfoViewController.h"
#define ERRORTAPWITH @"没有找到key对应的值, 将重新请求数据 "
#define ERRORDATA @"数据不完整 ，将重新请求数据"
@interface InstanceRecommendViewController ()

@end

@implementation InstanceRecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //注册通知，获取utiket
//        utiket=[NSDictionary dictionary];
//        [utiket retain];
        isFirstShow = YES;
        resultDictionary = [[NSMutableDictionary alloc]init];
        self.selectCellArray = [NSMutableArray array];
        self.applyjob_jobtitles = [NSMutableArray array];
        NSNotificationCenter * center=[NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(getNotification:) name:@"utiket" object:nil];
        self.sourceDictionary = [NSMutableDictionary dictionary];
        
        sectionArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)dealloc
{
    NSNotificationCenter * center=[NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [_selectCellArray release];_selectCellArray = nil;
    [_applyjob_jobtitles release];_applyjob_jobtitles = nil;
    [positionlistSource release];positionlistSource = nil;
    [mainTabelView release];mainTabelView=nil;
    [resultDictionary release];resultDictionary = nil;
    [myClass release];myClass = nil;
    [super dealloc];
    

}

-(void)loadView
{
    
    self.view=[[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"centerBackground"]];
    self.title=@"实时推荐";
    
    myClass = [[MyClassUseOften alloc]init];
    isDsAppearStatus = NO;
    positionlistSource = [[Positionlist alloc]init];
    positionlistSource.positions = [NSMutableArray array];
  // NSLog(@"%@",[UIFont familyNames]);
    
    id tmpID = [myClass loadResultDataFromLibraryCachesWithFilename:@"RealTimeRecomments"];
    if (tmpID) {
        [self.sourceDictionary setDictionary:tmpID];
        
    
    }
  
    
}

-(void)requestData
{
    static int z=0;
    static int n = -1;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   
          [dic setObject:utiket forKey:@"uticket"];
    
  
     if (!isDsAppearStatus && z<5) {
    RequestDataforRealtime * request = [RequestDataforRealtime requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/job/recommendjob.aspx" withHttpMethod:@"GET" withParams:dic];
    [request setResultData:^(id aid, NSError *error) {
        z++;
       // NSLog(@"%@",aid);
        if (error) {
            NSLog(@"请求到的数据有错误 == %@",[error description]);
            if (!isDsAppearStatus) {
                [self requestData];

            }
            
        }
        else
        {
            
            [resultDictionary setDictionary:aid];
            n=-1;
            if (resultDictionary.count != 0 ) {
                [self.sourceDictionary removeAllObjects];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setDictionary:[self xMlResultDictionaryWithDic:aid withKey:@"jobrecommend"]];
                NSMutableArray *positionLists = [NSMutableArray array];
                
                [self.applyjob_jobtitles  setArray:[self xMlResultDictionaryWithDic:dic withKey:@"job_title"]];
                [positionLists setArray:[self xMlResultDictionaryWithDic:dic withKey:@"positionlist"]];

                
                for (int j = 0; j< positionLists.count; j++) {
                    n++;
                    id tmpID = [[positionLists objectAtIndex:j] objectForKey:@"position"];
                  //  NSLog(@"%@",tmpID);
                    if ([tmpID isKindOfClass:[NSArray class]]&& [(NSArray *)tmpID count] !=1) {
                        
                        NSArray *array10 = [NSArray arrayWithObjects:[self.applyjob_jobtitles objectAtIndex:j], tmpID, nil];
                        [self.sourceDictionary setObject:array10 forKey:[NSString stringWithFormat:@"%d",n]];
                        
                    }
                    else
                        n--;
                
                    
                }
                
                
                if (self.sourceDictionary.count != 0 &&!isDsAppearStatus) {
                     [mainTabelView reloadData];
                }
                else
                    [self requestData];
                
                
                    [myClass writeResultDataToLibraryPath:self.sourceDictionary withFileName:@"RealTimeRecomments"];
                    
                    
                   
                }
                    
                       
            //NSLog(@"%@",positionlistSource.positions);
           // [mainTabelView reloadData];
        }
    }];
    [request connect];
     }
    else
    {
        [self showTip:@"请求次数过多 终止请求"];
    }
}

-(void)showTip:(NSString *)tipInfor
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(160-100, (480-44-20-49)/2-40, 200, 40)];
    lable.text = tipInfor;
    lable.layer.borderColor = [UIColor blackColor].CGColor;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.layer.borderWidth = 1.0f;
    lable.layer.cornerRadius = 5.0f;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.numberOfLines = 2;
    lable.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lable];
    [UIView animateWithDuration:1.0 animations:^{
        lable.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [lable removeFromSuperview];
        [lable release];
        
        if (isFirstShow) {
            self.tabBarController.selectedIndex = 1;
            UIView * view = [ self.tabBarController.view viewWithTag:3000];
            
            UIButton * btn1 = (UIButton *)[view viewWithTag:1001];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"btn" object:nil userInfo:[NSDictionary dictionaryWithObject:btn1 forKey:@"btn1"]];
        }
        
        
        
    }];


}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    isDsAppearStatus = YES;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isDsAppearStatus = NO;
    [self.tabBarController.view viewWithTag:3000].frame = CGRectMake(0, 480-49, 320, 49);
    [self.tabBarController.view viewWithTag:3000].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bigdownPic.png"]];

    
    UIButton * apply=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    apply.frame=CGRectMake(0, 0, 50, 30);
    [apply setTitle:@"申请" forState:0];
    [apply setTitleColor:[UIColor whiteColor] forState:0];
    apply.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [apply setBackgroundImage:[UIImage imageNamed:@"setting-button.png"] forState:0];
    [apply setBackgroundImage:[UIImage imageNamed:@"setting-button-click.png"] forState:UIControlStateHighlighted];
    [apply addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:apply] autorelease];
    
        if (utiket.length != 0) {
        mainTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44-20-49) style:UITableViewStyleGrouped];
        mainTabelView.delegate = self;
        mainTabelView.dataSource = self;
      //  mainTabelView.sectionFooterHeight = 10.0f;
        mainTabelView.backgroundView.alpha = 0.0f;
        [self.view addSubview:mainTabelView];
            if (isFirstShow) {
                [self requestData];
                isFirstShow = NO;
            }

        
        [mainTabelView release];
        
               
        
          }
    else
    {        
        [self showTip:@"请首先登陆"];
               
    }
    

}

-(id)xMlResultDictionaryWithDic:(NSDictionary *)dic withKey:(NSString *)keyStr
{
   // NSMutableArray *tmpdic = [NSMutableArray array];
        NSArray *arry = [dic allKeys];
    if ([arry containsObject:keyStr]) {
       
        id tmpID = [dic objectForKey:keyStr];
        return tmpID;
    }
    else
    {
        for (NSString * key in arry) {
            id tmpID = [dic objectForKey:key];
            if ([tmpID isKindOfClass:[NSDictionary class]]) {
                id secId = [self xMlResultDictionaryWithDic:tmpID withKey:keyStr];
                if (secId) {
                    return secId;
                }
            }
            if ([tmpID isKindOfClass:[NSArray class]]) {
               // NSLog(@"%@",tmpID);
                id secId = [self XMlResultWithArray:tmpID withKey:keyStr];
                if (secId) {
                    return  secId;

                }
            }
        }
    }
    return nil;
        
}
-(id)XMlResultWithArray:(NSArray *)aArray withKey:(NSString *)key
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (id aID in aArray) {
       // NSLog(@"%@",aID);
        if ([aID isKindOfClass:[NSString class]]) {
            return nil;
            
        }
        if ([aID isKindOfClass:[NSDictionary class]]) {
            id secId = [self xMlResultDictionaryWithDic:aID withKey:key];
            if (secId) {
                [tmpArray addObject:secId];
            }
            
           // [tmpArray addObject:[self xMlResultDictionaryWithDic:aID withKey:key]];
        }
        if ([aID isKindOfClass:[NSArray class]]) {
            id secID = [self XMlResultWithArray:aID withKey:key];
            if ([(NSArray *)secID count] != 0) {
                return secID;
            }
        }
    }
    if (tmpArray .count != 0) {
        return tmpArray;
    }
    return nil;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
    

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
#pragma mark -tableView method-
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.sourceDictionary.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *arr = [self.sourceDictionary objectForKey:[NSString stringWithFormat:@"%d",section]];

    return [(NSArray *)[arr objectAtIndex:1] count];

}
-(NSString *)stringWithstringKey:(NSString *)keyString withIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [NSMutableArray array];
    [array setArray:[self.sourceDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]]];
    NSString *str1 = nil;
            
    str1 = [[[[array objectAtIndex:1] objectAtIndex:indexPath.row] valueForKey:keyString] valueForKey:@"text"];
       
    
    if (str1) {
        return [self removeWhitespaceAndNewlineCharacter:str1];
    }
    
    return nil;
    
    
}
-(id)sectionFromPositions:(int)aSectionInt
{
    return [positionlistSource.positions objectAtIndex:aSectionInt];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    RealtimeRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[RealtimeRecommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        cell.isSelectState = NO;
    }
//    for (UIView *view in cell.subviews) {
//        [view removeFromSuperview];
//    }
    if (self.sourceDictionary.count != 0 ) {
        cell.jobName.text = [self stringWithstringKey:@"job_title" withIndexPath:indexPath];
        cell.companyName.text = [self stringWithstringKey:@"company_name" withIndexPath:indexPath];
        [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"select_icon.png"] forState:UIControlStateSelected];
        [cell.chooseImg addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.post_ratio.text = [[self stringWithstringKey:@"post_ratio" withIndexPath:indexPath] stringByAppendingString:@"的人投递了该职位"];
        cell.date.text = [self stringWithstringKey:@"opening_date" withIndexPath:indexPath];
        cell.address.text = [self stringWithstringKey:@"job_city" withIndexPath:indexPath];
        cell.company_number = [self stringWithstringKey:@"company_number" withIndexPath:indexPath];
        cell.job_number = [self stringWithstringKey:@"job_number" withIndexPath:indexPath];
    }
        if (self.selectCellArray.count != 0)
        {
        
           // for (NSIndexPath *indexP in  self.selectCellArray) {
            
                if ([self.selectCellArray containsObject:indexPath]) {

                    [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"select_icon.png"] forState:0];
                }
                else
                {
                    [cell.chooseImg setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
                    
                }

            
       
 
        }
        
    
    
    
    
    return cell;


}
-(void)doAction:(UIButton *)sender
{
    NSIndexPath *path = [mainTabelView indexPathForCell:(RealtimeRecommentCell *)sender.superview];

    if (sender.currentBackgroundImage == [UIImage imageNamed:@"unselect_icon.png"]) {
        //self.isSelectState = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"select_icon.png"] forState:0];

        if ([sender.superview isKindOfClass:[RealtimeRecommentCell class]]  && ![self.selectCellArray containsObject:path]) {
            
           // NSLog(@"%@",[mainTabelView indexPathForCell:(RealtimeRecommentCell *)sender.superview]);
            
            [self.selectCellArray addObject:[[path copy] autorelease]];
            ;
            
        }
     //   NSLog(@"%@",self.selectCellArray);

    }
    else
    {
       // self.isSelectState = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"unselect_icon.png"] forState:0];
       // NSIndexPath *path = [mainTabelView indexPathForCell:(RealtimeRecommentCell *)sender.superview];
        if ([self.selectCellArray containsObject:path]) {
            [self.selectCellArray removeObject:path];
        }
        
       //  NSLog(@"%@",self.selectCellArray);
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UIView *view = [[[UIView alloc]initWithFrame:KFRAME(0, 0, 320, 60)]autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:KFRAME(15, 0, 300, 60)];
    lable.backgroundColor = [UIColor clearColor];
    NSString *str1 = @" ";

       
   // NSRange rang = [str rangeOfString:@"申请了【"];
    
    
    if (self.sourceDictionary.count != 0) {
       // NSString *str1 = [self removeWhitespaceAndNewlineCharacter:[[self.applyjob_jobtitles objectAtIndex:section] objectForKey:@"text"]];
      //  if (NULL != str1 && str1.length != 0) {
       //     NSLog(@"str1 = == %@",str1);
        //    [str insertString:str1 atIndex:rang.location+rang.length];
//
      //  }
        NSArray *arr = [self.sourceDictionary objectForKey:[NSString stringWithFormat:@"%d",section]];
        NSString *str = [[arr objectAtIndex:0] objectForKey:@"text"];
        if (str) {
            str1 = [self removeWhitespaceAndNewlineCharacter:str];
  
        }


    }
    NSMutableString *str = [NSMutableString stringWithFormat:@"申请了【%@】的人,还申请了以下职位",str1];
    

    lable.textColor = [UIColor lightTextColor];
    lable.text = str;
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    lable.numberOfLines = 2;
   // lable.font = [UIFont fontWithName:@"Arial" size:16.0f];
    lable.font = [UIFont boldSystemFontOfSize:16.0f];
    [view addSubview:lable];
    [lable release];
    return view;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        RealtimeRecommentCell *cell = (RealtimeRecommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (cell.job_number.length != 0) {
        CompanyEntry *company = [[CompanyEntry alloc]initWithJob_number:cell.job_number];
        [company setresultWtihObject:^(id companyWithResult) {
            
            CompanyDetailInfoViewControllerzhx *Acompany = [[CompanyDetailInfoViewControllerzhx alloc]init];
            Acompany.Job_number  = cell.job_number;
            Acompany.uiuticket = utiket;
            Acompany.companyDetail = company;
            [self.navigationController pushViewController:Acompany animated:YES];
            [Acompany release];
            
            }];
        [company requestData];
        [company release];
        
       
    
    }
}
-(NSString *)removeWhitespaceAndNewlineCharacter:(NSString *)aStr
{
    NSMutableString *str = [NSMutableString string];
    [str setString:aStr];
    [str setString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return str;
}
#pragma  mark -selffuc-
-(void)apply:(UIBarButtonItem *)sender
{
    UIAlertView * apply=[[[UIAlertView alloc] initWithTitle:nil message:@"请选择要投递的简历" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:nil, nil]autorelease];
    
    
    
    
    [apply show];
}

-(void)getNotification:(NSNotification *)sender
{
    utiket = [sender.userInfo objectForKey:@"uticket"];
}

@end
