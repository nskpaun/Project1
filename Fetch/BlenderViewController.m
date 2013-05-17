//
//  BlenderViewController.m
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "BlenderViewController.h"
#import "AppsCollectionView.h"
#import "FeedItem.h"
#import "Genome.h"
#import "MoreSelectionViewController.h"
#import "Fetch.h"
#import "BlenderComponent.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>


@interface BlenderViewController ()

@end

@implementation BlenderViewController

@synthesize appsCollectionView;
@synthesize acvProp = _acv;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithTemplate:(CheckerBoardTemplate*)cbTemplate
{
    self = [super initWithNibName:@"BlenderViewController" bundle:nil];
    if (self) {
        searchName = cbTemplate.name;
        [AsyncBlenderLoader loadApps:true withTemplateId:cbTemplate.templateId withCallback:[self getCallback] withPage:1];
    }
    return self;
}
- (id)initWithApp:(FetchApp *)app
{
    self = [super initWithNibName:@"BlenderViewController" bundle:nil];
    if (self) {
        searchName = app.title;
        [AsyncBlenderLoader loadApps:true withApp:app withCallback:[self getCallbackApp] withPage:1];
    }
    return self;
}

- (id)initWithTrait:(FetchTrait*) trait
{
    self = [super initWithNibName:@"BlenderViewController" bundle:nil];
    if (self) {
        searchName = trait.name;
        [AsyncBlenderLoader loadApps:true withTraitIds:[NSString stringWithFormat:@"%ld",trait.traitId ] withCallback:[self getCallback] withPage:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _selectedTraits = [[NSMutableArray alloc] init];
    
    _fullTree = [Genome fullTree];
    
    _blenderComp = [[BlenderComponent alloc] initWithFrame:CGRectMake(7, 7, 306, 72)];
    [[_blenderComp layer] setCornerRadius:2.0f];
    [[_blenderComp layer] setBorderWidth:0.5f];
    [[_blenderComp layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
    [_blenderComp.layer setShadowColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
    [_blenderComp.layer setShadowOpacity:0.20];
    [_blenderComp.layer setShadowRadius:1.5];
    [_blenderComp.layer setShadowOffset:CGSizeMake(0.0, 2.0)];
    [self.view addSubview:_blenderComp];
    
    [self styleButtons];

    // Do any additional setup after loading the view from its nib.
}


- (void)styleButtons{
    for ( int i = 0; i < 6; i++ ) {
        UIButton *button = (UIButton*) [_blenderComp.buttons objectAtIndex:i];
        [button setBackgroundColor:[UIColor clearColor]];
        [[button layer] setCornerRadius:3.0f];
        [[button layer] setBorderWidth:1.0f];
        [[button layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
        [button.titleLabel setFont: [UIFont systemFontOfSize:12]];
        [button.titleLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY]];
        [button.titleLabel setTextAlignment:NSTextAlignmentLeft];
        if ( i<5 ) button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;



    }
}

- (void(^) (SearchResult* response))getCallback
{
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSLog(@"blender callback");
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        
        _acv = [[AppsCollectionView alloc] initWithApps:array withParams:response.params withCollectionView:appsCollectionView withPHView:placeholderView withBlenderVC:self];
        _acv.blenderComp = _blenderComp;
        _genomes = response.genomes;
        
        int i = 0;
        
        for ( Genome *g in _genomes ) {
            UIButton *label = (UIButton *)[_blenderComp.buttons objectAtIndex:i];
            
            [[label layer] setBackgroundColor:[UIColor clearColor].CGColor];
            [[label layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
            [label setTitle: [self truncateText:g.name] forState:UIControlStateNormal];
            [label setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateNormal];
            [label addTarget:self action:@selector(pillSelected:) forControlEvents:UIControlEventTouchUpInside];
            for (FetchTrait *f in g.traits) {

                if ( f.selected == YES ) {
                    [_selectedTraits addObject: f];
                    [label setTitle:[[self truncateText:f.name] uppercaseString] forState:UIControlStateNormal];
                    UIColor *color = [Genome colorForFamily:[[g.family lowercaseString] capitalizedString ]];
                    [label setBackgroundColor:color];
                    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [[label layer] setBorderWidth:1];
                    [[label layer] setBorderColor:[UIColor whiteColor].CGColor];
                }
            }
            i++;
        }
        UIButton *moreButton = (UIButton *)[_blenderComp.buttons objectAtIndex:5];
        [moreButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    };
    return blenderLoaderCallback;
}

- (void(^) (SearchResult* response))getCallbackApp
{
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSLog(@"blender callback");
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        
        _acv = [[AppsCollectionView alloc] initWithApps:array withParams:response.params withCollectionView:appsCollectionView withPHView:placeholderView withBlenderVC:self];
        _acv.blenderComp = _blenderComp;
        NSArray *genomesTemp = [[NSArray alloc] initWithObjects:[[Genome alloc] init], nil];
        _genomes = response.genomes;
        
        UIButton *appButton = (UIButton *)[_blenderComp.buttons objectAtIndex:0];
        
        [appButton setTitle:response.app.title forState:UIControlStateNormal];
        
        if (![_blenderComp viewWithTag:99]) {
        
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(6,6,22,22)];
            icon.tag = 99;
            [icon setImageWithURL:[NSURL URLWithString:response.app.iconUrl] placeholderImage:[UIImage imageNamed:@"home_games_blender"]];
            [self formatAppButton:appButton];
            [_blenderComp addSubview:icon];
        }
        
        int i = 1;
        
        for ( Genome *g in _genomes ) {
            UIButton *label = (UIButton *)[_blenderComp.buttons objectAtIndex:i];
            
            [[label layer] setBackgroundColor:[UIColor clearColor].CGColor];
            [[label layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
            [label setTitle: [self truncateText:g.name] forState:UIControlStateNormal];
            [label setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateNormal];
            [label addTarget:self action:@selector(pillSelected:) forControlEvents:UIControlEventTouchUpInside];

            for (FetchTrait *f in g.traits) {
                
                if ( f.selected == YES ) {
                    [_selectedTraits addObject: f];
                    [label setTitle:[self truncateText:f.name] forState:UIControlStateNormal];
                    UIColor *color = [Genome colorForFamily:[[g.family lowercaseString] capitalizedString ]];
                    [label setBackgroundColor:color];
                    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [[label layer] setBorderColor:[UIColor whiteColor].CGColor];
                }
            }
            i++;
        }
        UIButton *moreButton = (UIButton *)[_blenderComp.buttons objectAtIndex:5];
        [moreButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _genomes = [genomesTemp arrayByAddingObjectsFromArray:_genomes];
        
    };
    return blenderLoaderCallback;
}

- (void(^) (SearchResult* response))getCallbackPillChange
{
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSLog(@"blender callback");
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app];
        }
        
        _acv = [[AppsCollectionView alloc] initWithApps:array withParams:response.params withCollectionView:appsCollectionView withPHView:placeholderView withBlenderVC:self];
        _acv.blenderComp = _blenderComp;
        [appsCollectionView scrollsToTop];
        
    };
    return blenderLoaderCallback;
}

- (void(^) (FetchTrait* trait))getCallbackMorePill
{
    void (^ morePillCallback)(FetchTrait*) = ^(FetchTrait* trait) {
        UIButton *moreButton = (UIButton *)[_blenderComp.buttons objectAtIndex:5];
        if (trait) {
            [self addSelectedTrait:trait];
            [moreButton setTitle:[[self truncateText:trait.name] uppercaseString] forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [moreButton setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateSelected];
            [moreButton setBackgroundColor:[Genome colorForFamily:[Genome familyForTrait:trait.name]]];
            [[moreButton layer] setBorderColor:[UIColor whiteColor].CGColor];
            moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else {
            [moreButton setTitle:@"MORE" forState:UIControlStateNormal];
            [moreButton setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateNormal];
            [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [moreButton setBackgroundColor:[Fetch colorWithHexString:COLOR_PALE_GRAY]];
            [[moreButton layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
            moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        if (_moreTrait && ![_moreTrait isEqual:trait]) {
            [self removeSelectedTrait:_moreTrait];
        }
        _moreTrait = trait;
        [AsyncBlenderLoader loadApps:true withTraitIds:[self getSelectedTraitIdString] withCallback:[self getCallbackPillChange] withPage:1];
    };

    return morePillCallback;
}



- (IBAction)pillSelected:(id)sender {

    NSMutableArray *traitViews = [[NSMutableArray alloc] init];
    _currentButton = ((UIButton*) sender);
    
    _openPill = ((Genome*) [_genomes objectAtIndex:_currentButton.tag-1]);
    
    
    NSArray *traits =_openPill.traits;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,160 , 30)];
    UILabel *tv = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 140, 26)];
    tv.textAlignment = UITextAlignmentCenter;
    [tv setBackgroundColor:[UIColor clearColor]];
    
    
    [v setBackgroundColor:[Fetch colorWithHexString:COLOR_PALE_GRAY]];
    [[v layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
    [[v layer] setCornerRadius:5.0f];
    [[v layer] setBorderWidth:1];
    
    [tv setText: @"NONE"];
    [v addSubview:tv];
    [traitViews addObject:v];
    for ( FetchTrait *t in traits) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,160 , 30)];
        
        
        [v setBackgroundColor:[Fetch colorWithHexString:COLOR_PALE_GRAY]];
        [[v layer] setCornerRadius:5.0f];
        [[v layer] setBorderWidth:1];
        [[v layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
        
     
        UILabel *tv = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 140, 26)];
        tv.textAlignment = UITextAlignmentCenter;
        [tv setBackgroundColor:[UIColor clearColor]];
        [tv setText: [t.name uppercaseString]];
        [v addSubview:tv];
        [traitViews addObject:v];
        if ( [_selectedTraits containsObject:t] ) {
            [v setBackgroundColor:[Genome colorForFamily:[[_openPill.family lowercaseString] capitalizedString ]]];
            [[v layer] setBorderColor:[UIColor whiteColor].CGColor];
            [tv setTextColor:[UIColor whiteColor]];
        }
    }
    CGRect frame = _currentButton.frame;
    
    [PopoverView showPopoverAtPoint:CGPointMake(frame.origin.x+10 + frame.size.width/2, frame.origin.y + frame.size.height+5) inView:self.view withViewArray:traitViews delegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark blendermenu stuff

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    if ( index < 1 ) {
        [self removeSelectedTraitsInGenome:_openPill];
        [_currentButton setTitle:[self truncateText:_openPill.name] forState:UIControlStateNormal];
        [AsyncBlenderLoader loadApps:true withTraitIds:[self getSelectedTraitIdString] withCallback:[self getCallbackPillChange] withPage:1];
        [[_currentButton layer] setBackgroundColor:[UIColor clearColor].CGColor];
        [[_currentButton layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
        [_currentButton setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateNormal];
        [popoverView dismiss];
        return;
    }
    
    FetchTrait *trait = [_openPill.traits objectAtIndex:index-1];
    
    if ( [_selectedTraits containsObject:trait] ) {
        [self removeSelectedTraitsInGenome:_openPill];
        [_currentButton setTitle:[self truncateText:_openPill.name] forState:UIControlStateNormal];
        [[_currentButton layer] setBackgroundColor:[UIColor clearColor].CGColor];
        [[_currentButton layer] setBorderColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY].CGColor];
        [_currentButton setTitleColor:[Fetch colorWithHexString:COLOR_MEDIUM_DARK_GRAY] forState:UIControlStateNormal];
    } else {
        [self removeSelectedTraitsInGenome:_openPill];
        [self addSelectedTrait:trait];
        UIColor *color = [Genome colorForFamily:[[_openPill.family lowercaseString] capitalizedString ]];
        [_currentButton setBackgroundColor:color];
        [[_currentButton layer] setBorderColor:[UIColor whiteColor].CGColor];
        [_currentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_currentButton setTitle:[[self truncateText:trait.name] uppercaseString]forState:UIControlStateNormal];
    }

    
    [AsyncBlenderLoader loadApps:true withTraitIds:[self getSelectedTraitIdString] withCallback:[self getCallbackPillChange] withPage:1];
    
   

    
    [popoverView dismiss];
}

#pragma mark More Button
- (IBAction)moreButtonPressed:(id)sender {
    MoreSelectionViewController *msvc = [[MoreSelectionViewController alloc]initWithGenomes:_fullTree withCallback:[self getCallbackMorePill] withMoreTrait:_moreTrait];
    msvc.navigationItem.title = @"       MORE";
    [FetchAppDelegate.navigationController pushViewController:msvc animated:NO];
}

#pragma mark Edit Selected Traits

-(NSString*)getSelectedTraitIdString
{
    NSString *idString = @"";
    for ( FetchTrait *f in _selectedTraits ) {
        idString = [NSString stringWithFormat:@"%@%ld,", idString, f.traitId];
    }
    return idString;
}

-(void)addSelectedTrait:(FetchTrait*)t
{
    if ( ![_selectedTraits containsObject:t] ) {
        [_selectedTraits addObject:t];
    }
}

-(void)removeSelectedTrait:(FetchTrait*)t
{
    if ( [_selectedTraits containsObject:t] ) {
        [_selectedTraits removeObject:t];
    }
}

-(void)removeSelectedTraitsInGenome:(Genome*)g
{
    for ( FetchTrait* ft in g.traits ) {
        if ( [_selectedTraits containsObject:ft] ) {
            [self removeSelectedTrait:ft];
        }
    }
}

-(NSString *)truncateText:(NSString *)text
{
    if ( [text length] > 10 ) {
       return [ NSString stringWithFormat:@"%@%@",[text substringToIndex:7],@"..." ];
    }
    
    return text;
}

-(void)formatAppButton:(UIButton*)button
{
    NSString *title = [self truncateText:button.titleLabel.text];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel sizeToFit];
   

    CGRect frame = button.titleLabel.frame;
    if (45-frame.size.width/2<34) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, frame.size.width/2-10, 0, 0)];
    }
}

- (void)unloadJunk
{
    _blenderComp = nil;
    _acv = nil;
}



@end
