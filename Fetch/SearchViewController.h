//
//  SearchViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppsCollectionView.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate,UISearchDisplayDelegate> {
    __block NSArray *_searchArray;
    AppsCollectionView *_searchCV;
    NSArray *_suggestionArray;
    IBOutlet UIView *placeholderView;
    
    IBOutlet UISearchBar *_searchBar;
    UIViewController *currentViewController;
    UIViewController *_pushedVC;
    UIViewController *_selfVC;
}
@property (strong, nonatomic) IBOutlet UICollectionView *searchCV;

@end
