//
//  ElseJobMessageViewController.m
//  ZhiLianEmploy
//
//  Created by tony J on 13-3-5.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "ElseJobMessageViewController.h"
#import "RequestData.h"
#import "ElseJobViewController.h"
@interface ElseJobMessageViewController ()

@end
static int i;
@implementation ElseJobMessageViewController
@synthesize CompanyMesTextView = CompanyMesTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"职位信息";
        self.JobNumDic = [NSMutableDictionary dictionary];
        i=0;
        
    }
    return self;
}


-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    
    [self JobMoreMessageData];
    
    UIImageView *linerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayline"]];
    linerView.frame = CGRectMake(0, 400-69, 320, 1);
    [self.view addSubview:linerView];
    [linerView release];
    
    UITableView *tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 400-68, 320, 30) style:(UITableViewStylePlain)];
    tabview.dataSource = self;
    tabview.delegate = self;
    [self.view addSubview:tabview];
    
    _cView = [[UIView alloc] initWithFrame:CGRectMake(0, 480-50, 320, 50)];
    _cView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bigdownPic"]];
    for (int i=0; i<4; i++) {
        UIButton * bView=[[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 50)];
        bView.tag=4000+1000*i;
        [bView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:0];
        [bView addTarget:self action:@selector(jobOperation:) forControlEvents:UIControlEventTouchUpInside];
        [_cView addSubview:bView];
        [bView release];
    }
    [self.tabBarController.view addSubview:_cView];
    [_cView release];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *barbut = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                               style:(UIBarButtonItemStylePlain)
                                                              target:self
                                                              action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem = barbut;
    [barbut release];
    
    UIBarButtonItem *rightbarbut = [[UIBarButtonItem alloc] initWithTitle:@"返回首页"
                                                                    style:(UIBarButtonItemStylePlain)
                                                                   target:self
                                                                   action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightbarbut;
    [rightbarbut release];
    
}
-(void)rightBarButtonAction:(UIBarButtonItem *)sender
{
    [_cView removeFromSuperview];
    [self.tabBarController.view viewWithTag:3000].hidden= NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)leftBarButtonAction:(UIBarButtonItem *)bnt
{
    [_cView removeFromSuperview];
    [self.tabBarController.view viewWithTag:3000].hidden= NO;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)jobOperation:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 4000:
            NSLog(@"1");
            break;
        case 5000:
            NSLog(@"2");
            break;
        case 6000:
            NSLog(@"3");
            break;
        case 7000:
            NSLog(@"4");
            break;
            
            
        default:
            break;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ElseJobViewController *elsejobvc = [[ElseJobViewController alloc] init];
    [elsejobvc.ElseJobNumDic retain];
    elsejobvc.ElseJobNumDic = self.JobNumDic;
    [_cView removeFromSuperview];
    [self.tabBarController.view viewWithTag:3000].hidden= NO;
    [self.navigationController pushViewController:elsejobvc animated:YES];
    [elsejobvc.ElseJobNumDic release];
    [elsejobvc release];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellstr = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellstr];
        cell.textLabel.text = @"该公司其他职位";
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    }
    
    
    return cell;
}

