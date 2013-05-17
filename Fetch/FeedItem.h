//
//  FeedItem.h
//  Fetch
//
//  Created by Nathan Spaun on 2/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRatingBar.h"

@interface FeedItem : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *appTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *screenShotPreview;
@property (strong, nonatomic) IBOutlet UIImageView *iconThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *traitsLabel;
@property (strong, nonatomic) IBOutlet UILabel *traits2Label;
@property (strong, nonatomic) IBOutlet UILabel *traits3Label;
@property (strong, nonatomic) IBOutlet UILabel *traits4Label;
@property (strong, nonatomic) IBOutlet UIButton *installButton;
@property (strong, nonatomic) IBOutlet PPRatingBar *ratingBar;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;


@end
