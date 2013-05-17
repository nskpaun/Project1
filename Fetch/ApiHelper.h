//
//  ApiHelper.h
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SearchResult.h"
#import "AsyncAppsLoader.h"

@interface ApiHelper : NSObject {
    @private
    NSMutableData* _receivedData;
    void (^ callbackBlock)(SearchResult *response);
    NSString *_params;
}

@property (copy, nonatomic) NSMutableData* responseData;

-(void) postToUrl: (NSString*) url withParams: (NSString*) params
     withCallback: (void(^) (SearchResult* response)) callback withPage:(int)p;

-(ApiHelper*) init;

@end
