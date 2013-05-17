//
//  AppsCollectionView.m
//  Fetch
//
//  Created by Nathan Spaun on 2/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AppsCollectionView.h"
#import "FeedItem.h"
#import "FetchApp.h"
#import "SearchResult.h"
#import "AsyncBlenderLoader.h"
#import "Fetch.h"
#import "DetailsViewController.h"
#import "NavigationHelper.h"
#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation AppsCollectionView
@synthesize blenderComp;
@synthesize noHeader;

-(id)initWithApps:(NSArray*)apps withParams:(NSString *)params withCollectionView:(UICollectionView *)acv withPHView:(UIView *)phView withBlenderVC:(UIViewController *)bvc{
    self = [super init];
    if(self){
        _params = params;
        appsArray = apps;
        currentPage = 1;
        _acv = acv;
        placeholderView = phView;
        _selfVC = bvc;
        scrollPoint = CGPointMake(0, 0);
        
        UINib *cellNib = [UINib nibWithNibName:@"FeedItemBlender" bundle:nil];
        [_acv registerNib:cellNib forCellWithReuseIdentifier:@"FetchCell"];
        _acv.bounces = NO;
        [_acv setDelegate:self];
        [_acv setDataSource:self];
        
    }
    return self;
}

-(void)setApps:(NSArray*)apps {
    appsArray = apps;
}

- (void(^) (SearchResult* response))getCallback
{
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        
        [appsArray addObjectsFromArray:array];
        
        [self setApps:appsArray];
        
        [_acv reloadData];
        
        currentPage++;
        
    };
    return blenderLoaderCallback;
}

-(void)hideBlender
{
    if (blenderComp) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect bcFrame = blenderComp.frame;
            bcFrame.origin.y = -bcFrame.size.height;
            [blenderComp setFrame: bcFrame];
        }];
    }
}

-(void)showBlender
{
    if (blenderComp) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect bcFrame = blenderComp.frame;
            bcFrame.origin.y = 5;
            [blenderComp setFrame: bcFrame];
        }];
    }
}

