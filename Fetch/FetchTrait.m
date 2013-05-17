//
//  FetchTrait.m
//  Fetch
//
//  Created by Nathan Spaun on 2/5/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "FetchTrait.h"
#import "Genome.h"

@implementation FetchTrait
@synthesize name;
@synthesize traitId;
@synthesize family;
@synthesize geneName;
@synthesize selected;

+(NSArray*)traitsFromJson:(NSArray*)json withFamily:(NSString*)family
{
    NSMutableArray *traits = [[NSMutableArray alloc] initWithCapacity:json.count];
    for ( NSDictionary *dict in json ) {
        FetchTrait *trait = [[FetchTrait alloc] init];
        
        trait.name = [dict objectForKey:@"name"];
        trait.family = family;
        trait.traitId = [[dict objectForKey:@"id"] longValue];
        if ( [dict objectForKey:@"selected"] ) trait.selected = YES;

        [traits addObject: trait];
    }
    return traits;
}

+(NSArray*)traitsFromJson:(NSArray*)json
{
    NSMutableArray *traits = [[NSMutableArray alloc] initWithCapacity:json.count];
    for ( NSDictionary *dict in json ) {
        FetchTrait *trait = [[FetchTrait alloc] init];
        
        trait.name = [dict objectForKey:@"name"];
        trait.family = [dict objectForKey:@"geneFamily"];
        trait.traitId = [[dict objectForKey:@"id"] longValue];
        trait.geneName = [dict objectForKey:@"geneName"];
        if ( [dict objectForKey:@"selected"] ) trait.selected = YES;
        
        [traits addObject: trait];
    }
    return traits;
}

+(NSArray*)traitFromJson:(NSDictionary*)dict withFamily:(NSString*)family
{
    FetchTrait *trait = [[FetchTrait alloc] init];
    
    trait.name = [dict objectForKey:@"name"];
    trait.family = family;
    trait.traitId = [[dict objectForKey:@"id"] longValue];
    if ( [dict objectForKey:@"selected"] ) trait.selected = YES;
    
    return trait;
    
}

+(FetchTrait*)shootTrait
{
    FetchTrait *trait = [[FetchTrait alloc] init];
    
    trait.name = @"SHOOT";
    trait.family = themeFamily;
    trait.traitId = 6859;
    
    return trait;
}

+(FetchTrait*)tacticsTrait
{
    FetchTrait *trait = [[FetchTrait alloc] init];
    
    trait.name = @"TACTICS - STRATEGY";
    trait.family = skillFamily;
    trait.traitId = 8584;
    
    return trait;
}

@end
