//
//  DetailsViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 3/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchApp.h"
#import "PhotoSet.h"
#import <Three20/Three20.h>
#import "PPRatingBar.h"

@interface DetailsViewController : UIViewController {
    FetchApp *_app;
    PhotoSet *_photoSet;
    TTPhotoViewController *_photoVC;
    IBOutlet PPRatingBar *ratingBar;
    IBOutlet UIButton *similarButton;
}

@property (strong, nonatomic) IBOutlet UIScrollView *photoScroll;
@property (strong, nonatomic) IBOutlet UIImageView *iconThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *appNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIWebView *installButton;
@property (strong, nonatomic) IBOutlet UITextView *description;

@property (strong, nonatomic) IBOutlet UIView *interactionView;
@property (strong, nonatomic) IBOutlet UIView *themeView;
@property (strong, nonatomic) IBOutlet UIView *visualView;
@property (strong, nonatomic) IBOutlet UIView *skillView;


- (id)initWithApp:(FetchApp*)app;

@end
