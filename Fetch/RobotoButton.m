//
//  RobotoButton.m
//  Fetch
//
//  Created by Nathan Spaun on 4/11/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "RobotoButton.h"

@implementation RobotoButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.titleLabel setFont:[UIFont fontWithName:@"Roboto" size:11]];
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