-(void)JobMoreMessageData
{
    NSLog(@"1111111111------%@",self.JobNumDic);
    //    self
    RequestData * Redata = [RequestData requestDataWithURL:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx"
                                            withHttpMethod:@"GET"
                                                withParams:self.JobNumDic];
    [Redata setResultData:^(id aid, NSError *error) {
        NSLog(@"aid----------->%@",aid);
        
        NSDictionary *RootDic = [NSDictionary dictionary];
        RootDic = [aid valueForKey:@"root"];
        NSDictionary *CurrentjobDic = [NSDictionary dictionary];
        CurrentjobDic = [RootDic valueForKey:@"currentjob"];
        
        //        公司介绍
        NSDictionary *companyDic = [NSDictionary dictionary];
        companyDic = [RootDic valueForKey:@"company"];
        
        
        NSDictionary *company_nameDic = [NSDictionary dictionary];
        company_nameDic = [companyDic valueForKey:@"company_name"];
        NSString *company_nameDicText = nil;
        company_nameDicText = [company_nameDic valueForKey:@"text"];
        NSLog(@"%@",company_nameDicText);
        
        //       公司性质 company_property
        NSDictionary *company_propertyDic = [NSDictionary dictionary];
        company_propertyDic = [companyDic valueForKey:@"company_property"];
        NSString *company_propertyDicText = nil;
        company_propertyDicText = [company_propertyDic valueForKey:@"text"];
        NSLog(@"%@",company_propertyDicText);
        
        //        公司规模  company_size
        
        NSDictionary *company_sizeDic = [NSDictionary dictionary];
        company_sizeDic = [companyDic valueForKey:@"company_size"];
        NSString *company_sizeDicText = nil;
        company_sizeDicText = [company_sizeDic valueForKey:@"text"];
        NSLog(@"%@",company_sizeDicText);
        
        //      公司所属行业  industry
        
        NSDictionary *industryDic = [NSDictionary dictionary];
        industryDic = [companyDic valueForKey:@"industry"];
        NSString *industryDicText = nil;
        industryDicText = [industryDic valueForKey:@"text"];
        NSLog(@"%@",industryDicText);
        
        //        地址  address
        
        NSDictionary *addressDic = [NSDictionary dictionary];
        addressDic = [companyDic valueForKey:@"address"];
        NSString *addressDicText = nil;
        addressDicText = [addressDic valueForKey:@"text"];
        NSLog(@"%@",addressDicText);
        
        //        公司介绍  company_desc
        
        NSDictionary *company_descDic = [NSDictionary dictionary];
        company_descDic = [companyDic valueForKey:@"company_desc"];
        NSString *company_descDicText = nil;
        company_descDicText = [company_descDic valueForKey:@"text"];
        NSLog(@"%@",company_descDicText);
        
        self.ComanyAllArr = [NSMutableArray arrayWithObjects:
                             company_nameDicText,
                             company_propertyDicText,
                             company_sizeDicText,
                             industryDicText,
                             addressDicText,company_descDicText, nil];
        [self.ComanyAllArr retain]; 
        
        
        //        职位介绍      
        
        NSDictionary *job_titleDic = [NSDictionary dictionary];
        job_titleDic = [CurrentjobDic valueForKey:@"job_title"];
        NSString *Job_titleText = nil;
        Job_titleText = [job_titleDic valueForKey:@"text"];
        NSLog(@"%@",Job_titleText);
        NSDictionary *salary_rangeDic = [NSDictionary dictionary];        
        //        月薪
        salary_rangeDic = [CurrentjobDic valueForKey:@"salary_range"];
        NSString *salary_rangeText = nil;
        salary_rangeText = [salary_rangeDic valueForKey:@"text"];
        NSLog(@"%@",salary_rangeText);
        //        地点 job_city
        NSDictionary *job_cityDic = [NSDictionary dictionary];        
        
        job_cityDic = [CurrentjobDic valueForKey:@"job_city"];
        NSString *job_cityDicText = nil;
        job_cityDicText = [job_cityDic valueForKey:@"text"];
        NSLog(@"%@",job_cityDicText);
        //        经验  working_exp
        NSDictionary *working_expDic = [NSDictionary dictionary];        
        
        working_expDic = [CurrentjobDic valueForKey:@"working_exp"];
        NSString *working_expDicText = nil;
        working_expDicText = [working_expDic valueForKey:@"text"];
        NSLog(@"%@",working_expDicText);
        //        人数  number
        NSDictionary *numberDic = [NSDictionary dictionary];        
        
        numberDic = [CurrentjobDic valueForKey:@"number"];
        NSString *numberDicText = nil;
        numberDicText = [numberDic valueForKey:@"text"];
        NSLog(@"%@",numberDicText);
        
        //        职位描述  responsibility
        NSDictionary *responsibiltyDic = [NSDictionary dictionary];        
        
        responsibiltyDic = [CurrentjobDic valueForKey:@"responsibilty"];
        NSString * responsibiltyDicText= [responsibiltyDic valueForKey:@"text"];
        
        NSLog(@"111111%@",responsibiltyDicText);
        
        
        self.AllArr = [NSMutableArray arrayWithObjects:Job_titleText , salary_rangeText , job_cityDicText, working_expDicText , numberDicText , responsibiltyDicText , nil];
        [self.AllArr retain];   
        
        if (error)
        {
            NSLog(@"error%@",[error debugDescription]);
        }
        [self JobPagePic];
    }];
    [Redata connect];
}





