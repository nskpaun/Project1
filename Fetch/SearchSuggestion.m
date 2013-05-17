//
//  SearchSuggestion.m
//  Fetch
//
//  Created by Nathan Spaun on 3/27/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "SearchSuggestion.h"
#import "FetchTrait.h"
#import "CheckerBoardTemplate.h"
#import "Genome.h"

@implementation SearchSuggestion

@synthesize type;
@synthesize supplementaryView;
@synthesize title;
@synthesize extra;

+(NSArray*)defaultSearchSuggestions {
    NSArray *defaultSearches = [[NSArray alloc] init];
    
    SearchSuggestion *search = [[SearchSuggestion alloc] init];
    
    for ( Genome *g in [Genome fullTree] ) {
        for ( FetchTrait *trait in g.traits ) {
            search = [[SearchSuggestion alloc] init];
            search.type = traitSearch;
            search.title = [trait.name uppercaseString];
            search.extra = trait;
            
            defaultSearches = [defaultSearches arrayByAddingObject:search];
        }
    }
    
    for ( CheckerBoardTemplate *temp in [CheckerBoardTemplate defaultTemplates] ) {
        search = [[SearchSuggestion alloc] init];
        
        search.type = templateSearch;
        search.title = [temp.name uppercaseString];
        search.extra = temp;
        
        defaultSearches = [defaultSearches arrayByAddingObject:search];
    }
    
    search = [[SearchSuggestion alloc] init];
    
    search.type = keywordSearch;
    search.title = @"simulation games";
    
    defaultSearches = [defaultSearches arrayByAddingObject:search];
    search = [[SearchSuggestion alloc] init];
    
    search.type = keywordSearch;
    search.title = @"racing games";
    
    defaultSearches = [defaultSearches arrayByAddingObject:search];
    
    search = [[SearchSuggestion alloc] init];
    
    search.type = keywordSearch;
    search.title = @"virtual pets";
    
    defaultSearches = [defaultSearches arrayByAddingObject:search];
    
    
    return defaultSearches;
    
}

@end
