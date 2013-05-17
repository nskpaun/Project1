//
//  SearchSuggestion.h
//  Fetch
//
//  Created by Nathan Spaun on 3/27/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>

extern enum SuggestionType {
    traitSearch=1,
    templateSearch=2,
    keywordSearch=3,
    similarSearch=4
} SuggestionType;

@interface SearchSuggestion : NSObject

@property (nonatomic, assign) enum SuggestionType type;
@property (nonatomic, copy) NSString *title;
@property (strong, nonatomic) UIView *supplementaryView;
@property (strong, nonatomic) NSObject *extra;

+(NSArray*)defaultSearchSuggestions;

@end
