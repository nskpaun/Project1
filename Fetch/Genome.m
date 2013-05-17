//
//  Genome.m
//  Fetch
//
//  Created by Nathan Spaun on 2/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "Genome.h"
#import "FetchTrait.h"
#import "Fetch.h"

@implementation Genome
@synthesize name;
@synthesize family;
@synthesize traits;
@synthesize genomeId;

NSString const *BLENDER_RESULTS = @"{\"status\":\"success\",\"genesTree\":[{\"id\":16424,\"name\":\"CATEGORY\",\"family\":\"THEME\",\"traits\":[{\"id\":16425,\"name\":\"Action-Adventure\"},{\"id\":16426,\"name\":\"Brain-Puzzle\"},{\"id\":16427,\"name\":\"Strategy-Simulation\"},{\"id\":16428,\"name\":\"Boards-Cards-Casino\"}]},{\"id\":6809,\"name\":\"CONTROLS\",\"family\":\"INTERACTION\",\"traits\":[{\"id\":6812,\"name\":\"Game Controller\"},{\"id\":6914,\"name\":\"Simple Controls\"},{\"id\":6811,\"name\":\"Tapping\"},{\"id\":6810,\"name\":\"Tilting\"},{\"id\":6852,\"name\":\"Swiping\"},{\"id\":7355,\"name\":\"Flicking\"},{\"id\":8454,\"name\":\"Drawing\"},{\"id\":23193,\"name\":\"Use Keyboard\"}]},{\"id\":15771,\"name\":\"2D / 3D\",\"family\":\"VISUAL\",\"traits\":[{\"id\":15772,\"name\":\"2D\"},{\"id\":15773,\"name\":\"3D\"}]},{\"id\":6823,\"name\":\"MULTIPLAYER OPTIONS\",\"family\":\"INTERACTION\",\"traits\":[{\"id\":6832,\"name\":\"Real-Time Multiplayer\"},{\"id\":9860,\"name\":\"Turn-Based Multiplayer\"},{\"id\":6833,\"name\":\"MMO\"},{\"id\":6831,\"name\":\"Single-Device Multiplayer\"},{\"id\":6830,\"name\":\"Multiplayer over Bluetooth or Wi-fi\"},{\"id\":6834,\"name\":\"Non-Real-Time Social Features\"},{\"id\":15976,\"name\":\"Player vs. Player\"}]},{\"id\":6891,\"name\":\"SUBJECTS\",\"family\":\"THEME\",\"traits\":[{\"id\":12590,\"name\":\"Leisure\"},{\"id\":6892,\"name\":\"Fantasy\"},{\"id\":6898,\"name\":\"Military\"},{\"id\":6902,\"name\":\"Martial Arts\"},{\"id\":6903,\"name\":\"Horror\"},{\"id\":6893,\"name\":\"Sci-Fi\"},{\"id\":6953,\"name\":\"Animals\"},{\"id\":15981,\"name\":\"Monsters\"},{\"id\":6911,\"name\":\"Aircraft\"},{\"id\":6910,\"name\":\"Cars, bikes, etc.\"},{\"id\":16029,\"name\":\"Boats, subs, etc.\"},{\"id\":9239,\"name\":\"Treasure\"},{\"id\":6904,\"name\":\"Crime\"},{\"id\":15764,\"name\":\"Business\"},{\"id\":10134,\"name\":\"Casino\"},{\"id\":14570,\"name\":\"Construction\"},{\"id\":7357,\"name\":\"Educational\"},{\"id\":7929,\"name\":\"Food\"},{\"id\":9217,\"name\":\"Blocks and shapes\"},{\"id\":6899,\"name\":\"Historical\"},{\"id\":7261,\"name\":\"Holiday\"},{\"id\":10512,\"name\":\"Logic\"},{\"id\":7826,\"name\":\"Pop Culture\"},{\"id\":6912,\"name\":\"Music\"},{\"id\":6961,\"name\":\"Mystery\"},{\"id\":6901,\"name\":\"Pirates\"},{\"id\":6900,\"name\":\"Prehistorical\"},{\"id\":7260,\"name\":\"Religion\"},{\"id\":6954,\"name\":\"Science\"},{\"id\":6896,\"name\":\"Sports\"},{\"id\":12662,\"name\":\"Trivia\"},{\"id\":10781,\"name\":\"Everyday Life\"},{\"id\":6897,\"name\":\"Western\"},{\"id\":12663,\"name\":\"Wordplay\"}]},{\"id\":6816,\"name\":\"GRAPHIC STYLE\",\"family\":\"VISUAL\",\"traits\":[{\"id\":6854,\"name\":\"Cartoony\"},{\"id\":6856,\"name\":\"Pixellated\"},{\"id\":15759,\"name\":\"Detailed\"},{\"id\":6855,\"name\":\"Realistic Visuals\"},{\"id\":8580,\"name\":\"Anime\"},{\"id\":6983,\"name\":\"Icons\"},{\"id\":6857,\"name\":\"Black and White\"},{\"id\":6853,\"name\":\"Wireframes\"},{\"id\":15760,\"name\":\"Semi-realistic\"},{\"id\":6998,\"name\":\"Augmented Reality\"},{\"id\":6858,\"name\":\"Text\"}]},{\"id\":15751,\"name\":\"POINT OF VIEW\",\"family\":\"VISUAL\",\"traits\":[{\"id\":6919,\"name\":\"1st Person\"},{\"id\":6817,\"name\":\"3rd Person\"},{\"id\":6908,\"name\":\"Side View\"},{\"id\":15758,\"name\":\"Top-down View\"},{\"id\":15770,\"name\":\"Angled View\"},{\"id\":16263,\"name\":\"Front View\"}]},{\"id\":6825,\"name\":\"COMPLEXITY\",\"family\":\"SKILLS\",\"traits\":[{\"id\":7023,\"name\":\"Simple\"},{\"id\":6916,\"name\":\"Average Complexity\"},{\"id\":6839,\"name\":\"Complex\"}]},{\"id\":6905,\"name\":\"PLAYING AREA\",\"family\":\"INTERACTION\",\"traits\":[{\"id\":15750,\"name\":\"Board\"},{\"id\":6906,\"name\":\"Small Area\"},{\"id\":9218,\"name\":\"Large Area\"},{\"id\":15774,\"name\":\"3D World\"},{\"id\":6907,\"name\":\"Always Scrolling\"}]},{\"id\":6818,\"name\":\"GAME SPEED\",\"family\":\"INTERACTION\",\"traits\":[{\"id\":6819,\"name\":\"Fast\"},{\"id\":6890,\"name\":\"Normal Speed\"},{\"id\":7026,\"name\":\"Slow\"},{\"id\":6820,\"name\":\"In Turns\"}]},{\"id\":6822,\"name\":\"ACTIONS\",\"family\":\"THEME\",\"traits\":[{\"id\":6859,\"name\":\"Shoot\"},{\"id\":7294,\"name\":\"Fight\"},{\"id\":14448,\"name\":\"Special Powers\"},{\"id\":6882,\"name\":\"Throw Objects\"},{\"id\":6881,\"name\":\"Move Objects\"},{\"id\":6860,\"name\":\"Jump\"},{\"id\":6866,\"name\":\"Run\"},{\"id\":6878,\"name\":\"Dodge\"},{\"id\":6871,\"name\":\"Fly\"},{\"id\":6861,\"name\":\"Slice\"},{\"id\":6870,\"name\":\"Drive\"},{\"id\":6883,\"name\":\"Swim\"},{\"id\":6886,\"name\":\"Climb\"},{\"id\":6867,\"name\":\"Choose\"},{\"id\":6885,\"name\":\"Bet\"},{\"id\":6879,\"name\":\"Match\"},{\"id\":6872,\"name\":\"Set Objects\"},{\"id\":12606,\"name\":\"Do Tricks\"},{\"id\":21331,\"name\":\"Balance\"}]},{\"id\":15980,\"name\":\"OBJECTIVES\",\"family\":\"THEME\",\"traits\":[{\"id\":6918,\"name\":\"Solve Puzzle\"},{\"id\":6980,\"name\":\"Explore\"},{\"id\":6874,\"name\":\"Destroy \"},{\"id\":6876,\"name\":\"Kill or KO\"},{\"id\":15978,\"name\":\"Stacking\"},{\"id\":15985,\"name\":\"Race\"},{\"id\":6868,\"name\":\"Collect Items\"},{\"id\":6865,\"name\":\"Play a Sport\"},{\"id\":6913,\"name\":\"Duel\"},{\"id\":6863,\"name\":\"Engineer\"},{\"id\":10673,\"name\":\"Develop Avatar or World\"},{\"id\":6884,\"name\":\"Fish or Hunt\"},{\"id\":8582,\"name\":\"Survive Distance or Time \"},{\"id\":6887,\"name\":\"Spot Hidden Objects\"},{\"id\":6862,\"name\":\"Buy or Sell\"},{\"id\":15260,\"name\":\"Defend\"},{\"id\":6873,\"name\":\"Direct or Guide\"},{\"id\":7364,\"name\":\"Capture\"},{\"id\":10895,\"name\":\"Raise, Parent, Breed\"},{\"id\":6956,\"name\":\"Play with numbers\"},{\"id\":6889,\"name\":\"Spell (Word Games)\"},{\"id\":6982,\"name\":\"Question and Answer\"},{\"id\":6877,\"name\":\"Sketch, Illustrate\"},{\"id\":7738,\"name\":\"Play with Cards or Dice\"}]},{\"id\":6985,\"name\":\"MENTAL SKILLS\",\"family\":\"SKILLS\",\"traits\":[{\"id\":8584,\"name\":\"Strategy\"},{\"id\":12854,\"name\":\"Play w/Physics\"},{\"id\":6988,\"name\":\"Use Resources\"},{\"id\":7028,\"name\":\"Identify Patterns\"},{\"id\":6986,\"name\":\"Play w/Space\"},{\"id\":6989,\"name\":\"Play Odds\"},{\"id\":6990,\"name\":\"Math\"},{\"id\":15775,\"name\":\"Play w/Time\"},{\"id\":6993,\"name\":\"Language\"},{\"id\":6991,\"name\":\"Use Logic\"},{\"id\":7768,\"name\":\"Creativity\"},{\"id\":6995,\"name\":\"Trivia\"},{\"id\":6994,\"name\":\"Memory\"},{\"id\":6992,\"name\":\"Negotiation\"}]},{\"id\":7013,\"name\":\"CONTROL SKILLS\",\"family\":\"SKILLS\",\"traits\":[{\"id\":7018,\"name\":\"Precise Control\"},{\"id\":7016,\"name\":\"Fast Reflexes\"},{\"id\":7014,\"name\":\"Aiming\"},{\"id\":7015,\"name\":\"Timing\"},{\"id\":12850,\"name\":\"Button Mashing\"}]},{\"id\":6827,\"name\":\"ENHANCEMENTS\",\"family\":\"THEME\",\"traits\":[{\"id\":6923,\"name\":\"Power-Ups\"},{\"id\":15974,\"name\":\"Boss Battles\"},{\"id\":6947,\"name\":\"Physics\"},{\"id\":12855,\"name\":\"Upgrades\"},{\"id\":6948,\"name\":\"Great Music\"},{\"id\":8450,\"name\":\"Customize Avatar\"},{\"id\":6844,\"name\":\"Complex Story\"},{\"id\":6917,\"name\":\"Leaderboards\"},{\"id\":6950,\"name\":\"Unique Game Play\"},{\"id\":22863,\"name\":\"User-generated Content\"}]}]}";

