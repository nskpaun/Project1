//
//  AsyncDetailsLoader.m
//  Fetch
//
//  Created by Nathan Spaun on 4/10/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AsyncDetailsLoader.h"
#import "ApiHelper.h"

@implementation AsyncDetailsLoader

+(void)loadApp:(FetchApp*)app withCallback:(void(^) (SearchResult* response))callback
{
    ApiHelper* helper = [[ApiHelper alloc] init];
    NSString *params = [NSString stringWithFormat:@"pname=%@&includeApp=true&genes=true",app.packagename];
    [helper postToUrl:@"/api/json/comments/list" withParams:params withCallback:callback withPage:0];
}

@end