-(void)JobPagePic
{
    _JobMesTextView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 400-40-69)];
    
    UILabel *jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 20)];
    jobLabel.text = [self.AllArr objectAtIndex:0];
    
    [_JobMesTextView addSubview:jobLabel];
    [jobLabel release];
    
    //   月薪     
    UILabel *MonenyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 20)];
    MonenyLabel.text = @"月薪:";
    [_JobMesTextView addSubview:MonenyLabel];
    [MonenyLabel release];
    UILabel *SecMonenyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 240, 20)];
    SecMonenyLabel.text = [self.AllArr objectAtIndex:1];
    NSLog(@"%@",SecMonenyLabel.text);
    
    //        SecAreaLabel.text = @"月薪:";
    [_JobMesTextView addSubview:SecMonenyLabel];
    [SecMonenyLabel release];
    //   地点     
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    areaLabel.text = @"地点:";
    [_JobMesTextView addSubview:areaLabel];
    [areaLabel release];
    UILabel *SecAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 240, 20)];
    SecAreaLabel.text = [self.AllArr objectAtIndex:2];
    
    //        SecAreaLabel.text = @"月薪:";
    [_JobMesTextView addSubview:SecAreaLabel];
    [SecAreaLabel release];
    //    经验    
    UILabel *expLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
    expLabel.text = @"经验:";
    [_JobMesTextView addSubview:expLabel];
    [expLabel release];
    UILabel *SecExpLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 240, 20)];
    SecExpLabel.text = [self.AllArr objectAtIndex:3];
    
    //        SecAreaLabel.text = @"月薪:";
    [_JobMesTextView addSubview:SecExpLabel];
    [SecExpLabel release];
    //        人数
    UILabel *pepolLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
    pepolLabel.text = @"人数:";
    [_JobMesTextView addSubview:pepolLabel];
    [pepolLabel release];
    UILabel *SecPepolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 240, 20)];
    SecPepolLabel.text = [self.AllArr objectAtIndex:4];
    
    //        SecAreaLabel.text = @"月薪:";
    [_JobMesTextView addSubview:SecPepolLabel];
    [SecPepolLabel release];
    UIImageView *linerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayline"]];
    linerView.frame = CGRectMake(0, 110, 320, 1);
    [_JobMesTextView addSubview:linerView];
    [linerView release];
    UILabel *textmessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 0, 0)];
    textmessage.text = [self.AllArr objectAtIndex:5];
    textmessage.lineBreakMode = 0;
    [textmessage setNumberOfLines:0];
    //    自适应高度
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    CGSize size = CGSizeMake(310, CGFLOAT_MAX);
    CGSize Textmessagelabelsize = [textmessage.text sizeWithFont:font constrainedToSize:size lineBreakMode:0];
    NSLog(@"%f,%f",Textmessagelabelsize.width,Textmessagelabelsize.height);
    [textmessage setFrame:CGRectMake(10, 120, Textmessagelabelsize.width, Textmessagelabelsize.height)];
    [textmessage sizeToFit];
    [_JobMesTextView addSubview:textmessage];
    [textmessage release];
    
    _JobMesTextView.scrollEnabled = YES;
    
    _JobMesTextView.delegate = self;
    _JobMesTextView.contentSize = CGSizeMake(310, 120+textmessage.frame.size.height);
    
    [self.view addSubview:_JobMesTextView];
    [_JobMesTextView release];
}
-(void)companyPagePic
{
    CompanyMesTextView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 400-40-69)];
    
    UILabel *jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 20)];
    jobLabel.text = [self.ComanyAllArr objectAtIndex:0];
    
    [CompanyMesTextView addSubview:jobLabel];
    [jobLabel release];
    
    //   月薪     
    UILabel *MonenyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 20)];
    MonenyLabel.text = @"类别:";
    [CompanyMesTextView addSubview:MonenyLabel];
    [MonenyLabel release];
    UILabel *SecMonenyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 240, 20)];
    SecMonenyLabel.text = [self.ComanyAllArr objectAtIndex:1];
    NSLog(@"%@",SecMonenyLabel.text);
    [CompanyMesTextView addSubview:SecMonenyLabel];
    [SecMonenyLabel release];
    //   地点     
    UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 40, 20)];
    areaLabel.text = @"规模:";
    [CompanyMesTextView addSubview:areaLabel];
    [areaLabel release];
    UILabel *SecAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 240, 20)];
    SecAreaLabel.text = [self.AllArr objectAtIndex:2];
    
    
    [CompanyMesTextView addSubview:SecAreaLabel];
    [SecAreaLabel release];
    //    //    行业    
    UILabel *expLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 40, 20)];
    expLabel.text = @"行业:";
    [CompanyMesTextView addSubview:expLabel];
    [expLabel release];
    
    UILabel *SecExpLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 240, 20)];
    SecExpLabel.text = [self.ComanyAllArr objectAtIndex:3];
    [CompanyMesTextView addSubview:SecExpLabel];
    [SecExpLabel release];
    //    //        地址
    UILabel *pepolLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
    pepolLabel.text = @"地址:";
    [CompanyMesTextView addSubview:pepolLabel];
    [pepolLabel release];
    UILabel *SecPepolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 240, 20)];
    SecPepolLabel.text = [self.ComanyAllArr objectAtIndex:4];
    
    
    [CompanyMesTextView addSubview:SecPepolLabel];
    [SecPepolLabel release];
    
    UIImageView *linerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayline"]];
    linerView.frame = CGRectMake(0, 110, 320, 1);
    [CompanyMesTextView addSubview:linerView];
    [linerView release];
    UILabel *textmessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 0, 0)];
    textmessage.text = [self.ComanyAllArr objectAtIndex:5];
    textmessage.lineBreakMode = 0;
    [textmessage setNumberOfLines:0];
    //    自适应高度
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    CGSize size = CGSizeMake(310, CGFLOAT_MAX);
    CGSize Textmessagelabelsize = [textmessage.text sizeWithFont:font constrainedToSize:size lineBreakMode:0];
    NSLog(@"%f,%f",Textmessagelabelsize.width,Textmessagelabelsize.height);
    [textmessage setFrame:CGRectMake(10, 120, Textmessagelabelsize.width, Textmessagelabelsize.height)];
    [textmessage sizeToFit];
    [CompanyMesTextView addSubview:textmessage];
    [textmessage release];
    
    CompanyMesTextView.scrollEnabled = YES;
    
    CompanyMesTextView.delegate = self;
    CompanyMesTextView.contentSize = CGSizeMake(310, 120+textmessage.frame.size.height);
    //    
    [self.view addSubview:CompanyMesTextView];
    [CompanyMesTextView release];
    
    
}


