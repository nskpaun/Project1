//
//  DetailsViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 3/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "DetailsViewController.h"
#import "Photo.h"
#import "BlenderViewController.h"
#import <Three20/Three20.h>
#import "Fetch.h"
#import "SimilarViewController.h"
#import "AsyncDetailsLoader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize appDescriptionLabel;
@synthesize appNameLabel;
@synthesize photoScroll;
@synthesize iconThumbnail;
@synthesize description;
@synthesize installButton;

@synthesize themeView;
@synthesize visualView;
@synthesize skillView;
@synthesize interactionView;

- (id)initWithApp:(FetchApp*)app {
    self = [super initWithNibName:@"DetailsViewController" bundle:nil];
    if (self) {
        _app = app;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)imageTapped:(UITapGestureRecognizer *)gesture
{
    [self.navigationController pushViewController:_photoVC animated:YES];
}

- (void(^) (SearchResult* response))getCallback
{
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        [self setTraitsAPI:response.traits];
        
    };
    return blenderLoaderCallback;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.hidden = NO;
    [super viewDidLoad];
    
    [[similarButton layer] setCornerRadius:4.0f];
    [[similarButton layer] setBorderWidth:2.0f];
    [[similarButton layer] setBorderColor:[Fetch colorWithHexString:COLOR_BLUE].CGColor];
    
    [ratingBar initWithFrame];
    [ratingBar updateRating:_app.rating];
    
    [AsyncDetailsLoader loadApp:_app withCallback:[self getCallback]];
    
    [appDescriptionLabel setText:_app.description];
    [appNameLabel setText:_app.title];
    
    NSArray *photos = [[NSArray alloc] init];
    CGFloat length = 0;
    for ( NSString *urlString in _app.screenShotUrls ) {
        Photo *p = [[Photo alloc] initWithCaption:@"1" urlLarge:urlString urlSmall:urlString urlThumb:urlString size:CGSizeMake(200, 150)];
        photos = [photos arrayByAddingObject:p];
        UIImageView *pv = [[UIImageView alloc] initWithFrame:CGRectMake(length, 10, 200, 150)];
        [pv setImageWithURL:urlString];
        pv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [pv addGestureRecognizer:tap];
        
        [photoScroll addSubview:pv];
        
        length = length + 205;
        photoScroll.contentSize = CGSizeMake(length, 150);
    }
    
    _photoSet = [[PhotoSet alloc] initWithTitle:_app.title photos:photos];
    
    
    _photoVC = [[TTPhotoViewController alloc] initWithPhotoSource:_photoSet];
    
    [description setText:_app.description];

    //NSString *trimmed = [_app.traits stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *traitArray = [[_app.traits stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] componentsSeparatedByString:@","];
    //[self setTraitsLocal:traitArray];
    
    //[self.navigationController pushViewController:_photoVC animated:YES];
    
    
    NSURL *url = [NSURL URLWithString:_app.iconUrl];
    [iconThumbnail setImageWithURL:url];
    
    NSString *buttonHtml = @"<body bgcolor=\"#CED5D9\"><a href=\"http://click.linksynergy.com/fs-bin/stat?id=Kobni3VcspM&offerid=146261&type=3&subid=0&tmpid=1826&RD_PARM1=https%253A%252F%252Fitunes.apple.com%252Fus%252Fapp%252Fangry-birds%252Fid";
    NSString *buttonHtml2 = @"%253Fmt%253D8%2526uo%253D4%2526partnerId%253D30\" target=\"itunes_store\"style=\"display:inline-block;overflow:hidden;background:url(http://linkmaker.itunes.apple.com/htmlResources/assets/images/web/linkmaker/badge_appstore-lrg.png) no-repeat;width:135px;height:40px;@media only screen{background-image:url(http://linkmaker.itunes.apple.com/htmlResources/assets/images/web/linkmaker/badge_appstore-lrg.svg);}\"></a></body>";
    NSString *finalHtml = [NSString stringWithFormat:@"%@%@%@", buttonHtml, _app.packagename, buttonHtml2 ];
    [installButton loadHTMLString:finalHtml baseURL:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setTraitsAPI:(NSArray*)traitArray
{
    CGFloat tlength = 5;
    CGFloat vlength = 5;
    CGFloat ilength = 5;
    CGFloat slength = 5;
    for ( FetchTrait *trait in traitArray ) {
        NSString *tString = [NSString stringWithFormat:@" %@ ",trait.name];
        UILabel *label;
        NSString *family = [trait.family uppercaseString];
        if ( [family isEqualToString:[themeFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(tlength, 0, 10, 25)];
            [label setText:trait.name];
            [label sizeToFit];
            [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width+10, label.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            tlength = label.frame.size.width + 3 + tlength;
            
        } else if ([family isEqualToString:[skillFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(vlength, 0, 10, 25)];
            [label setText:trait.name];
            [label sizeToFit];
            [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width+10, label.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            vlength = label.frame.size.width + 3 + vlength;
        } else if ([family isEqualToString:[visualFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(ilength, 0, 10, 25)];
            [label setText:trait.name];
            [label sizeToFit];
            [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width+10, label.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            ilength = label.frame.size.width + 3 + ilength;
        } else {
            label = [[UILabel alloc] initWithFrame:CGRectMake(slength, 0, 10, 25)];
            [label setText:trait.name];
            [label sizeToFit];
            [label setFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width+10, label.frame.size.height)];
            [label setTextAlignment:NSTextAlignmentCenter];
            slength = label.frame.size.width + 3 + slength;
        }
        
        [label setTextColor:[UIColor whiteColor]];
        
        UIColor *color = [Genome colorForFamily:[family capitalizedString]] ;
        
        [label setBackgroundColor:color];
        [[label layer] setCornerRadius:4];
        
        if ( [family isEqualToString:[themeFamily uppercaseString]] ) {
            [themeView addSubview:label];
            
        } else if ([family isEqualToString:[skillFamily uppercaseString]] ) {
            [skillView addSubview:label];
        } else if ([family isEqualToString:[visualFamily uppercaseString]]) {
            [visualView addSubview:label];
        } else {
            [interactionView addSubview:label];
        }
        
        
    }
    
}

-(void)setTraitsLocal:(NSArray*)traitArray
{
    CGFloat tlength = 0;
    CGFloat vlength = 0;
    CGFloat ilength = 0;
    CGFloat slength = 0;
    for ( NSString *trait in traitArray ) {
        NSString *tString = trait;
        UILabel *label;
        if ( [trait hasPrefix:@" "]) {
            tString = [tString substringFromIndex:1];
        }
        if ( [trait hasSuffix:@" "]) {
            tString = [tString substringFromIndex: tString.length - 2];
        }
        NSString *family = [Genome familyForTrait:tString];
        if ( [family isEqualToString:[themeFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(tlength, 0, 10, 25)];
            [label setText:trait];
            [label sizeToFit];
            tlength = label.frame.size.width + 3 + tlength;
            
        } else if ([family isEqualToString:[skillFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(vlength, 0, 10, 25)];
            [label setText:trait];
            [label sizeToFit];
            vlength = label.frame.size.width + 3 + vlength;
        } else if ([family isEqualToString:[visualFamily uppercaseString]] ) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(ilength, 0, 10, 25)];
            [label setText:trait];
            [label sizeToFit];
            ilength = label.frame.size.width + 3 + ilength;
        } else {
            label = [[UILabel alloc] initWithFrame:CGRectMake(slength, 0, 10, 25)];
            [label setText:trait];
            [label sizeToFit];
            slength = label.frame.size.width + 3 + slength;
        }
        
        [label setTextColor:[UIColor whiteColor]];
        
        UIColor *color = [Genome colorForFamily:[family capitalizedString]] ;
        
        [label setBackgroundColor:color];
        [[label layer] setCornerRadius:2];
        
        if ( [family isEqualToString:[themeFamily uppercaseString]] ) {
            [themeView addSubview:label];
            
        } else if ([family isEqualToString:[skillFamily uppercaseString]] ) {
            [skillView addSubview:label];
        } else if ([family isEqualToString:[visualFamily uppercaseString]]) {
            [visualView addSubview:label];
        } else {
            [interactionView addSubview:label];
        }
        
        
    }

}

- (IBAction)similarPressed:(id)sender {
    [FetchAppDelegate.navBarItems setObject:FetchAppDelegate.tabBarControllerProp.navigationItem.leftBarButtonItem forKey:FetchAppDelegate.currentTab];
    FetchAppDelegate.currentTab = SIMILAR_TAB;
    SimilarViewController *svc = [[FetchAppDelegate.tabBarControllerProp viewControllers] objectAtIndex:0];
    [svc launchBlenderWithApp:_app];
    [FetchAppDelegate.tabBarControllerProp setSelectedIndex:0];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
