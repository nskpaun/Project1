//
//  SearchResult.m
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "SearchResult.h"
#import "Genome.h"

@implementation SearchResult

@synthesize apps;
@synthesize app;
@synthesize genomes;
@synthesize traits;

-(SearchResult*)initWithJson:(NSDictionary*)json
{

    NSArray *j2 = [[json objectForKey:@"apps"] objectForKey:@"items"];
    if(j2)apps = [FetchApp appsFromJson:j2];
    
    j2 = [json objectForKey:@"traits"];
    
    if(j2)traits = [FetchTrait traitsFromJson:j2];
    
    j2 = [[json objectForKey:@"miniBlenderDefinition"] objectForKey:@"genes"];
    
    if(j2)genomes = [Genome genomesFromJson:j2];
    
    NSDictionary *j3 = [[json objectForKey:@"miniBlenderDefinition"] objectForKey:@"app"];
    
    if(j3)app = [FetchApp appFromJson:j3];
    
    j3 = [json objectForKey:@"app"];
    
    if(j3)app = [FetchApp appFromJson:j3];
    
    return self;
}

@end
