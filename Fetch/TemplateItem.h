//
//  TemplateItem.h
//  Fetch
//
//  Created by Nathan Spaun on 3/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckerBoardTemplate.h"

@interface TemplateItem : UICollectionViewCell {
    NSArray *_configured;
}

@property (strong, nonatomic) IBOutlet UIImageView *templateImageView;
@property (strong, nonatomic) IBOutlet UILabel *templateNameLabel;
@property (strong, nonatomic) UIView *templateTraitContainer;

-(void)configureWithTemplate:(CheckerBoardTemplate*)cbTemplate;

@end