-(void)LeftButtenAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) 
    {
        if (CompanyMesTextView != nil)
        {
            [CompanyMesTextView removeFromSuperview];
        }
        
        [sender setImage:[UIImage imageNamed:@"companyDescNormal"] forSegmentAtIndex:1];
        [sender setImage:[UIImage imageNamed:@"jobDescSelected"] forSegmentAtIndex:0];
        
        [self JobPagePic];
        //        [self companyPagePic];
    }
    else
    {
        if (_JobMesTextView != nil)
        {
            [_JobMesTextView removeFromSuperview];
        }
        
        
        [sender setImage:[UIImage imageNamed:@"jobDescNormal"] forSegmentAtIndex:0];
        [sender setImage:[UIImage imageNamed:@"companyDescSelected"] forSegmentAtIndex:1];
        
        //        CompanyMesTextView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 400-40-70)];
        [self companyPagePic];
        //        [self.view addSubview:CompanyMesTextView];
        
        
    }
    
    
    
}

-(void)rightButtenAction:(UIButton *)sender
{
    CompanyMesTextView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 400-40-70)];
    
    [sender setImage:[UIImage imageNamed:@"companyDescSelected"] forState:(UIControlStateSelected)];
    
    [self.view addSubview:CompanyMesTextView];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *leftImage = [UIImage imageNamed:@"jobDescSelected"];
    UIImage *rightImage = [UIImage imageNamed:@"companyDescNormal"];
    
    NSArray *titles = [NSArray arrayWithObjects:leftImage ,rightImage,nil];
    
    UISegmentedControl *segmentview = [[UISegmentedControl alloc] initWithItems:titles];
    segmentview.frame = CGRectMake(0, 0, 320, 40);
    segmentview.tag = 2000;
    segmentview.segmentedControlStyle = UISegmentedControlStyleBar;
    
    
    
    [segmentview addTarget:self action:@selector(LeftButtenAction:) forControlEvents:(UIControlEventValueChanged)];
    
    
    segmentview.selectedSegmentIndex = 0;
    
    
    [self.view addSubview:segmentview];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    if (i != 0) 
    {
        
        
        _cView = [[UIView alloc] initWithFrame:CGRectMake(0, 480-50, 320, 50)];
        _cView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bigdownPic"]];
        for (int i=0; i<4; i++) {
            UIButton * bView=[[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, 50)];
            bView.tag=4000+1000*i;
            [bView setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:0];
            [bView addTarget:self action:@selector(jobOperation:) forControlEvents:UIControlEventTouchUpInside];
            [_cView addSubview:bView];
            [bView release];
        }
        [self.tabBarController.view addSubview:_cView];
        [_cView release];
    }
    i++;
}

@end