- (void) showThisView:(id)sender {
    [self switchToView: nil withSelfView:_detailsVC];
    if ([_selfVC isKindOfClass:[SearchViewController class] ])    FetchAppDelegate.navigationController.navigationBarHidden = YES;
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = _oldItem;
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [appsArray count];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeedItem *cell = (FeedItem*) [collectionView dequeueReusableCellWithReuseIdentifier:@"FetchCell" forIndexPath:indexPath];

    
    FetchApp *app = (FetchApp*) [appsArray objectAtIndex:indexPath.row];
    [cell.appTitleLabel setText: app.title];
    

    
    NSArray *traitArray = [[app.relevancyTraits stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] componentsSeparatedByString:@","];
    NSString *rTrait = [traitArray objectAtIndex:0];
    if ([[rTrait substringFromIndex:rTrait.length-1] isEqualToString:@"*"]) {
        [cell.traitsLabel setText: [rTrait substringToIndex:rTrait.length-1] ];
        [cell.traitsLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
    } else {
        [cell.traitsLabel setText: rTrait];
        [cell.traitsLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
    }
    rTrait = [traitArray objectAtIndex:1];
    if ([[rTrait substringFromIndex:rTrait.length-1] isEqualToString:@"*"]) {
        [cell.traits2Label setText: [rTrait substringToIndex:rTrait.length-1] ];
        [cell.traits2Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
    } else {
        [cell.traits2Label setText: rTrait];
        [cell.traits2Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
    }
    rTrait = [traitArray objectAtIndex:2];
    if ([[rTrait substringFromIndex:rTrait.length-1] isEqualToString:@"*"]) {
        [cell.traits3Label setText: [rTrait substringToIndex:rTrait.length-1] ];
        [cell.traits3Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
    } else {
        [cell.traits3Label setText: rTrait];
        [cell.traits3Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
    }
    rTrait = [traitArray objectAtIndex:3];
    if ([[rTrait substringFromIndex:rTrait.length-1] isEqualToString:@"*"]) {
        [cell.traits4Label setText: [rTrait substringToIndex:rTrait.length-1] ];
        [cell.traits4Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
    } else {
        [cell.traits4Label setText: rTrait];
        [cell.traits4Label setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
    }
    
    [cell.ratingBar initWithFrame];
    [cell.ratingBar updateRating:app.rating];

    NSString *urlString = [app.screenShotUrls objectAtIndex:0];

    NSUInteger *index = urlString.length - 4;
    if ( [@".jpg" isEqualToString: [urlString substringFromIndex:index]] ){
        urlString = [NSString stringWithFormat:@"%@.225x225-75%@", [urlString substringToIndex:index], [urlString substringFromIndex:index] ];
    }
    NSLog(urlString);
    NSURL *url = [NSURL URLWithString: urlString];
    [cell.screenShotPreview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_games_blender"]];
    
    url = [NSURL URLWithString:app.iconUrl];
   
    [cell.iconThumbnail setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_games_blender"]];
    [[cell.iconThumbnail layer] setShadowColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY].CGColor];
    [[cell.iconThumbnail layer] setShadowOpacity:1];
    [[cell.iconThumbnail layer] setShadowRadius:0];
    [[cell.iconThumbnail layer] setShadowOffset:CGSizeMake(2, 2)];
    [[cell.iconThumbnail layer] setCornerRadius:3];
    
    [[cell.installButton layer] setCornerRadius:2.0f];
    [cell.installButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:11]];
    [[cell.installButton layer] setBackgroundColor:[Fetch colorWithHexString:COLOR_BLUE].CGColor];
    [cell.installButton addTarget:self action:@selector(installButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.installButton setTag:indexPath.row];
    
    int count = app.ratingCount/1000;
    NSString *rcLabel;
    if (count > 1) {
        [cell.ratingLabel setText:[NSString stringWithFormat:@"(%dk)",app.ratingCount]];
    } else {
        [cell.ratingLabel setText:[NSString stringWithFormat:@"(%d)",app.ratingCount]];
    }

    
    [[cell layer] setCornerRadius:1.0f];
    [[cell layer] setBorderWidth:0.5f];
    [[cell layer] setBorderColor:[Fetch colorWithHexString:COLOR_LIGHT_GRAY].CGColor];
    
    return cell;
}

-(void)installButtonPressed:(id)sender {
    UIButton *installButton = (UIButton*) sender;
    FetchApp *app = (FetchApp*) [appsArray objectAtIndex:installButton.tag];
    
    NSString *buttonHtml = @"http://click.linksynergy.com/fs-bin/stat?id=Kobni3VcspM&offerid=146261&type=3&subid=0&tmpid=1826&RD_PARM1=https%253A%252F%252Fitunes.apple.com%252Fus%252Fapp%252Fangry-birds%252Fid";
    NSString *buttonHtml2 = @"%253Fmt%253D8%2526uo%253D4%2526partnerId%253D30";
    NSString *finalHtml = [NSString stringWithFormat:@"%@%@%@", buttonHtml, app.packagename, buttonHtml2 ];
    
    
    [ [ UIApplication sharedApplication ] openURL: [NSURL URLWithString:finalHtml ]];
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(150, 210);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ( !self.noHeader ) {
        return CGSizeMake(320, 79);
    } else {
        return CGSizeMake(320, 10);
    }
    
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FetchAppDelegate.navigationController.navigationBarHidden = NO;
    FetchApp *app = [appsArray objectAtIndex:indexPath.row];
    _detailsVC = [[DetailsViewController alloc]initWithApp:app ];
    _detailsVC.navigationItem.title = app.title;
    _oldItem = FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem;
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];
    [_detailsVC.view setTag:55];
    [self switchToView:_detailsVC withSelfView:_selfVC];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark - UIScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    scrollPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        [AsyncBlenderLoader loadApps:true withParamString:_params withCallback:[self getCallback] withPage:currentPage+1];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        [AsyncBlenderLoader loadApps:true withParamString:_params withCallback:[self getCallback] withPage:currentPage+1];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( -scrollView.contentOffset.y + scrollPoint.y > 0 ) {
        [self showBlender];
    } else if (scrollView.contentOffset.y > 100) {
        [self hideBlender];
    } else {
        [self showBlender];
    }
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
    //_selfVC = currentViewController;
    currentViewController = aViewController;
}

@end


