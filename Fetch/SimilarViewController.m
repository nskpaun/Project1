//
//  SimilarViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "SimilarViewController.h"
#import "AsyncAppsLoader.h"
#import "SimilarCell.h"
#import <QuartzCore/QuartzCore.h>
#import "FetchApp.h"
#import "DetailsViewController.h"
#import "BlenderViewController.h"
#import "Fetch.h"
#import "AsyncSearchLoader.h"
#import "NavigationHelper.h"
#import "ApiHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SimilarViewController ()

@end

@implementation SimilarViewController

@synthesize similarTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(SIMILAR_TAB, SIMILAR_TAB);

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selfVC = self;
    self.tabBarController.view.frame = self.view.bounds;
    similarTable.bounces = NO;
    _similarArray = [[NSArray alloc] init];

    [AsyncAppsLoader loadApps:true withPath:@"cnn.com" withCallback:[self getSimilarCallback] withPage:1];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, 320, 50)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 49, 310, 1)];
    [lineView setBackgroundColor:[Fetch colorWithHexString:COLOR_LIGHT_GRAY]];
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(7, 28, 300, 20)];
    [labelView setText:@"App Store Top Apps"];
    [labelView setFont:[UIFont fontWithName:@"Arial" size:13]];
    [labelView setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
    [headerView addSubview:labelView];
    [headerView addSubview:lineView];
    similarTable.tableHeaderView = headerView;
    // Do any additionl setup after loading the view from its nib.
}

-(void(^) (SearchResult* response))getSimilarCallback
{
    void (^ response)(SearchResult*) = ^(SearchResult* search) {
        _params = search.params;
        _currentPage = 1;
        NSLog(@"getting popular apps");
        _similarArray = search.apps;
        [similarTable reloadData];
    };
    return  response;
}

-(void(^) (SearchResult* response))getSimilarCallbackPage
{
    void (^ response)(SearchResult*) = ^(SearchResult* search) {
        _params = search.params;
        _currentPage = _currentPage+1;
        _similarArray = [_similarArray arrayByAddingObjectsFromArray: search.apps];
        [similarTable reloadData];
    };
    return  response;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)launchBlenderSimilar:(UIButton*)sender
{
    FetchApp *app = [_similarArray objectAtIndex:sender.tag];
    _pushedVC = [[BlenderViewController alloc] initWithApp:app];
    _pushedVC.navigationItem.title = @"GAMES";
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
     [self switchToView:_pushedVC withSelfView:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillAppear:animated];
}

-(void)launchBlenderWithApp:(FetchApp*)app
{
    _pushedVC = [[BlenderViewController alloc] initWithApp:app];
    _pushedVC.navigationItem.title = @"GAMES";
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
    [self switchToView:_pushedVC withSelfView:self];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_similarArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimilarCell *cell = [[SimilarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"similar-cell"];
    FetchApp *app = [_similarArray objectAtIndex:indexPath.row];
    [cell.titleLabel setText:app.title];
    [[cell.similarButton layer] setCornerRadius:4];
    [[cell.similarButton layer] setBorderWidth:2];
    [[cell.similarButton layer] setBorderColor:[Fetch colorWithHexString:COLOR_BLUE].CGColor];
    [cell.similarButton addTarget:self action:@selector(launchBlenderSimilar:) forControlEvents:UIControlEventTouchUpInside];
    [cell.similarButton setTag:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:app.iconUrl];
    [cell.iconView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_games_blender"]];

    return cell;
    
}



#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FetchApp *app = [_similarArray objectAtIndex:indexPath.row];
    _pushedVC = [[DetailsViewController alloc]initWithApp:app ];
    _pushedVC.navigationItem.title = app.title;
     self.navigationController.navigationBar.hidden = NO;
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
    [self switchToView:_pushedVC withSelfView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    void (^ appsLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        _similarArray = array;
        
        [similarTable reloadData];
        
    };
    NSString *searchQuery = [[searchBar.text componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString: @"+"];
    [AsyncSearchLoader loadApps:true withQuery:searchQuery withCallback:appsLoaderCallback withPage:1];
    
}

#pragma mark - UIScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        ApiHelper *helper = [[ApiHelper alloc] init];
        [helper postToUrl:@"/api/json/search/" withParams:_params withCallback:[self getSimilarCallbackPage] withPage:_currentPage+1];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        ApiHelper *helper = [[ApiHelper alloc] init];
        [helper postToUrl:@"/api/json/search/" withParams:_params withCallback:[self getSimilarCallbackPage] withPage:_currentPage+1];
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (void) showThisView:(id)sender {
    if ( [_pushedVC isKindOfClass:[BlenderViewController class]] ) {
        BlenderViewController* bvc =  _pushedVC;
        [bvc unloadJunk];
    }
    [self switchToView: _selfVC withSelfView:_pushedVC];
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = nil;
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
