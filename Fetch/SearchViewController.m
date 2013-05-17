//
//  SearchViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"
#import "AsyncSearchLoader.h"
#import "SearchSuggestion.h"
#import "Fetch.h"
#import "BlenderViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchCV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(SEARCH_TAB,SEARCH_TAB);
    }
    return self;
}

- (void)viewDidLoad
{
    FetchAppDelegate.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    _suggestionArray = [SearchSuggestion defaultSearchSuggestions];
    NSMutableArray *array = [[NSArray alloc] initWithObjects:@"Loading Your Feed", nil];
    _searchArray = array;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    
    void (^ appsLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        _searchArray = array;
        
        _searchCV = [[AppsCollectionView alloc] initWithApps:array withParams:response.params withCollectionView:searchCV withPHView:placeholderView withBlenderVC:self];
        _searchCV.noHeader = YES;
        
    };
    NSString *searchQuery = [[searchBar.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString: @"+"];
    [self.searchDisplayController setActive:NO animated:YES];
    [AsyncSearchLoader loadApps:true withQuery:searchQuery withCallback:appsLoaderCallback withPage:1];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchDisplayController setActive:YES animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_suggestionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    SearchSuggestion *suggestion = [_suggestionArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = suggestion.title;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchSuggestion *suggestion = [_suggestionArray objectAtIndex:indexPath.row];
    
    if ( keywordSearch == suggestion.type ) {
        [self.view endEditing:YES];
        
        void (^ appsLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
            for ( FetchApp *app in response.apps) {
                [array addObject:app];
            }
            _searchArray = array;
            
            _searchCV = [[AppsCollectionView alloc] initWithApps:array withParams:response.params withCollectionView:searchCV withPHView:placeholderView withBlenderVC:self];
            _searchCV.noHeader = YES;
            
        };
        NSString *searchQuery = [[suggestion.title componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString: @"+"];
        [self.searchDisplayController setActive:NO animated:YES];
        [AsyncSearchLoader loadApps:true withQuery:searchQuery withCallback:appsLoaderCallback withPage:1];
    } else if ( suggestion.type == templateSearch ) {
        [self.view endEditing:YES];
        _pushedVC = [[BlenderViewController alloc] initWithTemplate:suggestion.extra];
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationItem.title = suggestion.title;
        FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
        [self switchToView:_pushedVC withSelfView:self];
        FetchAppDelegate.navigationController.navigationBarHidden = NO;
    } else if ( suggestion.type == traitSearch ) {
        [self.view endEditing:YES];
        _pushedVC = [[BlenderViewController alloc] initWithTrait:suggestion.extra];
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationItem.title = suggestion.title;
        FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
        [self switchToView:_pushedVC withSelfView:self];
        FetchAppDelegate.navigationController.navigationBarHidden = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    FetchAppDelegate.navigationController.navigationBarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    for ( UIView *view in [self.view subviews] ) {
        if (view.tag==55) {
            FetchAppDelegate.navigationController.navigationBarHidden = NO;
            return;
        }
    }
    if ((!_pushedVC) || [_pushedVC isEqual: _selfVC]){
        FetchAppDelegate.navigationController.navigationBarHidden = YES;
        [_searchBar becomeFirstResponder];

    }
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    [searchText uppercaseString]];
    NSArray *strings = [[NSArray alloc] init];
    NSArray *dfs = [SearchSuggestion defaultSearchSuggestions];
    
    for ( SearchSuggestion *s in dfs ) {
        strings = [strings arrayByAddingObject:[s.title uppercaseString]];
    }
    
    strings = [strings filteredArrayUsingPredicate:resultPredicate];
    
    _suggestionArray = [[NSArray alloc] init];
    
    for (NSString *s in strings) {
        for ( SearchSuggestion *sug in dfs ) {
            if ([[sug.title uppercaseString] isEqualToString:[s uppercaseString]]) {
                _suggestionArray = [_suggestionArray arrayByAddingObject:sug];
            }
    
            if ([_suggestionArray count]>8) {
                break;
            }
        }
        if ([_suggestionArray count]>8) {
            break;
        }
    }


}

- (void) showThisView:(id)sender {
    if ( [_pushedVC isKindOfClass:[BlenderViewController class]] ) {
        BlenderViewController* bvc =  _pushedVC;
        [bvc unloadJunk];
    }
    [self switchToView: _selfVC withSelfView:_pushedVC];
    _pushedVC = _selfVC;
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = nil;
    FetchAppDelegate.navigationController.navigationBarHidden = YES;
}

-(void)switchToView:(UIViewController*)aViewController withSelfView:(UIViewController*)selfView
{
    if( aViewController == currentViewController ) return ;
    
    aViewController.title =  selfView.title;
    
    UIView *aView= aViewController.view;
    [aViewController viewWillAppear:NO];
    if( currentViewController != nil ) {
    	[currentViewController viewWillDisappear:NO];
    	[currentViewController.view removeFromSuperview];
    }
    aView.frame = placeholderView.frame;
    [selfView.view insertSubview:aView aboveSubview:placeholderView];
    if( currentViewController != nil ) {
    	[currentViewController viewDidDisappear:NO];
    }
    [aViewController viewDidAppear:NO];
    _selfVC = currentViewController;
    currentViewController = aViewController;
}


@end
