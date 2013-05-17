//
//  BlenderViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckerBoardTemplate.h"
#import "AsyncBlenderLoader.h"
#import "PopoverView.h"
#import "BlenderSelector.h"
#import "AppsCollectionView.h"
#import "Genome.h"
#import "BlenderComponent.h"

@interface BlenderViewController : UIViewController <PopoverViewDelegate> {
    NSString *searchName;
    
    AppsCollectionView *_acv;
    NSArray *_genomes;
    Genome *_openPill;
    NSMutableArray *_selectedTraits;
    UIButton *_currentButton;
    NSArray *_fullTree;
    FetchTrait *_moreTrait;

    
    IBOutlet UIView *placeholderView;
    BlenderComponent *_blenderComp;
    
    
}
@property (strong, nonatomic) AppsCollectionView *acvProp;
@property (strong, nonatomic) IBOutlet UICollectionView *appsCollectionView;

- (id)initWithTemplate:(CheckerBoardTemplate*) cbTemplate;
- (id)initWithApp:(FetchApp*) app;
- (id)initWithTrait:(FetchTrait*) trait;
- (void)unloadJunk;


@end
