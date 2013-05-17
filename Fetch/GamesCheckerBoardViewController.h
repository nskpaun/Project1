//
//  GamesCheckerBoardViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppsCollectionView.h"
#import "BlenderViewController.h"

@interface GamesCheckerBoardViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    NSMutableArray *_templates;
    UIViewController *currentViewController;
    IBOutlet UIView *placeholderView;
    BlenderViewController *_blenderVC;
    UIViewController *_selfVC;
    IBOutlet UIImageView *colorbar;
    IBOutlet UIView *alphaScreen;
    
    BOOL first;
    

}

@property (strong, nonatomic) IBOutlet UICollectionView *templateCollectionView;


- (id)init;

@end
