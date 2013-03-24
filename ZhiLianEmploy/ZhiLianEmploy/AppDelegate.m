//
//  AppDelegate.m
//  ZhiLianEmploy
//
//  Created by Ibokan on 13-2-21.
//  Copyright (c) 2013年 Ibokan. All rights reserved.
//

#import "AppDelegate.h"
#import "QuickSearchViewController.h"
#import "MyZLViewController.h"
#import "InstanceRecommendViewController.h"
#import "SalarySearchViewController.h"
#import "JobGuideViewController.h"
#import "CusTabBarViewController.h"
#import "GuidanceViewController.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    NSMutableArray * arr1=[[NSMutableArray alloc] init];
    QuickSearchViewController * root1=[[QuickSearchViewController alloc] init];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:root1];
    [self setNavBarBackGroundImage:nav1];
    [arr1 addObject:nav1];
    [root1 release];
    [nav1 release];
    
    
    MyZLViewController * root2=[[MyZLViewController alloc] init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:root2];
    [self setNavBarBackGroundImage:nav2];
    [arr1 addObject:nav2];
    [root2 release];
    [nav2 release];
    
    InstanceRecommendViewController * root3=[[InstanceRecommendViewController alloc] init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:root3];
    [self setNavBarBackGroundImage:nav3];
    [arr1 addObject:nav3];
    [root3 release];
    [nav3 release];
    
    SalarySearchViewController * root4=[[SalarySearchViewController alloc] init];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:root4];
    [self setNavBarBackGroundImage:nav4];
    [arr1 addObject:nav4];
    [root4 release];
    [nav4 release];
    
    GuidanceViewController * root5=[[GuidanceViewController alloc] init];
    UINavigationController *nav5=[[UINavigationController alloc]initWithRootViewController:root5];
    [self setNavBarBackGroundImage:nav5];
    [arr1 addObject:nav5];
    [root5 release];
    [nav5 release];
    
    
    CusTabBarViewController *tabBar = [[CusTabBarViewController alloc]init];
    tabBar.viewControllers = arr1;
    self.window.rootViewController = tabBar;
    [arr1 release];
    [tabBar release];
 
    
    
    
    return YES;
}


-(UINavigationController*)setNavBarBackGroundImage:(UINavigationController*)sender
{
    [sender.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    return sender;

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
