//
//  AsyncAppsLoader.m
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AsyncAppsLoader.h"

@implementation AsyncAppsLoader

+(void)loadApps:(BOOL*)post withPath:(NSString*)path withCallback: (void(^) (SearchResult* response)) callback withPage:(int)p
{
    ApiHelper* helper = [[ApiHelper alloc] init];
    
    NSString *params = @"&minRating=350&classified=y&type=ALL&maxDollars=0";
    
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
};


@end

