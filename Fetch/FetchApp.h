//
//  FetchApp.h
//  Fetch
//
//  Created by Nathan Spaun on 1/24/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchApp : NSObject

@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *packagename;
@property (strong, nonatomic) NSArray *screenShotUrls;
@property (nonatomic, copy) NSString  *iconUrl;
@property (nonatomic, copy) NSString  *appType;
@property (nonatomic)       NSInteger *priceMicros;
@property (nonatomic, copy) NSString  *description;
@property (nonatomic, copy) NSString  *traits;
@property (nonatomic, copy) NSString  *relevancyTraits;
@property (nonatomic)       float      rating;
@property (nonatomic)       int        ratingCount;


+(NSArray*)appsFromJson:(NSArray*)jsonArray;
+(NSArray*)appsFromIHA:(NSArray*)appDictionaries;
+(FetchApp*)appFromJson:(NSDictionary*)dict;

@end
