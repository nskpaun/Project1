//
//  AppsCollectionView.h
//  Fetch
//
//  Created by Nathan Spaun on 2/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckerBoardTemplate.h"
#import "BlenderComponent.h"
#import "DetailsViewController.h"

@interface AppsCollectionView : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *appsArray;
    NSInteger *currentPage;
    NSString *_params;
    UICollectionView *_acv;
    
    UIBarButtonItem *_oldItem;
    
    UIViewController *currentViewController;
    DetailsViewController *_detailsVC;
    UIViewController *_selfVC;
    UIView *placeholderView;
    CGPoint scrollPoint;
}

@property (nonatomic,strong) BlenderComponent *blenderComp;
@property (nonatomic) BOOL noHeader;

-(id)initWithApps:(NSArray*)apps withParams:(NSString*)params withCollectionView:(UICollectionView*)acv withPHView:(UIView*)phView withBlenderVC:(UIViewController*)bvc;
-(void)setApps:(NSArray*)apps;
@end
