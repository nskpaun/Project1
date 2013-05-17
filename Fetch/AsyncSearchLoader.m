//
//  AsyncSearchLoader.m
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AsyncSearchLoader.h"
#import "ApiHelper.h"

@implementation AsyncSearchLoader

+(void)loadApps:(BOOL*)post withQuery:(NSString*)query withCallback:(void(^) (SearchResult* response))callback withPage:(int)p
{
    NSString *params = [NSString stringWithFormat:@"q=%@&",query];
    
    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
}

@end
