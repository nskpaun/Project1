//
//  CheckerBoardTemplate.m
//  Fetch
//
//  Created by Nathan Spaun on 1/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "CheckerBoardTemplate.h"

@implementation CheckerBoardTemplate

+(NSArray*)defaultTemplates
{
    int capacity = 2;
    NSMutableArray *tArray = [[NSMutableArray alloc] initWithCapacity:capacity];
    
    CheckerBoardTemplate *template = [[CheckerBoardTemplate alloc] init];
    template.name = @"3D Sci-Fi Racing";
    template.traitIds = @"6893,15773,6870";
    template.traitNames = @"3D Graphics;SciFi;Drive";
    template.familyNames = @"Theme;Visual;Theme";
    template.image = [UIImage imageNamed:@"games_3d_scifi"];
    template.templateId = @"20222";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Role-Playing (RPG)";
    template.traitIds = @"12855,9218,6892";
    template.traitNames = @"Fantasy;Upgrades & Skill Trees;Large Playing Area";
    template.familyNames = @"Theme;Theme;Interaction";
    template.image = [UIImage imageNamed:@"games_rpg"];
    template.templateId = @"20240";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Destruction Physics";
    template.traitIds = @"12854,6874";
    template.traitNames = @"Play w/ Physics;Destroy";
    template.familyNames = @"Skills;Theme";
    template.image = [UIImage imageNamed:@"games_destruction_physics"];
    template.templateId = @"20260";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Amazing Graphics";
    template.traitIds = @"15759";
    template.traitNames = @"Illustrative";
    template.familyNames = @"Visual";
    template.image = [UIImage imageNamed:@"games_amazing_graphics"];
    template.templateId = @"20246";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Undead Rising";
    template.traitIds = @"6903,6859";
    template.traitNames = @"Horror;Shoot";
    template.familyNames = @"Theme;Theme";
    template.image = [UIImage imageNamed:@"games_undead_rising"];
    template.templateId = @"20244";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"First-Person Shooter";
    template.traitIds = @"6919,6859";
    template.traitNames = @"1st Person;Shoot";
    template.familyNames = @"Visual;Theme";
    template.image = [UIImage imageNamed:@"games_fps"];
    template.templateId = @"20251";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Brain Food";
    template.traitIds = @"16426";
    template.traitNames = @"Brain-Puzzle";
    template.familyNames = @"Theme";
    template.image = [UIImage imageNamed:@"games_brain_food"];
    template.templateId = @"20263";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"War Games";
    template.traitIds = @"6898,8584,6839";
    template.traitNames = @"Military;Strategy;Complex";
    template.familyNames = @"Theme;Skills;Skills";
    template.image = [UIImage imageNamed:@"games_war"];
    template.templateId = @"20254";
    
    [tArray addObject:template];
    
    template = [[CheckerBoardTemplate alloc] init];
    template.name = @"Tilting Games";
    template.traitIds = @"6810";
    template.traitNames = @"Tilting";
    template.familyNames = @"Interaction";
    template.image = [UIImage imageNamed:@"games_tilting"];
    template.templateId = @"20260";
    
    [tArray addObject:template];

    return tArray;
}

+(CheckerBoardTemplate*)scifiTemplate
{
    CheckerBoardTemplate *template = [[CheckerBoardTemplate alloc] init];
    template.name = @"3D Sci-Fi Racing";
    template.traitIds = @"6893,15773,6870";
    template.traitNames = @"3D Graphics;SciFi;Drive";
    template.familyNames = @"Theme;Visual;Theme";
    template.image = [UIImage imageNamed:@"games_3d_scifi"];
    template.templateId = @"20222";
    
    return template;
}


@end
