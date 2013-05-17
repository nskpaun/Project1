//
//  TemplateItem.m
//  Fetch
//
//  Created by Nathan Spaun on 3/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "TemplateItem.h"
#import "Genome.h"
#import "Fetch.h"

@implementation TemplateItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)configureWithTemplate:(CheckerBoardTemplate*)cbTemplate
{
//    NSInteger *i = 0;
    CGFloat lastSize = 0;
    self.templateTraitContainer = [[UIView alloc] initWithFrame:CGRectMake(5, 95, 140, 25)];
    NSArray *names = [cbTemplate.traitNames componentsSeparatedByString:@";"];
    NSArray *families = [cbTemplate.familyNames componentsSeparatedByString:@";"];
    
    for ( NSInteger i = 0; i < [names count]; i++ ) {
        UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(lastSize, 0, 10, 15)];
        [tLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
        [tLabel setBackgroundColor:[UIColor clearColor]];
        [tLabel setFont: [UIFont systemFontOfSize:11]];
        NSString *name = [names objectAtIndex:i];
        [tLabel setText:name];
        
        [tLabel sizeToFit];
        [self.templateTraitContainer addSubview:tLabel];
        
        UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(lastSize, 18, tLabel.frame.size.width, 3)];
        lastSize = lastSize + tLabel.frame.size.width;
        NSString *family = [families objectAtIndex:i];
        [underLine setBackgroundColor: [Genome colorForFamily:family ]];
        
        [self.templateTraitContainer addSubview:underLine];
        
        if (i < ([names count]-1) ) {
            UILabel *pLabel = [[UILabel alloc] initWithFrame:CGRectMake(lastSize, 0, 10, 15)];
            [pLabel setFont: [UIFont systemFontOfSize:11]];
            [pLabel setText:@" + "];
            [pLabel setTextColor:[Fetch colorWithHexString:COLOR_MEDIUM_GRAY]];
            [pLabel setBackgroundColor:[UIColor clearColor]];
            [pLabel sizeToFit];
            [self.templateTraitContainer addSubview:pLabel];
            lastSize = lastSize + pLabel.frame.size.width;
            [self.templateTraitContainer addSubview:pLabel];
            
        }
    }
    //[self.templateTraitContainer addSubview:blockingView];
    //[self addSubview:self.templateTraitContainer];
    
//    if (lastSize < 140) {
//        CGRect ttCont = self.templateTraitContainer.frame;
//        self.templateTraitContainer.frame = CGRectMake(70-(lastSize/2), ttCont.origin.y, ttCont.size.width, ttCont.size.height);
//        
//    }
//    
//    [self addSubview:self.templateTraitContainer];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
