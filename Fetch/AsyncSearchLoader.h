//
//  AsyncSearchLoader.h
//  Fetch
//
//  Created by Nathan Spaun on 3/26/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchResult.h"

@interface AsyncSearchLoader : NSObject

+(void)loadApps:(BOOL*)post withQuery:(NSString*)query withCallback:(void(^) (SearchResult* response))callback withPage:(int)p;

@end
