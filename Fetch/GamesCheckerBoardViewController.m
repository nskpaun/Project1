//
//  GamesCheckerBoardViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "GamesCheckerBoardViewController.h"
#import "CheckerBoardTemplate.h"
#import "BlenderViewController.h"
#import "Fetch.h"
#import "TemplateItem.h"
#import "AsyncSearchLoader.h"
#import "NavigationHelper.h"

@interface GamesCheckerBoardViewController ()

@end

@implementation GamesCheckerBoardViewController

@synthesize templateCollectionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = NSLocalizedString(GAMES_TAB,GAMES_TAB);
//        self.tabBarItem setImage:UIImage

    }
    return self;
}

- (id)init
{
    self = [super initWithNibName:@"GamesCheckerBoardViewController" bundle:nil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    first = YES;
    _selfVC = self;
    self.tabBarController.view.frame = self.view.bounds;
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearTraits:)] ;

    UINib *cellNib = [UINib nibWithNibName:@"TemplateItemView" bundle:nil];
    [templateCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"TemplateCell"];
    
    _templates = [CheckerBoardTemplate defaultTemplates];
    
    templateCollectionView.hidden = YES;
    colorbar.hidden = YES;
    [templateCollectionView setDelegate:self];
    [templateCollectionView setDataSource:self];
    
    for (UIView *view in FetchAppDelegate.tabBarControllerProp.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+49.f, view.frame.size.width, view.frame.size.height)];
        }
        else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height+49.f)];
        }
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    if(first) {
        //[NSThread sleepForTimeInterval:1.5];
        //[FetchAppDelegate.navigationController setNavigationBarHidden:NO animated:YES];
        [NSThread sleepForTimeInterval:1.5];
        [templateCollectionView setDataSource:nil];
        [templateCollectionView setDelegate:nil];
        [templateCollectionView setDelegate:self];
        [templateCollectionView setDataSource:self];
        templateCollectionView.hidden = NO;
        colorbar.hidden = NO;

        CGRect bcFrame = templateCollectionView.frame;
        bcFrame.origin.y = bcFrame.size.height;
        [colorbar setFrame:CGRectMake(bcFrame.origin.x, bcFrame.size.height+20, colorbar.frame.size.width, colorbar.frame.size.height)];
        [templateCollectionView setFrame: bcFrame];
        


        

        [UIView animateWithDuration:1 animations:^{
            
            CGRect bcFrameAnim = templateCollectionView.frame;
            bcFrameAnim.origin.y = 0;
            [templateCollectionView setFrame: bcFrameAnim];
            [UIView animateWithDuration:1 animations:^{
                
                [colorbar setFrame:CGRectMake(bcFrame.origin.x, bcFrame.origin.y, colorbar.frame.size.width, colorbar.frame.size.height)];
                [UIView animateWithDuration:1 animations:^{
                    [alphaScreen setAlpha:0.7];
                }];
                
            }];
            
            [self showTabBar:FetchAppDelegate.tabBarControllerProp];
            
        } completion:^(BOOL finished){
            colorbar.hidden = YES;
            UIImage *navBack = [UIImage imageNamed:@"navbackground"];
            [FetchAppDelegate.navigationController.navigationBar setBackgroundImage: navBack forBarMetrics:UIBarMetricsDefault];
        }];


    }
    

    
    first = NO;

}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_templates count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    TemplateItem *cell = (TemplateItem*) [collectionView dequeueReusableCellWithReuseIdentifier:@"TemplateCell" forIndexPath:indexPath];
    
    CheckerBoardTemplate *template = (CheckerBoardTemplate*) [_templates objectAtIndex:indexPath.row];
//    if([[_configured objectAtIndex:indexPath.row] isEqual:@"YES"]){
//        return cell;
//    }
//    [_configured insertObject:@"YES" atIndex:indexPath.row];
    CGFloat lastSize = 0;
    [cell.templateTraitContainer removeFromSuperview];
    cell.templateTraitContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 95, 140, 25)];
    NSArray *names = [template.traitNames componentsSeparatedByString:@";"];
    NSArray *families = [template.familyNames componentsSeparatedByString:@";"];
    
    
    for ( NSInteger i = 0; i < [names count]; i++ ) {
        UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(lastSize, 0, 10, 15)];
        [tLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
        [tLabel setBackgroundColor:[UIColor clearColor]];
        [tLabel setFont: [UIFont systemFontOfSize:11]];
        NSString *name = [names objectAtIndex:i];
        [tLabel setText:name];
        
        [tLabel sizeToFit];
        [cell.templateTraitContainer addSubview:tLabel];
        
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(lastSize, 18, tLabel.frame.size.width, 3)];
        lastSize = lastSize + tLabel.frame.size.width;
        NSString *family = [families objectAtIndex:i];
        [underLine setBackgroundColor: [Genome colorForFamily:family ]];
        
        [cell.templateTraitContainer addSubview:underLine];
        
        if (i < ([names count]-1) ) {
            UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(lastSize, 0, 10, 15)];
            [pLabel setFont: [UIFont systemFontOfSize:11]];
            [pLabel setText:@" + "];
            [pLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
            [pLabel setBackgroundColor:[UIColor clearColor]];
            [pLabel sizeToFit];
            [cell.templateTraitContainer addSubview:pLabel];
            lastSize = lastSize + pLabel.frame.size.width;
            [cell.templateTraitContainer addSubview:pLabel];
            
        }
    }
    
    //[cell.blockingView removeFromSuperview];


    //[self hideTabBar: ];
    
    [cell addSubview:cell.templateTraitContainer];
    
    [cell.templateNameLabel setText:template.name];
    
    [cell.templateImageView setImage:template.image];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(145, 95, 5, 25)];
    [v setBackgroundColor:[Fetch colorWithHexString:COLOR_LIGHT_GRAY]];
    [cell addSubview:v];
    
    [[cell layer] setCornerRadius:4.0f];
    [[cell layer] setBorderWidth:1.0f];
    [[cell layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY].CGColor];
    
    return cell;
}

- (void)showTabBar:(UITabBarController *)tabbarcontroller
{
    tabbarcontroller.tabBar.hidden = NO;
    [UIView animateWithDuration:1 animations:^{
        for (UIView *view in tabbarcontroller.view.subviews) {
            if ([view isKindOfClass:[UITabBar class]]) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-49.f, view.frame.size.width, view.frame.size.height)];
            }
            else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height-49.f)];
            }
        }
    } completion:^(BOOL finished) {
        //do smth after animation finishes
    }];
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(150, 125);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CheckerBoardTemplate *template = [_templates objectAtIndex:indexPath.row];
    _blenderVC = [[BlenderViewController alloc] initWithTemplate:template];
    _blenderVC.navigationItem.title = @"GAMES";
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:UIBarButtonItemStyleBordered target:self action:@selector(showThisView:)];
//    [item setTarget:self];
//    [item setAction:@selector(showThisView:)];
//    [item setImage:[UIImage imageNamed:@"nav_next"]];
    FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_next"] landscapeImagePhone:[UIImage imageNamed:@"nav_next"] style:nil target:self action:@selector(showThisView:)];

    [self switchToView:_blenderVC withSelfView:self];

    //_selfVC = [vcs objectAtIndex:1];

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (void) showThisView:(id)sender {
    //[_blenderVC unloadJunk];
    [self  switchToView: _selfVC withSelfView:_blenderVC];
    _selfVC = currentViewController;
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
