//
//  CheckerBoardTemplate.h
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckerBoardTemplate : NSObject {

}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *templateId;
@property (nonatomic, copy) NSString *traitIds;
@property (nonatomic, copy) NSString *traitNames;
@property (nonatomic, copy) NSString *familyNames;
@property (nonatomic, strong) UIImage *image;

+(NSArray*)defaultTemplates;
+(CheckerBoardTemplate*)scifiTemplate;

@end