const NSString* themeFamily = @"Theme";
const NSString* skillFamily = @"Skills";
const NSString* interactionFamily = @"Interaction";
const NSString* visualFamily = @"Visual";

+(NSArray*)genomesFromJson:(NSArray*)jsonArray
{
    NSMutableArray *genomes = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    
    for ( NSDictionary *dict in jsonArray) {
        Genome *genome = [[Genome alloc] init];
        
        genome.name = [dict objectForKey:@"name"];
        genome.family = [dict objectForKey:@"family"];
        genome.genomeId = [dict objectForKey:@"id"];
        genome.traits = [FetchTrait traitsFromJson:[dict objectForKey:@"traits"] withFamily:genome.family];
        [genomes addObject:genome ];
    }
    
    return genomes;
}

+(Genome*)genomeFromJson:(NSDictionary*)jsonDict
{
    Genome *genome = [[Genome alloc] init];
    
    genome.name = [jsonDict objectForKey:@"name"];
    genome.family = [jsonDict objectForKey:@"family"];
    genome.genomeId = [jsonDict objectForKey:@"id"];
    genome.traits = [FetchTrait traitsFromJson:[jsonDict objectForKey:@"traits"] withFamily:genome.family];
    return genome;
}

+(UIColor*)colorForFamily:(NSString*)familyName
{
    familyName = [[familyName lowercaseString] capitalizedString];
    if ( [familyName isEqualToString: themeFamily] ) {
        return [Fetch colorWithHexString: COLOR_GREEN];
    } else if ( [familyName isEqualToString: skillFamily] ) {
        return [Fetch colorWithHexString: COLOR_PURPLE];
    } else if ( [familyName isEqualToString: visualFamily] ) {
        return [Fetch colorWithHexString: COLOR_RED];
    } else if ( [familyName isEqualToString: interactionFamily] ) {
        return [Fetch colorWithHexString: COLOR_ORANGE];
    }
    
    return nil;
}

+(NSArray*)fullTree
{
    NSError *error;
    NSData* data = [BLENDER_RESULTS dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return[Genome genomesFromJson:[json objectForKey:@"genesTree"]];
}

+(NSString*)familyForTrait:(NSString*)trait
{
    for ( Genome *g in [Genome fullTree] ) {
        for ( FetchTrait *t in g.traits ) {
            if ( [[trait uppercaseString] isEqualToString:[t.name uppercaseString]] ) {
                return [[g.family lowercaseString] capitalizedString];
            }
        }
    }
    
    return nil;
    
    
}

-(BOOL)containsTrait:(FetchTrait*)trait {
    for ( Genome *g in [Genome fullTree] ) {
        for ( FetchTrait *t in g.traits ) {
            if ( [[trait.name uppercaseString] isEqualToString:[t.name uppercaseString]] ) {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
