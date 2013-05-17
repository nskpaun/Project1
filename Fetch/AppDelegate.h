//
//  AppDelegate.h
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic ) UITabBarController *tabBarControllerProp;
@property (strong, nonatomic ) NSMutableDictionary *navBarItems;
@property (nonatomic, copy) NSString *currentTab;

extern const NSString *APP_VER_CODE;
extern const NSString *NUM_DAYS_OPEN;
extern const NSString *APP_ID;
extern const NSString *LANG;
extern const NSString *COUNTRY;
extern const NSString *LAST_DAY_OPEN;
extern const NSString *USER_ID;
extern const NSString *INSTALL_DAY;
extern const NSString *SDK_VER;
extern const NSString *TIME_STAMP;
extern const NSString *GAMES_TAB;
extern const NSString *SEARCH_TAB;
extern const NSString *SIMILAR_TAB;


@end
