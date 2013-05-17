//
//  SimilarViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchApp.h"

@interface SimilarViewController : UIViewController <UITableViewDataSource,UITabBarControllerDelegate, UISearchBarDelegate>
{
    NSMutableArray *_similarArray;
    NSInteger *_currentPage;
    NSString *_params;
    
    IBOutlet UIView *placeholderView;
    UIViewController *currentViewController;
    UIViewController *_pushedVC;
    UIViewController *_selfVC;
}

@property (strong, nonatomic) IBOutlet UITableView *similarTable;

-(void)launchBlenderWithApp:(FetchApp*)app;

@end
