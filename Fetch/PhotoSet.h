//
//  PhotoSet.h
//  Fetch
//
//  Created by Nathan Spaun on 3/27/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface PhotoSet : TTURLRequestModel <TTPhotoSource> {
    NSString *_title;
    NSArray *_photos;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray *photos;

- (id) initWithTitle:(NSString *)title photos:(NSArray *)photos;

@end
