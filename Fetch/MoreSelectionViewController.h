//
//  MoreSelectionViewController.h
//  Fetch
//
//  Created by Nathan Spaun on 3/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchTrait.h"

@interface MoreSelectionViewController : UITableViewController
{
    NSArray *_genomes;
    void(^ _morePillCallback) (FetchTrait *trait);
    FetchTrait* _moreTrait;
}

- (id)initWithGenomes:(NSArray*)genomes withCallback:(void(^) (FetchTrait* trait))callback withMoreTrait:(FetchTrait*)moreTrait;

@end
