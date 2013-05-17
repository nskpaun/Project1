//
//  FetchApp.m
//  Fetch
//
//  Created by Nathan Spaun on 1/24/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "FetchApp.h"

@implementation FetchApp
@synthesize title;
@synthesize packagename;
@synthesize screenShotUrls;
@synthesize iconUrl;
@synthesize appType;
@synthesize priceMicros;
@synthesize description;
@synthesize traits;
@synthesize rating;
@synthesize ratingCount;

+(NSArray*)appsFromJson:(NSArray*)jsonArray {
    
    NSMutableArray *apps = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    
    for ( NSDictionary *dict in jsonArray) {
        FetchApp *app = [self appFromJson:dict];
        
        [apps addObject:app];
    }
    
    return apps;
}

+(FetchApp*)appFromJson:(NSDictionary*)dict
{
    FetchApp *app = [[FetchApp alloc] init];
    
    app.title = [dict objectForKey:@"title"];
    app.packagename = [dict objectForKey:@"packageName"];
    app.screenShotUrls = [dict objectForKey:@"screenshots"];
    app.iconUrl = [dict objectForKey:@"iconUrl"];
    app.appType = [dict objectForKey:@"appType"];
    app.priceMicros = [[dict objectForKey:@"priceMicros"] integerValue];
    app.description = [dict objectForKey:@"internalDescription"];
    if ( !app.description ) {
        app.description = [dict objectForKey:@"description"];
    }
    app.traits = [dict objectForKey:@"traits"];
    app.rating = [[dict objectForKey:@"rating"] floatValue];
    app.ratingCount = [[dict objectForKey:@"ratingCount"] integerValue];
    app.relevancyTraits = [dict objectForKey:@"traitsRelevancy"];
    
    return app;
}

+(NSArray*)appsFromIHA:(NSArray*)appDictionaries {
    
    NSMutableArray *apps = [[NSMutableArray alloc] initWithCapacity:appDictionaries.count];
    
    for (NSDictionary *dict in appDictionaries) {
        FetchApp *app = [[FetchApp alloc] init];
        
        app.title = [dict objectForKey:@"trackName"];
        app.packagename = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"trackId"] integerValue] ];
        app.screenShotUrls = [dict objectForKey:@"screenshotUrls"];
        app.iconUrl = [dict objectForKey:@"artworkUrl100"];
        NSArray *genres = [dict objectForKey:@"genreIds"];
        if ( [genres containsObject:@"6014"] ) {
            app.appType = @"GAME";
        } else {
            app.appType = @"APPLICATION";
        }
        app.priceMicros = [[dict objectForKey:@"price"] integerValue];
        app.description = [dict objectForKey:@"description"];
        
        [apps addObject:app];
    }
    
    return apps;
}

@end
