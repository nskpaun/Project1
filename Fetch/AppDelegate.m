//
//  AppDelegate.m
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AppDelegate.h"
#import "Fetch.h"
#import <Three20/Three20.h>
#import "TestFlight.h"
#import "GamesCheckerBoardViewController.h"
#import "SimilarViewController.h"
#import "SearchViewController.h"


@implementation AppDelegate
@synthesize navigationController;
@synthesize tabBarControllerProp;
@synthesize navBarItems;
@synthesize currentTab;

extern const NSString *APP_VER_CODE = @"appvercode";
extern const NSString *NUM_DAYS_OPEN = @"numberOfDaysOpened";
extern const NSString *APP_ID = @"appId";
extern const NSString *LANG = @"lang";
extern const NSString *COUNTRY = @"country";
extern const NSString *LAST_DAY_OPEN = @"lastOpenAppDay";
extern const NSString *USER_ID = @"userId";
extern const NSString *INSTALL_DAY = @"installDay";
extern const NSString *SDK_VER = @"sdkVer";
extern const NSString *GAMES_TAB = @"Games";
extern const NSString *SEARCH_TAB = @"Search";
extern const NSString *SIMILAR_TAB = @"Similar";
extern const NSString *TIME_STAMP = @"ts";

- (UIView*)customNavButtonView
{
    UIImage *buttonImage = [UIImage imageNamed:@"nav_next"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    return button;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *barButtonImage = [[UIImage imageNamed:@"nav_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    navBarItems = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:[self customNavButtonView]],[[UIBarButtonItem alloc] initWithCustomView:[self customNavButtonView]],[[UIBarButtonItem alloc] initWithCustomView:[self customNavButtonView]], nil] forKeys:[NSArray arrayWithObjects:SIMILAR_TAB,GAMES_TAB,SEARCH_TAB, nil]];
    //navBarItems = [[NSMutableArray alloc] initWithObjects:[[UIBarButtonItem alloc] init],[[UIBarButtonItem alloc] init],[[UIBarButtonItem alloc] init], nil];
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    [TestFlight takeOff:@"320c1d0c-48e7-4f53-8759-9060c7361072"];
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    Fetch = [[FetchSingleton alloc] init];
    
    NSMutableDictionary *appDefaults = [NSMutableDictionary
                                 dictionaryWithObject:@"9" forKey:APP_VER_CODE];
    [appDefaults setObject:@"0" forKey:NUM_DAYS_OPEN];
    [appDefaults setObject:@"co.appdisco.android.appdisco" forKey:APP_ID];
    [appDefaults setObject:@"en" forKey:LANG];
    [appDefaults setObject:@"us" forKey:COUNTRY];
    [appDefaults setObject:@"4772" forKey:LAST_DAY_OPEN];
    [appDefaults setObject:@"1363103762294" forKey:TIME_STAMP];
    if ( ![appDefaults objectForKey:USER_ID] ) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        
        [appDefaults setObject:(__bridge NSString *)string forKey:USER_ID];
    }
    [appDefaults setObject:@"4770" forKey:INSTALL_DAY];
    [appDefaults setObject:@"16" forKey:SDK_VER];
    
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1 = [[SimilarViewController alloc] initWithNibName:@"SimilarViewController" bundle:nil];
    UIViewController *viewController2 = [[GamesCheckerBoardViewController alloc] initWithNibName:@"GamesCheckerBoardViewController" bundle:nil];
    UIViewController *viewController3 = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    
    self.tabBarControllerProp = [[UITabBarController alloc] init];
    self.tabBarControllerProp.viewControllers = @[viewController1, viewController2, viewController3];
    [self.tabBarControllerProp setSelectedIndex:1];
//    [FetchAppDelegate.navigationController pushViewController:self.tabBarController animated:YES];
    //ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];

    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarControllerProp];
    //[self.navigationController setNavigationBarHidden:YES];
    UIImage *navBack = [UIImage imageNamed:@"navbackgroundblack"];
    [[UINavigationBar appearance] setBackgroundImage: navBack forBarMetrics:UIBarMetricsDefault];
    
    NSString *title = @"         GAMES";

    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [Fetch colorWithHexString:COLOR_MEDIUM_GRAY],UITextAttributeTextColor,
                                               [UIColor blackColor], UITextAttributeTextShadowColor,
                                               [NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    self.tabBarControllerProp.navigationItem.title = title;
    self.tabBarControllerProp.hidesBottomBarWhenPushed = YES;
    

    UITabBarItem *tbItem =[self.tabBarControllerProp.tabBar.items objectAtIndex:0];
    tbItem.image =     [UIImage imageNamed:@"iOStab_similar"];
    tbItem =[self.tabBarControllerProp.tabBar.items objectAtIndex:1];
    tbItem.image =     [UIImage imageNamed:@"iOStab_games"];
    tbItem =[self.tabBarControllerProp.tabBar.items objectAtIndex:2];
    tbItem.image =     [UIImage imageNamed:@"iOStab_search"];

    self.window.rootViewController = self.navigationController;
    self.currentTab = GAMES_TAB;
    [self.tabBarControllerProp setSelectedIndex:1];
    [self.tabBarControllerProp setDelegate:self];
    [self.window makeKeyAndVisible];
    
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
    
    return YES;
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
#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem) {
        [navBarItems setObject:FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem forKey:currentTab];
        
    }
    currentTab = viewController.title;
    if ( currentTab.length > 5){
        self.tabBarControllerProp.navigationItem.title = [NSString stringWithFormat:@"           %@", [currentTab uppercaseString] ];
    } else {
        self.tabBarControllerProp.navigationItem.title = [NSString stringWithFormat:@"         %@", [currentTab uppercaseString] ];
    }
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [navBarItems objectForKey:currentTab];
    


    return YES;
}

@end
