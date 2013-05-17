//
//  AsyncAppsLoader.h
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiHelper.h"

@interface AsyncAppsLoader : NSObject

+(void)loadApps:(BOOL*)post withPath:(NSString*)path withCallback: (void(^) (SearchResult* response)) callback withPage:(int)p;

@end
