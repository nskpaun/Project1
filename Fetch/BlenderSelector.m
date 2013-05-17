//
//  BlenderSelector.m
//  Fetch
//
//  Created by Nathan Spaun on 2/1/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "BlenderSelector.h"

@implementation BlenderSelector

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithArray:(NSArray *)traits withFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if (self) {
        NSMutableArray *traitViews = [[NSMutableArray alloc] init];
        for ( NSString *t in traits ) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,100 , 20)];
            UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
            [tv setText: t];
            [v addSubview:tv];
            [traitViews addObject:v];
        }
        
        subviewsArray = traitViews;
    }
    return self;
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
