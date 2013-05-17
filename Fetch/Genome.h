//
//  Genome.h
//  Fetch
//
//  Created by Nathan Spaun on 2/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchTrait.h"

extern const NSString* themeFamily;
extern const NSString* skillFamily;
extern const NSString* interactionFamily;
extern const NSString* visualFamily;
extern NSString const *BLENDER_RESULTS;

@interface Genome : NSObject

@property (nonatomic, assign) long genomeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *family;
@property (strong, nonatomic) NSArray *traits;

+(NSArray*)genomesFromJson:(NSArray*)json;
+(Genome*)genomeFromJson:(NSDictionary*)jsonDict;
+(UIColor*)colorForFamily:(NSString*)familyName;
+(NSArray*)fullTree;
+(NSString*)familyForTrait:(NSString*)trait;

-(BOOL)containsTrait:(FetchTrait*)trait;

@end
