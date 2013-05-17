//
//  AsyncBlenderLoader.m
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "AsyncBlenderLoader.h"

@implementation AsyncBlenderLoader

+(void)loadApps:(BOOL*)post withApp:(FetchApp*)app withCallback: (void(^) (SearchResult* response)) callback withPage:(int) p {
    NSString *params = [NSString stringWithFormat:@"&miniBlend=true&similarAppPname=%@&",app.packagename];
    
    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
}

+(void)loadApps:(BOOL*)post withTemplateId:(NSString*)templateId withPage:(int) p
{
    NSString *params = [NSString stringWithFormat:@"templateId=%@&miniBlend=true&",templateId];
    void (^ blenderLoaderCallback)(SearchResult*) = ^(SearchResult* response) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:response.apps.count];
        for ( FetchApp *app in response.apps) {
            [array addObject:app.title];
            NSLog(app.title);
        }

    };
    
    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:blenderLoaderCallback withPage:p];
};

+(void)loadApps:(BOOL*)post withTemplateId:(NSString*)templateId withCallback:(void(^) (SearchResult* response))callback withPage:(int)p
{
    NSString *params = [NSString stringWithFormat:@"templateId=%@&miniBlend=true&",templateId];
    
    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
};

+(void)loadApps:(BOOL*)post withParamString:(NSString*)params withCallback:(void(^) (SearchResult* response))callback withPage:(int)p
{

    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
};

+(void)loadApps:(BOOL*)post withTraitIds:(NSString*)traitIds withCallback:(void(^) (SearchResult* response))callback withPage:(int)p
{
    NSString *params = [NSString stringWithFormat:@"nodeIds=%@&miniBlend=true&",traitIds];
    
    ApiHelper* helper = [[ApiHelper alloc] init];
    [helper postToUrl:@"/api/json/search/" withParams:params withCallback:callback withPage:p];
};


@end
