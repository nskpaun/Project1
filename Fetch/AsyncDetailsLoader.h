//
//  AsyncDetailsLoader.h
//  Fetch
//
//  Created by Nathan Spaun on 4/10/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"
#import "FetchApp.h"

@interface AsyncDetailsLoader : NSObject

+(void)loadApp:(FetchApp*)app withCallback:(void(^) (SearchResult* response))callback;

@end
