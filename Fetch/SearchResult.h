//
//  SearchResult.h
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchApp.h"

@interface SearchResult : NSObject

@property (nonatomic, strong) FetchApp *app;
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSArray *genomes;
@property (nonatomic, strong) NSArray *traits;
@property (nonatomic, copy) NSString *params;

-(SearchResult*)initWithJson:(NSDictionary*)json;

@end
