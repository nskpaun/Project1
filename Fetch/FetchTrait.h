//
//  FetchTrait.h
//  Fetch
//
//  Created by Nathan Spaun on 2/5/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchTrait : NSObject

@property (nonatomic, assign) long traitId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *family;
@property (nonatomic, copy) NSString *geneName;
@property (nonatomic, assign) BOOL selected;

+(NSArray*)traitsFromJson:(NSArray*)json withFamily:(NSString*)family;
+(NSArray*)traitFromJson:(NSDictionary*)dict withFamily:(NSString*)family;
+(NSArray*)traitsFromJson:(NSArray*)json;
+(FetchTrait*)shootTrait;
+(FetchTrait*)tacticsTrait;
@end
