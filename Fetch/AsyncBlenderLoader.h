//
//  AsyncBlenderLoader.h
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiHelper.h"

@interface AsyncBlenderLoader : NSObject

+(void)loadApps:(BOOL*)post withTemplateId:(NSString*)templateId withCallback: (void(^) (SearchResult* response)) callback withPage:(int) p;
+(void)loadApps:(BOOL*)post withApp:(FetchApp*)app withCallback: (void(^) (SearchResult* response)) callback withPage:(int) p;
+(void)loadApps:(BOOL*)post withTemplateId:(NSString*)templateId withPage:(int)p;
+(void)loadApps:(BOOL*)post withParamString:(NSString*)params withCallback:(void(^) (SearchResult* response))callback withPage:(int)p;
+(void)loadApps:(BOOL*)post withTraitIds:(NSString*)traitIds withCallback:(void(^) (SearchResult* response))callback withPage:(int)p;

@end
