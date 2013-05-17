//
//  Fetch.h
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define FetchAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface FetchSingleton : NSObject

extern const NSString* COLOR_ORANGE;
extern const NSString* COLOR_GREEN;
extern const NSString* COLOR_PURPLE;
extern const NSString* COLOR_RED;
extern const NSString* COLOR_PALE_GRAY;
extern const NSString* COLOR_LIGHT_GRAY;
extern const NSString* COLOR_MEDIUM_GRAY;
extern const NSString* COLOR_MEDIUM_DARK_GRAY;
extern const NSString* COLOR_DARK_GRAY;
extern const NSString* COLOR_BLUE;



- (NSString *)generateUUIDString;
- (BOOL)directoryExistsAtAbsolutePath:(NSString*)filename;
- (UIColor*)colorWithHexString:(NSString*)hex;
- (UIBarButtonItem*)customNavButton;

@end

extern FetchSingleton *Fetch;